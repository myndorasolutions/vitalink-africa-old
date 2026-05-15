package router

import (
	"time"

	"github.com/gin-gonic/gin"
	"github.com/vitalink-africa/backend/internal/middleware"
	"github.com/vitalink-africa/backend/internal/models"
	"github.com/vitalink-africa/backend/pkg/pagination"
	"github.com/vitalink-africa/backend/pkg/response"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

type registerProviderRequest struct {
	ProviderType  string           `json:"provider_type" binding:"required"`
	DisplayName   string           `json:"display_name" binding:"required"`
	Bio           string           `json:"bio"`
	Location      models.Location  `json:"location"`
	Languages     []string         `json:"languages"`
	CoverageRadiusKm float64       `json:"coverage_radius_km"`
}

func (h *Handler) RegisterProvider(c *gin.Context) {
	var req registerProviderRequest
	if !bindJSON(c, &req) {
		return
	}
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	ctx := c.Request.Context()
	var existing models.Provider
	err := h.a.DB.Collection("providers").FindOne(ctx, bson.M{"user_id": uid}).Decode(&existing)
	if err == nil {
		response.BadRequest(c, "provider_exists", "provider profile already exists")
		return
	}
	if err != mongo.ErrNoDocuments {
		response.Internal(c, "lookup failed")
		return
	}
	now := time.Now().UTC()
	p := models.Provider{
		UserID:             uid,
		ProviderType:       req.ProviderType,
		DisplayName:        req.DisplayName,
		Bio:                req.Bio,
		Location:           req.Location,
		Languages:          req.Languages,
		VerificationStatus: "pending",
		IsActive:           true,
		CreatedAt:          now,
		UpdatedAt:          now,
		CoverageRadiusKm:   req.CoverageRadiusKm,
	}
	res, err := h.a.DB.Collection("providers").InsertOne(ctx, p)
	if err != nil {
		response.Internal(c, "registration failed")
		return
	}
	p.ID = res.InsertedID.(primitive.ObjectID)
	response.Created(c, p)
}

func (h *Handler) ProviderMe(c *gin.Context) {
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	var p models.Provider
	err := h.a.DB.Collection("providers").FindOne(c.Request.Context(), bson.M{"user_id": uid}).Decode(&p)
	if err == mongo.ErrNoDocuments {
		response.NotFound(c, "provider profile not found")
		return
	}
	if err != nil {
		response.Internal(c, "lookup failed")
		return
	}
	response.OK(c, p)
}

func (h *Handler) ListProviders(c *gin.Context) {
	pg := pagination.FromContext(c)
	filter := bson.M{"is_active": true, "verification_status": "verified"}
	if t := c.Query("provider_type"); t != "" {
		filter["provider_type"] = t
	}
	if city := c.Query("city"); city != "" {
		filter["location.city"] = city
	}
	opts := options.Find().SetSkip(pg.Skip).SetLimit(pg.Limit).SetSort(bson.M{"rating": -1})
	cur, err := h.a.DB.Collection("providers").Find(c.Request.Context(), filter, opts)
	if err != nil {
		response.Internal(c, "list failed")
		return
	}
	var list []models.Provider
	if err := cur.All(c.Request.Context(), &list); err != nil {
		response.Internal(c, "decode failed")
		return
	}
	response.OK(c, gin.H{"providers": list, "page": pg.Page, "limit": pg.Limit})
}

type verifyProviderRequest struct {
	Status string `json:"status" binding:"required"` // verified | rejected
	Notes  string `json:"notes"`
}

func (h *Handler) VerifyProvider(c *gin.Context) {
	id, ok := parseObjectID(c, "id")
	if !ok {
		return
	}
	var req verifyProviderRequest
	if !bindJSON(c, &req) {
		return
	}
	if req.Status != "verified" && req.Status != "rejected" {
		response.BadRequest(c, "invalid_status", "status must be verified or rejected")
		return
	}
	ctx := c.Request.Context()
	update := bson.M{"verification_status": req.Status, "updated_at": time.Now().UTC()}
	_, err := h.a.DB.Collection("providers").UpdateOne(ctx, bson.M{"_id": id}, bson.M{"$set": update})
	if err != nil {
		response.Internal(c, "verify failed")
		return
	}
	var p models.Provider
	_ = h.a.DB.Collection("providers").FindOne(ctx, bson.M{"_id": id}).Decode(&p)
	uid, _ := userObjectID(c)
	auditAction(ctx, h, uid, nil, "provider.verified", "provider", id.Hex(), nil, update, c)
	response.OK(c, p)
}

type createServiceRequest struct {
	ServiceType     string `json:"service_type" binding:"required"`
	Title           string `json:"title" binding:"required"`
	Description     string `json:"description"`
	PriceNaira      int64  `json:"price_naira" binding:"required"`
	DurationMinutes int    `json:"duration_minutes"`
}

func (h *Handler) CreateProviderService(c *gin.Context) {
	var req createServiceRequest
	if !bindJSON(c, &req) {
		return
	}
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	ctx := c.Request.Context()
	var provider models.Provider
	if err := h.a.DB.Collection("providers").FindOne(ctx, bson.M{"user_id": uid}).Decode(&provider); err != nil {
		response.NotFound(c, "register as provider first")
		return
	}
	svc := models.ProviderService{
		ProviderID:      provider.ID,
		ServiceType:     req.ServiceType,
		Title:           req.Title,
		Description:     req.Description,
		PriceNaira:      req.PriceNaira,
		DurationMinutes: req.DurationMinutes,
		IsActive:        true,
		AdminApproved:   false,
		CreatedAt:       time.Now().UTC(),
	}
	res, err := h.a.DB.Collection("provider_services").InsertOne(ctx, svc)
	if err != nil {
		response.Internal(c, "create service failed")
		return
	}
	svc.ID = res.InsertedID.(primitive.ObjectID)
	response.Created(c, svc)
}

func (h *Handler) ListProviderServices(c *gin.Context) {
	filter := bson.M{"is_active": true, "admin_approved": true}
	if pid := c.Query("provider_id"); pid != "" {
		id, err := primitive.ObjectIDFromHex(pid)
		if err != nil {
			response.BadRequest(c, "invalid_id", "invalid provider_id")
			return
		}
		filter["provider_id"] = id
	}
	role := middleware.GetRole(c)
	if role != models.RoleAdmin && role != models.RoleSuperAdmin {
		filter["admin_approved"] = true
	}
	cur, err := h.a.DB.Collection("provider_services").Find(c.Request.Context(), filter)
	if err != nil {
		response.Internal(c, "list failed")
		return
	}
	var list []models.ProviderService
	_ = cur.All(c.Request.Context(), &list)
	response.OK(c, gin.H{"services": list})
}

func (h *Handler) ProviderCatalog(c *gin.Context) {
	filter := bson.M{"is_active": true, "admin_approved": true}
	if st := c.Query("service_type"); st != "" {
		filter["service_type"] = st
	}
	cur, err := h.a.DB.Collection("provider_services").Find(c.Request.Context(), filter)
	if err != nil {
		response.Internal(c, "catalog failed")
		return
	}
	var services []models.ProviderService
	_ = cur.All(c.Request.Context(), &services)

	providerIDs := make([]primitive.ObjectID, 0)
	seen := map[primitive.ObjectID]bool{}
	for _, s := range services {
		if !seen[s.ProviderID] {
			seen[s.ProviderID] = true
			providerIDs = append(providerIDs, s.ProviderID)
		}
	}
	var providers []models.Provider
	if len(providerIDs) > 0 {
		pcur, _ := h.a.DB.Collection("providers").Find(c.Request.Context(), bson.M{
			"_id": bson.M{"$in": providerIDs}, "verification_status": "verified", "is_active": true,
		})
		_ = pcur.All(c.Request.Context(), &providers)
	}
	response.OK(c, gin.H{"services": services, "providers": providers})
}
