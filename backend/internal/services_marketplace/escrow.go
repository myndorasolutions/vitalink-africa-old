package services_marketplace

const (
	EscrowInitialized                  = "initialized"
	EscrowPaidHeld                     = "paid_held"
	EscrowAccepted                     = "accepted"
	EscrowCompletedPendingConfirmation = "completed_pending_confirmation"
	EscrowReleased                     = "released"
	EscrowDisputed                     = "disputed"
	EscrowRefunded                     = "refunded"
)

func CanTransition(from, to string) bool {
	transitions := map[string][]string{
		EscrowInitialized:                  {EscrowPaidHeld},
		EscrowPaidHeld:                     {EscrowAccepted, EscrowRefunded},
		EscrowAccepted:                     {EscrowCompletedPendingConfirmation, EscrowDisputed},
		EscrowCompletedPendingConfirmation: {EscrowReleased, EscrowDisputed},
		EscrowDisputed:                     {EscrowReleased, EscrowRefunded},
	}
	allowed, ok := transitions[from]
	if !ok {
		return false
	}
	for _, a := range allowed {
		if a == to {
			return true
		}
	}
	return false
}
