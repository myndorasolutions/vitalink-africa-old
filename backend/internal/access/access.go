package access

import (
	"context"

	"github.com/vitalink-africa/backend/internal/models"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

type Checker struct {
	db *mongo.Database
}

func NewChecker(db *mongo.Database) *Checker {
	return &Checker{db: db}
}

func (c *Checker) CanAccessPatient(ctx context.Context, role string, userID primitive.ObjectID, patient *models.Patient) bool {
	switch role {
	case models.RoleAdmin, models.RoleSuperAdmin:
		return true
	case models.RolePatient:
		return patient.UserID == userID
	case models.RoleCaregiver:
		return c.hasCaregiverConsent(ctx, userID, patient.ID)
	case models.RoleHomeHelper:
		return c.hasHelperConsent(ctx, userID, patient.ID)
	case models.RoleCHW:
		return patient.AssignedCHWID != nil && *patient.AssignedCHWID == userID
	case models.RolePharmacy:
		return patient.AssignedPharmacyID != nil && *patient.AssignedPharmacyID == userID
	case models.RoleClinician:
		return patient.AssignedClinicianID != nil && *patient.AssignedClinicianID == userID
	default:
		return false
	}
}

func (c *Checker) hasCaregiverConsent(ctx context.Context, caregiverID, patientID primitive.ObjectID) bool {
	err := c.db.Collection("caregivers_patients").FindOne(ctx, bson.M{
		"caregiver_user_id": caregiverID,
		"patient_id":        patientID,
		"consent_status":    "approved",
	}).Err()
	return err == nil
}

func (c *Checker) hasHelperConsent(ctx context.Context, helperUserID, patientID primitive.ObjectID) bool {
	var helper struct {
		Phone string `bson:"phone"`
	}
	if err := c.db.Collection("users").FindOne(ctx, bson.M{"_id": helperUserID}).Decode(&helper); err != nil {
		return false
	}
	err := c.db.Collection("authorized_helpers").FindOne(ctx, bson.M{
		"patient_id":     patientID,
		"phone":          helper.Phone,
		"consent_status": "approved",
	}).Err()
	return err == nil
}

func (c *Checker) GetAccessiblePatientIDs(ctx context.Context, role string, userID primitive.ObjectID) ([]primitive.ObjectID, error) {
	switch role {
	case models.RoleAdmin, models.RoleSuperAdmin:
		cur, err := c.db.Collection("patients").Find(ctx, bson.M{"is_active": true})
		if err != nil {
			return nil, err
		}
		var patients []models.Patient
		if err := cur.All(ctx, &patients); err != nil {
			return nil, err
		}
		ids := make([]primitive.ObjectID, len(patients))
		for i, p := range patients {
			ids[i] = p.ID
		}
		return ids, nil
	case models.RolePatient:
		var p models.Patient
		if err := c.db.Collection("patients").FindOne(ctx, bson.M{"user_id": userID}).Decode(&p); err != nil {
			return nil, err
		}
		return []primitive.ObjectID{p.ID}, nil
	case models.RoleCaregiver:
		cur, err := c.db.Collection("caregivers_patients").Find(ctx, bson.M{
			"caregiver_user_id": userID, "consent_status": "approved",
		})
		if err != nil {
			return nil, err
		}
		var links []models.CaregiverPatient
		if err := cur.All(ctx, &links); err != nil {
			return nil, err
		}
		ids := make([]primitive.ObjectID, len(links))
		for i, l := range links {
			ids[i] = l.PatientID
		}
		return ids, nil
	default:
		return []primitive.ObjectID{}, nil
	}
}
