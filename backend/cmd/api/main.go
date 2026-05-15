package main

import (
	"context"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/vitalink-africa/backend/internal/app"
	"github.com/vitalink-africa/backend/internal/config"
	"github.com/vitalink-africa/backend/internal/middleware"
	"github.com/vitalink-africa/backend/internal/platform"
	"github.com/vitalink-africa/backend/internal/router"
)

func main() {
	cfg, err := config.Load()
	if err != nil {
		log.Fatal(err)
	}

	ctx := context.Background()
	db, err := platform.ConnectMongo(ctx, cfg.MongoURI, cfg.MongoDB)
	if err != nil {
		log.Fatal(err)
	}
	rdb, err := platform.ConnectRedis(ctx, cfg.RedisURL)
	if err != nil {
		log.Fatal(err)
	}

	application, err := app.New(ctx, cfg, db, rdb)
	if err != nil {
		log.Fatal(err)
	}

	if cfg.AppEnv == "production" {
		gin.SetMode(gin.ReleaseMode)
	}

	r := gin.New()
	r.Use(gin.Recovery())
	r.Use(router.SetupCORS(cfg.CORSOrigins))
	r.Use(middleware.RequestLogger())
	r.Use(middleware.RateLimit(50, 100))

	router.RegisterRoutes(r, application)

	srv := &http.Server{Addr: ":" + cfg.AppPort, Handler: r}
	go func() {
		log.Printf("VitaLink API listening on :%s", cfg.AppPort)
		if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
			log.Fatal(err)
		}
	}()

	quit := make(chan os.Signal, 1)
	signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)
	<-quit

	shutdownCtx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	_ = srv.Shutdown(shutdownCtx)
}
