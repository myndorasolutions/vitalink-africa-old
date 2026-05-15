package alerts

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
	return &Repository{coll: db.Collection("alerts")}
}

func (r *Repository) Create(ctx context.Context, a *models.Alert) error {
	a.CreatedAt = time.Now().UTC()
	a.Status = "open"
	res, err := r.coll.InsertOne(ctx, a)
	if err != nil {
		return err
	}
	a.ID = res.InsertedID.(primitive.ObjectID)
	return nil
}

func (r *Repository) FindByID(ctx context.Context, id primitive.ObjectID) (*models.Alert, error) {
	var a models.Alert
	err := r.coll.FindOne(ctx, bson.M{"_id": id}).Decode(&a)
	return &a, err
}

func (r *Repository) List(ctx context.Context, filter bson.M, skip, limit int64) ([]models.Alert, error) {
	opts := options.Find().SetSkip(skip).SetLimit(limit).SetSort(bson.M{"created_at": -1})
	cur, err := r.coll.Find(ctx, filter, opts)
	if err != nil {
		return nil, err
	}
	var list []models.Alert
	err = cur.All(ctx, &list)
	return list, err
}

func (r *Repository) Update(ctx context.Context, id primitive.ObjectID, update bson.M) error {
	_, err := r.coll.UpdateOne(ctx, bson.M{"_id": id}, bson.M{"$set": update})
	return err
}

func (r *Repository) Count(ctx context.Context, filter bson.M) (int64, error) {
	return r.coll.CountDocuments(ctx, filter)
}
