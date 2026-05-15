package users

import (
	"context"
	"time"

	"github.com/vitalink-africa/backend/internal/models"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

type Repository struct {
	coll *mongo.Collection
}

func NewRepository(db *mongo.Database) *Repository {
	return &Repository{coll: db.Collection("users")}
}

func (r *Repository) FindByFirebaseUID(ctx context.Context, uid string) (*models.User, error) {
	var u models.User
	err := r.coll.FindOne(ctx, bson.M{"firebase_uid": uid}).Decode(&u)
	if err == mongo.ErrNoDocuments {
		return nil, mongo.ErrNoDocuments
	}
	return &u, err
}

func (r *Repository) FindByID(ctx context.Context, id primitive.ObjectID) (*models.User, error) {
	var u models.User
	err := r.coll.FindOne(ctx, bson.M{"_id": id}).Decode(&u)
	return &u, err
}

func (r *Repository) FindByEmail(ctx context.Context, email string) (*models.User, error) {
	var u models.User
	err := r.coll.FindOne(ctx, bson.M{"email": email}).Decode(&u)
	return &u, err
}

func (r *Repository) UpsertFromFirebase(ctx context.Context, uid, email string) (*models.User, error) {
	existing, err := r.FindByFirebaseUID(ctx, uid)
	if err == nil {
		now := time.Now().UTC()
		r.coll.UpdateOne(ctx, bson.M{"_id": existing.ID}, bson.M{"$set": bson.M{"last_login": now, "updated_at": now}})
		existing.LastLogin = &now
		return existing, nil
	}
	now := time.Now().UTC()
	u := models.User{
		FirebaseUID:        uid,
		Email:              email,
		LanguagePreference: "en",
		CreatedAt:          now,
		UpdatedAt:          now,
		IsActive:           true,
	}
	res, err := r.coll.InsertOne(ctx, u)
	if err != nil {
		return nil, err
	}
	u.ID = res.InsertedID.(primitive.ObjectID)
	return &u, nil
}

func (r *Repository) UpdateProfile(ctx context.Context, id primitive.ObjectID, update bson.M) error {
	update["updated_at"] = time.Now().UTC()
	_, err := r.coll.UpdateOne(ctx, bson.M{"_id": id}, bson.M{"$set": update})
	return err
}

func (r *Repository) SetRole(ctx context.Context, id primitive.ObjectID, role string) error {
	return r.UpdateProfile(ctx, id, bson.M{"role": role})
}

func (r *Repository) List(ctx context.Context, filter bson.M, skip, limit int64) ([]models.User, error) {
	opts := options.Find().SetSkip(skip).SetLimit(limit).SetSort(bson.M{"created_at": -1})
	cur, err := r.coll.Find(ctx, filter, opts)
	if err != nil {
		return nil, err
	}
	var users []models.User
	err = cur.All(ctx, &users)
	return users, err
}

func (r *Repository) Insert(ctx context.Context, u *models.User) error {
	_, err := r.coll.InsertOne(ctx, u)
	return err
}
