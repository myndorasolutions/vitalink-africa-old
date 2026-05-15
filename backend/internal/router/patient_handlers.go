package router

import (
	"github.com/gin-gonic/gin"
	"github.com/vitalink-africa/backend/internal/middleware"
	"github.com/vitalink-africa/backend/internal/models"
	"github.com/vitalink-africa/backend/pkg/pagination"
	"github.com/vitalink-africa/backend/pkg/response"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
)

type createPatientRequest struct {
	FullName         string                  `json:"full_name" binding:"required"`
	Age              int                     `json:"age"`
	Gender           string                  `json:"gender"`
	Location         models.Location         `json:"location"`
	Conditions       []string                `json:"conditions"`
	EmergencyContact models.EmergencyContact `json:"emergency_contact"`
}

func (h *Handler) GetPatientMe(c *gin.Context) {
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	p, err := h.a.Patients.FindByUserID(c.Request.Context(), uid)
	if err == mongo.ErrNoDocuments {
		response.NotFound(c, "patient profile not found")
		return
	}
	if err != nil {
		response.Internal(c, "lookup failed")
		return
	}
	response.OK(c, p)
}

func (h *Handler) UpdatePatientMe(c *gin.Context) {
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	ctx := c.Request.Context()
	p, err := h.a.Patients.FindByUserID(ctx, uid)
	if err != nil {
		response.NotFound(c, "patient profile not found")
		return
	}
	c.Params = append(c.Params, gin.Param{Key: "id", Value: p.ID.Hex()})
	h.UpdatePatient(c)
}

func (h *Handler) ListPatients(c *gin.Context) {
	ctx := c.Request.Context()
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	role := middleware.GetRole(c)
	p := pagination.FromContext(c)
	ids, err := h.a.Access.GetAccessiblePatientIDs(ctx, role, uid)
	if err != nil {
		response.Internal(c, "failed to resolve patient access")
		return
	}
	filter := bson.M{"is_active": true}
	if len(ids) > 0 {
		filter["_id"] = bson.M{"$in": ids}
	} else if role != models.RoleAdmin && role != models.RoleSuperAdmin {
		response.OK(c, gin.H{"patients": []models.Patient{}, "page": p.Page, "limit": p.Limit})
		return
	}
	list, err := h.a.Patients.List(ctx, filter, p.Skip, p.Limit)
	if err != nil {
		response.Internal(c, "failed to list patients")
		return
	}
	response.OK(c, gin.H{"patients": list, "page": p.Page, "limit": p.Limit})
}

func (h *Handler) CreatePatient(c *gin.Context) {
	var req createPatientRequest
	if !bindJSON(c, &req) {
		return
	}
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	ctx := c.Request.Context()
	if _, err := h.a.Patients.FindByUserID(ctx, uid); err == nil {
		response.BadRequest(c, "patient_exists", "patient profile already exists")
		return
	} else if err != mongo.ErrNoDocuments {
		response.Internal(c, "lookup failed")
		return
	}
	p := &models.Patient{
		UserID:           uid,
		FullName:         req.FullName,
		Age:              req.Age,
		Gender:           req.Gender,
		Location:         req.Location,
		Conditions:       req.Conditions,
		EmergencyContact: req.EmergencyContact,
		SubscriptionPlan: "free", SubscriptionStatus: "active",
	}
	if err := h.a.Patients.Create(ctx, p); err != nil {
		response.Internal(c, "failed to create patient")
		return
	}
	pid := p.ID
	auditAction(ctx, h, uid, &pid, "patient.created", "patient", p.ID.Hex(), nil, p, c)
	response.Created(c, p)
}

func (h *Handler) GetPatient(c *gin.Context) {
	id, ok := parseObjectID(c, "id")
	if !ok {
		return
	}
	p, ok := h.loadPatient(c, id)
	if !ok {
		return
	}
	if !h.requirePatientAccess(c, p) {
		return
	}
	response.OK(c, p)
}

type updatePatientRequest struct {
	FullName         *string                  `json:"full_name"`
	Age              *int                     `json:"age"`
	Gender           *string                  `json:"gender"`
	Location         *models.Location         `json:"location"`
	Conditions       []string                 `json:"conditions"`
	EmergencyContact *models.EmergencyContact `json:"emergency_contact"`
}

func (h *Handler) UpdatePatient(c *gin.Context) {
	id, ok := parseObjectID(c, "id")
	if !ok {
		return
	}
	p, ok := h.loadPatient(c, id)
	if !ok || !h.requirePatientAccess(c, p) {
		return
	}
	var req updatePatientRequest
	if !bindJSON(c, &req) {
		return
	}
	update := bson.M{}
	if req.FullName != nil {
		update["full_name"] = *req.FullName
	}
	if req.Age != nil {
		update["age"] = *req.Age
	}
	if req.Gender != nil {
		update["gender"] = *req.Gender
	}
	if req.Location != nil {
		update["location"] = *req.Location
	}
	if req.Conditions != nil {
		update["conditions"] = req.Conditions
	}
	if req.EmergencyContact != nil {
		update["emergency_contact"] = *req.EmergencyContact
	}
	if len(update) == 0 {
		response.BadRequest(c, "empty_update", "no fields to update")
		return
	}
	ctx := c.Request.Context()
	if err := h.a.Patients.Update(ctx, id, update); err != nil {
		response.Internal(c, "update failed")
		return
	}
	uid, _ := userObjectID(c)
	pid := id
	auditAction(ctx, h, uid, &pid, "patient.updated", "patient", id.Hex(), p, update, c)
	updated, _ := h.a.Patients.FindByID(ctx, id)
	response.OK(c, updated)
}

func (h *Handler) DeletePatient(c *gin.Context) {
	id, ok := parseObjectID(c, "id")
	if !ok {
		return
	}
	p, ok := h.loadPatient(c, id)
	if !ok || !h.requirePatientAccess(c, p) {
		return
	}
	ctx := c.Request.Context()
	if err := h.a.Patients.Update(ctx, id, bson.M{"is_active": false}); err != nil {
		response.Internal(c, "delete failed")
		return
	}
	uid, _ := userObjectID(c)
	pid := id
	auditAction(ctx, h, uid, &pid, "patient.deactivated", "patient", id.Hex(), p, nil, c)
	noContent(c)
}
