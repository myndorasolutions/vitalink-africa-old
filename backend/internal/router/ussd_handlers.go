package router

import (
	"encoding/json"
	"fmt"
	"strings"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/vitalink-africa/backend/internal/vitals"
	"github.com/vitalink-africa/backend/pkg/response"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

const ussdSessionPrefix = "ussd:session:"
const ussdSessionTTL = 10 * time.Minute

type ussdSession struct {
	Step       string `json:"step"`
	Phone      string `json:"phone"`
	PatientID  string `json:"patient_id"`
	SystolicBP int    `json:"systolic_bp"`
}

type ussdCallbackRequest struct {
	SessionID   string `json:"sessionId" form:"sessionId"`
	PhoneNumber string `json:"phoneNumber" form:"phoneNumber"`
	Text        string `json:"text" form:"text"`
	ServiceCode string `json:"serviceCode" form:"serviceCode"`
}

func (h *Handler) USSDCallback(c *gin.Context) {
	var req ussdCallbackRequest
	if err := c.ShouldBind(&req); err != nil {
		response.BadRequest(c, "invalid_body", err.Error())
		return
	}
	if req.SessionID == "" || req.PhoneNumber == "" {
		response.BadRequest(c, "missing_fields", "sessionId and phoneNumber required")
		return
	}

	ctx := c.Request.Context()
	key := ussdSessionPrefix + req.SessionID
	var sess ussdSession
	if raw, err := h.a.Redis.Get(ctx, key).Result(); err == nil && raw != "" {
		_ = json.Unmarshal([]byte(raw), &sess)
	}
	sess.Phone = req.PhoneNumber

	parts := strings.Split(req.Text, "*")
	input := ""
	if len(parts) > 0 {
		input = parts[len(parts)-1]
	}

	var reply string
	end := false

	switch sess.Step {
	case "":
		sess.Step = "menu"
		reply = "CON Welcome to VitaLink\n1. Log vitals\n2. Help"
	case "menu":
		switch input {
		case "1":
			sess.Step = "systolic"
			reply = "CON Enter systolic BP:"
		case "2":
			reply = "END Call 0800-VITALINK or visit vitalink.africa"
			end = true
		default:
			reply = "END Invalid option"
			end = true
		}
	case "systolic":
		var sys int
		if _, err := fmt.Sscanf(input, "%d", &sys); err != nil {
			reply = "END Invalid number"
			end = true
			break
		}
		sess.SystolicBP = sys
		sess.Step = "diastolic"
		reply = "CON Enter diastolic BP:"
	case "diastolic":
		var dia int
		if _, err := fmt.Sscanf(input, "%d", &dia); err != nil {
			reply = "END Invalid number"
			end = true
			break
		}
		if sess.PatientID == "" {
			var user struct {
				ID primitive.ObjectID `bson:"_id"`
			}
			if err := h.a.DB.Collection("users").FindOne(ctx, map[string]interface{}{"phone": req.PhoneNumber}).Decode(&user); err == nil {
				if p, err := h.a.Patients.FindByUserID(ctx, user.ID); err == nil {
					sess.PatientID = p.ID.Hex()
				}
			}
		}
		if sess.PatientID != "" {
			pid, _ := primitive.ObjectIDFromHex(sess.PatientID)
			sys := sess.SystolicBP
			in := vitals.CreateVitalInput{
				PatientID: pid, SystolicBP: &sys, DiastolicBP: &dia,
				SourceType: "ussd", CaptureLocationType: "home",
				CapturedByUserID: pid, PatientConsented: true,
			}
			v, _, _ := h.a.VitalService.Create(ctx, in, pid, "ussd", "ussd-gateway")
			reply = fmt.Sprintf("END Vitals saved. Risk: %s. Thank you.", v.RiskStatus)
		} else {
			risk := vitals.CalculateRisk(vitals.RiskInput{SystolicBP: &sess.SystolicBP, DiastolicBP: &dia}, vitals.DefaultThresholds())
			reply = fmt.Sprintf("END Risk: %s. Register on VitaLink app to save readings.", risk)
		}
		end = true
	default:
		reply = "END Session expired. Dial again."
		end = true
	}

	if !end && h.a.Redis != nil {
		b, _ := json.Marshal(sess)
		h.a.Redis.Set(ctx, key, string(b), ussdSessionTTL)
	}
	c.String(200, reply)
}
