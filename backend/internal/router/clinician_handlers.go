package router

import (
	"time"

	"github.com/gin-gonic/gin"
	"github.com/vitalink-africa/backend/internal/models"
	"github.com/vitalink-africa/backend/pkg/response"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type clinicianNoteRequest struct {
	PatientID string `json:"patient_id" binding:"required"`
	Note      string `json:"note" binding:"required"`
}

func (h *Handler) ClinicianCreateNote(c *gin.Context) {
	var req clinicianNoteRequest
	if !bindJSON(c, &req) {
		return
	}
	patientID, err := primitive.ObjectIDFromHex(req.PatientID)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid patient_id")
		return
	}
	p, ok := h.loadPatient(c, patientID)
	if !ok {
		return
	}
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	if !h.a.Access.CanAccessPatient(c.Request.Context(), models.RoleClinician, uid, p) {
		response.Forbidden(c, "patient not assigned to you")
		return
	}
	note := models.ClinicalNote{
		PatientID:   patientID,
		ClinicianID: uid,
		Note:        req.Note,
		CreatedAt:   time.Now().UTC(),
	}
	ctx := c.Request.Context()
	res, err := h.a.DB.Collection("clinical_notes").InsertOne(ctx, note)
	if err != nil {
		response.Internal(c, "note create failed")
		return
	}
	note.ID = res.InsertedID.(primitive.ObjectID)
	response.Created(c, note)
}

func (h *Handler) ClinicianListNotes(c *gin.Context) {
	patientID, ok := parseObjectID(c, "patientId")
	if !ok {
		return
	}
	p, ok := h.loadPatient(c, patientID)
	if !ok || !h.requirePatientAccess(c, p) {
		return
	}
	cur, err := h.a.DB.Collection("clinical_notes").Find(c.Request.Context(), bson.M{"patient_id": patientID})
	if err != nil {
		response.Internal(c, "list failed")
		return
	}
	var notes []models.ClinicalNote
	_ = cur.All(c.Request.Context(), &notes)
	response.OK(c, gin.H{"notes": notes})
}

type prescriptionRequest struct {
	PatientID            string `json:"patient_id" binding:"required"`
	MedicationName       string `json:"medication_name" binding:"required"`
	MedicationType       string `json:"medication_type"`
	Dosage               string `json:"dosage" binding:"required"`
	Frequency            string `json:"frequency" binding:"required"`
	RefillCountRemaining int    `json:"refill_count_remaining"`
	ExpiresAt            string `json:"expires_at" binding:"required"`
}

func (h *Handler) ClinicianCreatePrescription(c *gin.Context) {
	var req prescriptionRequest
	if !bindJSON(c, &req) {
		return
	}
	patientID, err := primitive.ObjectIDFromHex(req.PatientID)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid patient_id")
		return
	}
	expires, err := time.Parse(time.RFC3339, req.ExpiresAt)
	if err != nil {
		response.BadRequest(c, "invalid_time", "expires_at must be RFC3339")
		return
	}
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	rx := models.Prescription{
		PatientID:            patientID,
		ClinicianID:          uid,
		MedicationName:       req.MedicationName,
		MedicationType:       req.MedicationType,
		Dosage:               req.Dosage,
		Frequency:            req.Frequency,
		RefillCountRemaining: req.RefillCountRemaining,
		ExpiresAt:            expires,
		Status:               "active",
		CreatedAt:            time.Now().UTC(),
	}
	ctx := c.Request.Context()
	res, err := h.a.DB.Collection("prescriptions").InsertOne(ctx, rx)
	if err != nil {
		response.Internal(c, "prescription create failed")
		return
	}
	rx.ID = res.InsertedID.(primitive.ObjectID)
	response.Created(c, rx)
}

func (h *Handler) ClinicianListPrescriptions(c *gin.Context) {
	filter := bson.M{"status": "active"}
	if pid := c.Query("patient_id"); pid != "" {
		if id, err := primitive.ObjectIDFromHex(pid); err == nil {
			filter["patient_id"] = id
		}
	}
	cur, err := h.a.DB.Collection("prescriptions").Find(c.Request.Context(), filter)
	if err != nil {
		response.Internal(c, "list failed")
		return
	}
	var rx []models.Prescription
	_ = cur.All(c.Request.Context(), &rx)
	response.OK(c, gin.H{"prescriptions": rx})
}
