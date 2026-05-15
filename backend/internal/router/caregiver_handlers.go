package router

import (
	"time"

	"github.com/gin-gonic/gin"
	"github.com/vitalink-africa/backend/internal/models"
	"github.com/vitalink-africa/backend/pkg/response"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

type caregiverLinkRequest struct {
	PatientID    string `json:"patient_id" binding:"required"`
	Relationship string `json:"relationship" binding:"required"`
}

func (h *Handler) CaregiverLinkRequest(c *gin.Context) {
	var req caregiverLinkRequest
	if !bindJSON(c, &req) {
		return
	}
	caregiverID, ok := userObjectID(c)
	if !ok {
		return
	}
	patientID, err := primitive.ObjectIDFromHex(req.PatientID)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid patient_id")
		return
	}
	ctx := c.Request.Context()
	if _, err := h.a.Patients.FindByID(ctx, patientID); err == mongo.ErrNoDocuments {
		response.NotFound(c, "patient not found")
		return
	}
	link := models.CaregiverPatient{
		CaregiverUserID: caregiverID,
		PatientID:       patientID,
		ConsentStatus:   "pending",
		Relationship:    req.Relationship,
		CreatedAt:       time.Now().UTC(),
	}
	res, err := h.a.DB.Collection("caregivers_patients").InsertOne(ctx, link)
	if err != nil {
		response.Internal(c, "failed to create link request")
		return
	}
	link.ID = res.InsertedID.(primitive.ObjectID)
	response.Created(c, link)
}

type caregiverConsentRequest struct {
	LinkID  string `json:"link_id" binding:"required"`
	Approve bool   `json:"approve"`
}

func (h *Handler) CaregiverConsent(c *gin.Context) {
	var req caregiverConsentRequest
	if !bindJSON(c, &req) {
		return
	}
	linkID, err := primitive.ObjectIDFromHex(req.LinkID)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid link_id")
		return
	}
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	ctx := c.Request.Context()
	var link models.CaregiverPatient
	if err := h.a.DB.Collection("caregivers_patients").FindOne(ctx, bson.M{"_id": linkID}).Decode(&link); err != nil {
		response.NotFound(c, "link request not found")
		return
	}
	patient, err := h.a.Patients.FindByUserID(ctx, uid)
	if err != nil || patient.ID != link.PatientID {
		response.Forbidden(c, "only the patient can approve caregiver links")
		return
	}
	now := time.Now().UTC()
	update := bson.M{"consent_status": "rejected", "consent_revoked_at": now}
	if req.Approve {
		update = bson.M{"consent_status": "approved", "consent_granted_at": now}
	}
	_, err = h.a.DB.Collection("caregivers_patients").UpdateOne(ctx, bson.M{"_id": linkID}, bson.M{"$set": update})
	if err != nil {
		response.Internal(c, "consent update failed")
		return
	}
	_ = h.a.DB.Collection("caregivers_patients").FindOne(ctx, bson.M{"_id": linkID}).Decode(&link)
	response.OK(c, link)
}

func (h *Handler) CaregiverMyPatients(c *gin.Context) {
	caregiverID, ok := userObjectID(c)
	if !ok {
		return
	}
	ctx := c.Request.Context()
	cur, err := h.a.DB.Collection("caregivers_patients").Find(ctx, bson.M{
		"caregiver_user_id": caregiverID,
		"consent_status":    "approved",
	})
	if err != nil {
		response.Internal(c, "query failed")
		return
	}
	var links []models.CaregiverPatient
	if err := cur.All(ctx, &links); err != nil {
		response.Internal(c, "decode failed")
		return
	}
	patientIDs := make([]primitive.ObjectID, len(links))
	for i, l := range links {
		patientIDs[i] = l.PatientID
	}
	var patients []models.Patient
	if len(patientIDs) > 0 {
		pcur, err := h.a.DB.Collection("patients").Find(ctx, bson.M{"_id": bson.M{"$in": patientIDs}, "is_active": true})
		if err == nil {
			_ = pcur.All(ctx, &patients)
		}
	}
	response.OK(c, gin.H{"links": links, "patients": patients})
}
