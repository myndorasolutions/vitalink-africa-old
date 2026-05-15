package vitals

import "strings"

type RiskInput struct {
	SystolicBP     *int
	DiastolicBP    *int
	GlucoseFasting *float64
	GlucoseRandom  *float64
	Symptoms       []string
}

type Thresholds struct {
	SystolicGreenMax   int
	DiastolicGreenMax  int
	FastingGreenMax    float64
	RandomGreenMax     float64
	SystolicYellowMax  int
	DiastolicYellowMax int
	FastingYellowMax   float64
	RandomYellowMax    float64
}

func DefaultThresholds() Thresholds {
	return Thresholds{
		SystolicGreenMax: 139, DiastolicGreenMax: 89,
		FastingGreenMax: 125.9, RandomGreenMax: 199.9,
		SystolicYellowMax: 179, DiastolicYellowMax: 119,
		FastingYellowMax: 250, RandomYellowMax: 299,
	}
}

func CalculateRisk(in RiskInput, t Thresholds) string {
	if hasChestPain(in.Symptoms) && (in.SystolicBP != nil || in.DiastolicBP != nil) {
		return "red"
	}
	if isRedBP(in.SystolicBP, in.DiastolicBP) || isRedGlucose(in.GlucoseFasting, in.GlucoseRandom) {
		return "red"
	}
	if isYellowBP(in.SystolicBP, in.DiastolicBP, t) || isYellowGlucose(in.GlucoseFasting, in.GlucoseRandom, t) {
		return "yellow"
	}
	return "green"
}

func hasChestPain(symptoms []string) bool {
	for _, s := range symptoms {
		if strings.EqualFold(s, "chest pain") {
			return true
		}
	}
	return false
}

func isRedBP(sys, dia *int) bool {
	if sys != nil && *sys >= 180 {
		return true
	}
	if dia != nil && *dia >= 120 {
		return true
	}
	return false
}

func isRedGlucose(fast, random *float64) bool {
	if fast != nil && *fast >= 300 {
		return true
	}
	if random != nil && *random >= 300 {
		return true
	}
	return false
}

func isYellowBP(sys, dia *int, t Thresholds) bool {
	if sys != nil && *sys >= 140 && *sys <= t.SystolicYellowMax {
		return true
	}
	if dia != nil && *dia >= 90 && *dia <= t.DiastolicYellowMax {
		return true
	}
	return false
}

func isYellowGlucose(fast, random *float64, t Thresholds) bool {
	if fast != nil && *fast >= 126 && *fast <= t.FastingYellowMax {
		return true
	}
	if random != nil && *random >= 200 && *random <= t.RandomYellowMax {
		return true
	}
	return false
}

func AlertTypeForRisk(risk string, in RiskInput) string {
	if isRedBP(in.SystolicBP, in.DiastolicBP) {
		return "high_bp"
	}
	if isRedGlucose(in.GlucoseFasting, in.GlucoseRandom) {
		return "high_glucose"
	}
	return "symptom_escalation"
}
