package platform

import (
	"context"

	"github.com/go-redis/redis/v8"
)

func ConnectRedis(ctx context.Context, url string) (*redis.Client, error) {
	opt, err := redis.ParseURL(url)
	if err != nil {
		return nil, err
	}
	client := redis.NewClient(opt)
	if err := client.Ping(ctx).Err(); err != nil {
		return nil, err
	}
	return client, nil
}

const AlertChannel = "alerts:new"
