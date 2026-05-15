package vitals

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
	return &Repository{coll: db.Collection("vitals")}
}

func (r *Repository) Create(ctx context.Context, v *models.Vital) error {
	v.CreatedAt = time.Now().UTC()
	res, err := r.coll.InsertOne(ctx, v)
	if err != nil {
		return err
	}
	v.ID = res.InsertedID.(primitive.ObjectID)
	return nil
}

func (r *Repository) FindByID(ctx context.Context, id primitive.ObjectID) (*models.Vital, error) {
	var v models.Vital
	err := r.coll.FindOne(ctx, bson.M{"_id": id}).Decode(&v)
	return &v, err
}

func (r *Repository) ListByPatient(ctx context.Context, patientID primitive.ObjectID, since time.Time, skip, limit int64) ([]models.Vital, error) {
	filter := bson.M{"patient_id": patientID}
	if !since.IsZero() {
		filter["created_at"] = bson.M{"$gte": since}
	}
	opts := options.Find().SetSkip(skip).SetLimit(limit).SetSort(bson.M{"created_at": -1})
	cur, err := r.coll.Find(ctx, filter, opts)
	if err != nil {
		return nil, err
	}
	var list []models.Vital
	err = cur.All(ctx, &list)
	return list, err
}

func (r *Repository) LatestByPatient(ctx context.Context, patientID primitive.ObjectID) (*models.Vital, error) {
	opts := options.FindOne().SetSort(bson.M{"created_at": -1})
	var v models.Vital
	err := r.coll.FindOne(ctx, bson.M{"patient_id": patientID}, opts).Decode(&v)
	return &v, err
}

func (r *Repository) LastReadingBefore(ctx context.Context, patientID primitive.ObjectID, before time.Time) (*models.Vital, error) {
	filter := bson.M{"patient_id": patientID, "created_at": bson.M{"$lt": before}}
	opts := options.FindOne().SetSort(bson.M{"created_at": -1})
	var v models.Vital
	err := r.coll.FindOne(ctx, filter, opts).Decode(&v)
	return &v, err
}
