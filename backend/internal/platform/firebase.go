package platform

import (
	"context"
	"os"

	firebase "firebase.google.com/go/v4"
	"firebase.google.com/go/v4/auth"
	"google.golang.org/api/option"
)

type FirebaseAuth struct {
	client *auth.Client
}

func NewFirebaseAuth(ctx context.Context, projectID, saPath string) (*FirebaseAuth, error) {
	if _, err := os.Stat(saPath); os.IsNotExist(err) {
		return &FirebaseAuth{client: nil}, nil
	}
	app, err := firebase.NewApp(ctx, &firebase.Config{ProjectID: projectID}, option.WithCredentialsFile(saPath))
	if err != nil {
		return nil, err
	}
	client, err := app.Auth(ctx)
	if err != nil {
		return nil, err
	}
	return &FirebaseAuth{client: client}, nil
}

func (f *FirebaseAuth) VerifyIDToken(ctx context.Context, idToken string) (*auth.Token, error) {
	if f.client == nil {
		return nil, ErrFirebaseNotConfigured
	}
	return f.client.VerifyIDToken(ctx, idToken)
}

func (f *FirebaseAuth) SetCustomClaims(ctx context.Context, uid string, claims map[string]interface{}) error {
	if f.client == nil {
		return ErrFirebaseNotConfigured
	}
	return f.client.SetCustomUserClaims(ctx, uid, claims)
}

func (f *FirebaseAuth) CreateUser(ctx context.Context, email, password, displayName string) (*auth.UserRecord, error) {
	if f.client == nil {
		return nil, ErrFirebaseNotConfigured
	}
	params := (&auth.UserToCreate{}).
		Email(email).
		Password(password).
		DisplayName(displayName).
		EmailVerified(true)
	return f.client.CreateUser(ctx, params)
}

func (f *FirebaseAuth) GetUserByEmail(ctx context.Context, email string) (*auth.UserRecord, error) {
	if f.client == nil {
		return nil, ErrFirebaseNotConfigured
	}
	return f.client.GetUserByEmail(ctx, email)
}

func (f *FirebaseAuth) Available() bool { return f.client != nil }

var ErrFirebaseNotConfigured = &AuthError{Msg: "firebase not configured - add firebase-service-account.json"}

type AuthError struct{ Msg string }

func (e *AuthError) Error() string { return e.Msg }
