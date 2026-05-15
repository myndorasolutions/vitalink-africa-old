package platform

import (
	"context"

	"github.com/go-redis/redis/v8"
)

type AlertPublisher struct {
	client *redis.Client
}

func NewAlertPublisher(client *redis.Client) *AlertPublisher {
	return &AlertPublisher{client: client}
}

func (p *AlertPublisher) Publish(ctx context.Context, channel string, message interface{}) *redis.IntCmd {
	if p.client == nil {
		return nil
	}
	return p.client.Publish(ctx, channel, message)
}
