package patients

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
	return &Repository{coll: db.Collection("patients")}
}

func (r *Repository) Create(ctx context.Context, p *models.Patient) error {
	now := time.Now().UTC()
	p.CreatedAt = now
	p.UpdatedAt = now
	p.IsActive = true
	res, err := r.coll.InsertOne(ctx, p)
	if err != nil {
		return err
	}
	p.ID = res.InsertedID.(primitive.ObjectID)
	return nil
}

func (r *Repository) FindByUserID(ctx context.Context, userID primitive.ObjectID) (*models.Patient, error) {
	var p models.Patient
	err := r.coll.FindOne(ctx, bson.M{"user_id": userID}).Decode(&p)
	return &p, err
}

func (r *Repository) FindByID(ctx context.Context, id primitive.ObjectID) (*models.Patient, error) {
	var p models.Patient
	err := r.coll.FindOne(ctx, bson.M{"_id": id}).Decode(&p)
	return &p, err
}

func (r *Repository) Update(ctx context.Context, id primitive.ObjectID, update bson.M) error {
	update["updated_at"] = time.Now().UTC()
	_, err := r.coll.UpdateOne(ctx, bson.M{"_id": id}, bson.M{"$set": update})
	return err
}

func (r *Repository) List(ctx context.Context, filter bson.M, skip, limit int64) ([]models.Patient, error) {
	opts := options.Find().SetSkip(skip).SetLimit(limit)
	cur, err := r.coll.Find(ctx, filter, opts)
	if err != nil {
		return nil, err
	}
	var list []models.Patient
	err = cur.All(ctx, &list)
	return list, err
}

func (r *Repository) Count(ctx context.Context, filter bson.M) (int64, error) {
	return r.coll.CountDocuments(ctx, filter)
}
