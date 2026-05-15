package vitals

import (
	"context"
	"encoding/json"
	"time"

	"github.com/vitalink-africa/backend/internal/alerts"
	"github.com/vitalink-africa/backend/internal/audit"
	"github.com/vitalink-africa/backend/internal/models"
	"github.com/vitalink-africa/backend/internal/notifications"
	"github.com/vitalink-africa/backend/internal/platform"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type Service struct {
	repo       *Repository
	alerts     *alerts.Repository
	audit      *audit.Service
	notify     *notifications.Service
	pub        *platform.AlertPublisher
	thresholds Thresholds
}

func NewService(repo *Repository, alertRepo *alerts.Repository, auditSvc *audit.Service, notify *notifications.Service, pub *platform.AlertPublisher, t Thresholds) *Service {
	return &Service{repo: repo, alerts: alertRepo, audit: auditSvc, notify: notify, pub: pub, thresholds: t}
}

type CreateVitalInput struct {
	PatientID           primitive.ObjectID
	SystolicBP          *int
	DiastolicBP         *int
	Pulse               *int
	GlucoseFasting      *float64
	GlucoseRandom       *float64
	WeightKg            *float64
	Symptoms            []string
	MedicationTaken     bool
	Notes               string
	SourceType          string
	CapturedByUserID    primitive.ObjectID
	CaptureLocationType string
	PatientConsented    bool
}

func (s *Service) Create(ctx context.Context, in CreateVitalInput, actorID primitive.ObjectID, ip, ua string) (*models.Vital, *models.Alert, error) {
	riskIn := RiskInput{
		SystolicBP: in.SystolicBP, DiastolicBP: in.DiastolicBP,
		GlucoseFasting: in.GlucoseFasting, GlucoseRandom: in.GlucoseRandom,
		Symptoms: in.Symptoms,
	}
	risk := CalculateRisk(riskIn, s.thresholds)

	v := &models.Vital{
		PatientID: in.PatientID, SystolicBP: in.SystolicBP, DiastolicBP: in.DiastolicBP,
		Pulse: in.Pulse, GlucoseFasting: in.GlucoseFasting, GlucoseRandom: in.GlucoseRandom,
		WeightKg: in.WeightKg, Symptoms: in.Symptoms, MedicationTaken: in.MedicationTaken,
		Notes: in.Notes, RiskStatus: risk, SourceType: in.SourceType,
		CapturedByUserID: in.CapturedByUserID, CaptureLocationType: in.CaptureLocationType,
		PatientConsented: in.PatientConsented,
	}
	if err := s.repo.Create(ctx, v); err != nil {
		return nil, nil, err
	}

	pid := &in.PatientID
	_ = s.audit.Log(ctx, actorID, pid, "vital.created", "vital", v.ID.Hex(), nil, v, ip, ua)

	var alert *models.Alert
	if risk == "yellow" || risk == "red" {
		severity := risk
		if severity == "yellow" {
			severity = "yellow"
		}
		alert = &models.Alert{
			PatientID: in.PatientID, VitalID: &v.ID,
			AlertType: AlertTypeForRisk(risk, riskIn), Severity: severity,
			Message: "Vital reading requires attention: " + risk,
		}
		_ = s.alerts.Create(ctx, alert)
		if s.pub != nil {
			payload, _ := json.Marshal(alert)
			_ = s.pub.Publish(ctx, platform.AlertChannel, string(payload))
		}
		go s.notify.DispatchVitalAlert(context.Background(), in.PatientID, risk)
	}
	return v, alert, nil
}

func (s *Service) Trend(ctx context.Context, patientID primitive.ObjectID, days int) ([]models.Vital, error) {
	since := time.Now().UTC().AddDate(0, 0, -days)
	return s.repo.ListByPatient(ctx, patientID, since, 0, 500)
}
