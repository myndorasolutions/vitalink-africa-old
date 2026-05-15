package messages

import (
	"crypto/sha256"
	"encoding/hex"
	"regexp"
	"strings"
)

var (
	phonePattern  = regexp.MustCompile(`0[7-9][0-1][0-9]{8}`)
	accountPattern = regexp.MustCompile(`\b\d{10}\b`)
	keywords = []string{
		"transfer", "pay me direct", "my account", "send to",
		"gtbank", "access bank", "zenith", "uba", "first bank",
		"opay", "palmpay", "whatsapp.com", "wa.me",
	}
)

type ScanResult struct {
	Blocked         bool
	PatternDetected string
	SnippetHash     string
}

func ScanMessage(body string) ScanResult {
	lower := strings.ToLower(body)
	hash := sha256.Sum256([]byte(body))
	result := ScanResult{SnippetHash: hex.EncodeToString(hash[:8])}

	if phonePattern.MatchString(body) {
		result.Blocked = true
		result.PatternDetected = "nigerian_phone"
		return result
	}
	if accountPattern.MatchString(body) {
		result.Blocked = true
		result.PatternDetected = "bank_account"
		return result
	}
	for _, kw := range keywords {
		if strings.Contains(lower, kw) {
			result.Blocked = true
			result.PatternDetected = "keyword:" + kw
			return result
		}
	}
	return result
}

const PolicyWarning = "Direct payment requests are not allowed. All payments must go through VitaLink for your protection."
