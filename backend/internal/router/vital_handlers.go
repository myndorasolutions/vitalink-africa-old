package router

import (
	"strconv"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/vitalink-africa/backend/internal/middleware"
	"github.com/vitalink-africa/backend/internal/models"
	"github.com/vitalink-africa/backend/internal/vitals"
	"github.com/vitalink-africa/backend/pkg/pagination"
	"github.com/vitalink-africa/backend/pkg/response"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

type createVitalRequest struct {
	PatientID           string   `json:"patient_id"`
	SystolicBP          *int     `json:"systolic_bp"`
	DiastolicBP         *int     `json:"diastolic_bp"`
	Pulse               *int     `json:"pulse"`
	GlucoseFasting      *float64 `json:"glucose_fasting"`
	GlucoseRandom       *float64 `json:"glucose_random"`
	WeightKg            *float64 `json:"weight_kg"`
	Symptoms            []string `json:"symptoms"`
	MedicationTaken     bool     `json:"medication_taken"`
	Notes               string   `json:"notes"`
	SourceType          string   `json:"source_type"`
	CaptureLocationType string   `json:"capture_location_type"`
	PatientConsented    bool     `json:"patient_consented"`
}

func (h *Handler) resolvePatientID(c *gin.Context, patientIDStr string) (primitive.ObjectID, bool) {
	uid, ok := userObjectID(c)
	if !ok {
		return primitive.NilObjectID, false
	}
	ctx := c.Request.Context()
	if patientIDStr == "" {
		p, err := h.a.Patients.FindByUserID(ctx, uid)
		if err != nil {
			response.BadRequest(c, "no_patient", "patient_id required")
			return primitive.NilObjectID, false
		}
		return p.ID, true
	}
	pid, err := primitive.ObjectIDFromHex(patientIDStr)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid patient_id")
		return primitive.NilObjectID, false
	}
	p, ok := h.loadPatient(c, pid)
	if !ok || !h.requirePatientAccess(c, p) {
		return primitive.NilObjectID, false
	}
	return pid, true
}

func (h *Handler) CreateVital(c *gin.Context) {
	var req createVitalRequest
	if !bindJSON(c, &req) {
		return
	}
	pid, ok := h.resolvePatientID(c, req.PatientID)
	if !ok {
		return
	}
	uid, _ := userObjectID(c)
	ctx := c.Request.Context()
	if req.SourceType == "" {
		req.SourceType = "patient_self"
	}
	if req.CaptureLocationType == "" {
		req.CaptureLocationType = "home"
	}
	in := vitals.CreateVitalInput{
		PatientID: pid, SystolicBP: req.SystolicBP, DiastolicBP: req.DiastolicBP,
		Pulse: req.Pulse, GlucoseFasting: req.GlucoseFasting, GlucoseRandom: req.GlucoseRandom,
		WeightKg: req.WeightKg, Symptoms: req.Symptoms, MedicationTaken: req.MedicationTaken,
		Notes: req.Notes, SourceType: req.SourceType, CapturedByUserID: uid,
		CaptureLocationType: req.CaptureLocationType, PatientConsented: req.PatientConsented,
	}
	v, alert, err := h.a.VitalService.Create(ctx, in, uid, clientIP(c), c.Request.UserAgent())
	if err != nil {
		response.Internal(c, "failed to create vital")
		return
	}
	out := gin.H{"vital": v, "risk_status": v.RiskStatus}
	if alert != nil {
		out["alert_id"] = alert.ID.Hex()
	}
	response.Created(c, out)
}

func (h *Handler) GetVital(c *gin.Context) {
	id, ok := parseObjectID(c, "id")
	if !ok {
		return
	}
	v, err := h.a.Vitals.FindByID(c.Request.Context(), id)
	if err == mongo.ErrNoDocuments {
		response.NotFound(c, "vital not found")
		return
	}
	if err != nil {
		response.Internal(c, "lookup failed")
		return
	}
	p, ok := h.loadPatient(c, v.PatientID)
	if !ok || !h.requirePatientAccess(c, p) {
		return
	}
	response.OK(c, v)
}

func (h *Handler) ListVitalsByPatient(c *gin.Context) {
	pid, ok := parseObjectID(c, "patientId")
	if !ok {
		return
	}
	p, ok := h.loadPatient(c, pid)
	if !ok || !h.requirePatientAccess(c, p) {
		return
	}
	pg := pagination.FromContext(c)
	list, err := h.a.Vitals.ListByPatient(c.Request.Context(), pid, time.Time{}, pg.Skip, pg.Limit)
	if err != nil {
		response.Internal(c, "list failed")
		return
	}
	response.OK(c, gin.H{"vitals": list, "page": pg.Page, "limit": pg.Limit})
}

func (h *Handler) VitalTrend(c *gin.Context) {
	pid, ok := parseObjectID(c, "patientId")
	if !ok {
		return
	}
	p, ok := h.loadPatient(c, pid)
	if !ok || !h.requirePatientAccess(c, p) {
		return
	}
	days, _ := strconv.Atoi(c.DefaultQuery("days", "7"))
	if days != 7 && days != 30 && days != 90 {
		days = 7
	}
	list, err := h.a.VitalService.Trend(c.Request.Context(), pid, days)
	if err != nil {
		response.Internal(c, "trend failed")
		return
	}
	response.OK(c, gin.H{"patient_id": pid.Hex(), "days": days, "vitals": list})
}

type calculateRiskRequest struct {
	SystolicBP     *int     `json:"systolic_bp"`
	DiastolicBP    *int     `json:"diastolic_bp"`
	GlucoseFasting *float64 `json:"glucose_fasting"`
	GlucoseRandom  *float64 `json:"glucose_random"`
	Symptoms       []string `json:"symptoms"`
}

func (h *Handler) CalculateRisk(c *gin.Context) {
	var req calculateRiskRequest
	if !bindJSON(c, &req) {
		return
	}
	in := vitals.RiskInput{
		SystolicBP: req.SystolicBP, DiastolicBP: req.DiastolicBP,
		GlucoseFasting: req.GlucoseFasting, GlucoseRandom: req.GlucoseRandom,
		Symptoms: req.Symptoms,
	}
	risk := vitals.CalculateRisk(in, vitals.DefaultThresholds())
	response.OK(c, gin.H{"risk_status": risk})
}

func (h *Handler) DeleteVital(c *gin.Context) {
	id, ok := parseObjectID(c, "id")
	if !ok {
		return
	}
	ctx := c.Request.Context()
	v, err := h.a.Vitals.FindByID(ctx, id)
	if err == mongo.ErrNoDocuments {
		response.NotFound(c, "vital not found")
		return
	}
	if err != nil {
		response.Internal(c, "lookup failed")
		return
	}
	p, ok := h.loadPatient(c, v.PatientID)
	if !ok || !h.requirePatientAccess(c, p) {
		return
	}
	role := middleware.GetRole(c)
	if role != models.RoleAdmin && role != models.RoleSuperAdmin && role != models.RoleClinician {
		response.Forbidden(c, "cannot delete vitals")
		return
	}
	_, err = h.a.DB.Collection("vitals").DeleteOne(ctx, map[string]interface{}{"_id": id})
	if err != nil {
		response.Internal(c, "delete failed")
		return
	}
	uid, _ := userObjectID(c)
	pid := v.PatientID
	auditAction(ctx, h, uid, &pid, "vital.deleted", "vital", id.Hex(), v, nil, c)
	noContent(c)
}
