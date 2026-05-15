package router

import (
	"github.com/gin-gonic/gin"
	"github.com/vitalink-africa/backend/internal/app"
	"github.com/vitalink-africa/backend/internal/middleware"
	"github.com/vitalink-africa/backend/internal/models"
)

// RegisterRoutes wires all HTTP handlers onto the Gin engine.
func RegisterRoutes(r *gin.Engine, a *app.App) {
	h := NewHandler(a)

	r.GET("/health", h.Health)

	v1 := r.Group("/api/v1")

	auth := v1.Group("/auth")
	{
		auth.POST("/verify-token", h.VerifyToken)
		auth.POST("/complete-profile", middleware.FirebaseAuth(a), h.CompleteProfile)
	}

	protected := v1.Group("")
	protected.Use(middleware.FirebaseAuth(a))

	patients := protected.Group("/patients")
	{
		patients.GET("/me", middleware.RequireRoles(models.RolePatient), h.GetPatientMe)
		patients.PUT("/me", middleware.RequireRoles(models.RolePatient), h.UpdatePatientMe)
		patients.GET("", middleware.RequireRoles(models.RoleAdmin, models.RoleSuperAdmin), h.ListPatients)
		patients.POST("", h.CreatePatient)
		patients.GET("/:id", h.GetPatient)
		patients.PUT("/:id", h.UpdatePatient)
		patients.DELETE("/:id", h.DeletePatient)
	}

	vitals := protected.Group("/vitals")
	{
		vitals.POST("", h.CreateVital)
		vitals.GET("/:id", h.GetVital)
		vitals.GET("/patient/:patientId", h.ListVitalsByPatient)
		vitals.GET("/patient/:patientId/trend", h.VitalTrend)
		vitals.POST("/calculate-risk", h.CalculateRisk)
		vitals.DELETE("/:id", h.DeleteVital)
	}

	alerts := protected.Group("/alerts")
	{
		alerts.GET("", h.ListAlerts)
		alerts.POST("/:id/resolve", h.ResolveAlert)
		alerts.POST("/:id/assign", h.AssignAlert)
		alerts.GET("/stream", middleware.RequireRoles(models.RoleAdmin, models.RoleSuperAdmin), h.StreamAlerts)
	}

	caregivers := protected.Group("/caregivers")
	{
		caregivers.POST("/link-request", middleware.RequireRoles(models.RoleCaregiver), h.CaregiverLinkRequest)
		caregivers.POST("/consent", middleware.RequireRoles(models.RolePatient), h.CaregiverConsent)
		caregivers.GET("/my-patients", middleware.RequireRoles(models.RoleCaregiver), h.CaregiverMyPatients)
	}

	helpers := protected.Group("/helpers")
	{
		helpers.POST("/authorize", middleware.RequireRoles(models.RolePatient, models.RoleCaregiver), h.AuthorizeHelper)
		helpers.GET("", h.ListHelpers)
		helpers.DELETE("/:id", h.RevokeHelper)
	}

	providers := protected.Group("/providers")
	{
		providers.POST("/register", h.RegisterProvider)
		providers.GET("/me", h.ProviderMe)
		providers.GET("", h.ListProviders)
		providers.GET("/catalog", h.ProviderCatalog)
		providers.POST("/:id/verify", middleware.RequireRoles(models.RoleAdmin, models.RoleSuperAdmin), h.VerifyProvider)
		providers.POST("/services", h.CreateProviderService)
		providers.GET("/services", h.ListProviderServices)
	}

	jobs := protected.Group("/jobs")
	{
		jobs.POST("/book", h.BookJob)
		jobs.POST("/:id/accept", h.AcceptJob)
		jobs.POST("/:id/decline", h.DeclineJob)
		jobs.POST("/:id/complete", h.CompleteJob)
		jobs.POST("/:id/confirm", h.ConfirmJobOTP)
		jobs.POST("/:id/dispute", h.DisputeJob)
		jobs.POST("/:id/generate-otp", h.GenerateJobOTP)
		jobs.GET("/:id", h.GetJob)
		jobs.GET("", h.ListJobs)
	}

	payments := v1.Group("/payments")
	{
		payments.POST("/webhook", h.PaymentWebhook)
	}
	payAuth := protected.Group("/payments")
	{
		payAuth.POST("/initialize", h.InitializePayment)
		payAuth.GET("/history", h.PaymentHistory)
		payAuth.POST("/subscriptions", h.CreateSubscription)
		payAuth.GET("/subscriptions", h.ListSubscriptions)
	}

	pharmacy := protected.Group("/pharmacy")
	{
		pharmacy.GET("/refills", middleware.RequireRoles(models.RolePharmacy, models.RolePatient, models.RoleCaregiver, models.RoleAdmin, models.RoleSuperAdmin), h.ListPharmacyRefills)
		pharmacy.POST("/refills", middleware.RequireRoles(models.RolePharmacy, models.RolePatient, models.RoleCaregiver), h.RequestPharmacyRefill)
		pharmacy.PUT("/refills/:id", middleware.RequireRoles(models.RolePharmacy), h.FulfillPharmacyRefill)
	}

	chw := protected.Group("/chw")
	{
		chw.GET("/patients", middleware.RequireRoles(models.RoleCHW, models.RoleAdmin, models.RoleSuperAdmin), h.CHWPatients)
		chw.POST("/visits", middleware.RequireRoles(models.RoleCHW), h.CHWCreateVisit)
		chw.GET("/visits", middleware.RequireRoles(models.RoleCHW, models.RoleAdmin, models.RoleSuperAdmin), h.CHWListVisits)
	}

	clinician := protected.Group("/clinician")
	{
		clinician.POST("/notes", middleware.RequireRoles(models.RoleClinician), h.ClinicianCreateNote)
		clinician.GET("/patients/:patientId/notes", h.ClinicianListNotes)
		clinician.POST("/prescriptions", middleware.RequireRoles(models.RoleClinician), h.ClinicianCreatePrescription)
		clinician.GET("/prescriptions", middleware.RequireRoles(models.RoleClinician, models.RolePharmacy), h.ClinicianListPrescriptions)
	}

	lab := protected.Group("/lab")
	{
		lab.GET("/orders", middleware.RequireRoles(models.RoleLab, models.RoleClinician, models.RoleAdmin, models.RoleSuperAdmin), h.LabListOrders)
		lab.POST("/orders", middleware.RequireRoles(models.RoleClinician), h.LabCreateOrder)
		lab.PUT("/orders/:id/results", middleware.RequireRoles(models.RoleLab), h.LabUploadResults)
	}

	admin := protected.Group("/admin")
	admin.Use(middleware.RequireRoles(models.RoleAdmin, models.RoleSuperAdmin))
	{
		admin.GET("/dashboard", h.AdminDashboard)
		admin.GET("/disputes", h.AdminListDisputes)
		admin.PUT("/disputes/:id", h.AdminResolveDispute)
		admin.GET("/reports", h.AdminReports)
		admin.GET("/audit", h.AdminAuditLogs)
		admin.GET("/feature-flags", h.AdminListFeatureFlags)
		admin.PUT("/feature-flags/:name", h.AdminUpdateFeatureFlag)
	}

	protected.POST("/messages/send", h.SendMessage)

	v1.POST("/ussd/callback", h.USSDCallback)

	consent := protected.Group("/consent")
	{
		consent.POST("/grant", h.GrantConsent)
		consent.POST("/revoke", h.RevokeConsent)
		consent.GET("", h.ListConsent)
	}

	notifications := protected.Group("/notifications")
	{
		notifications.GET("", h.ListNotifications)
		notifications.PUT("/:id/read", h.MarkNotificationRead)
	}

	storage := protected.Group("/storage")
	{
		storage.POST("/upload-url", h.StorageUploadURL)
		storage.POST("/download-url", h.StorageDownloadURL)
	}
}
