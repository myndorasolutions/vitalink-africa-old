# Multi-stage build — context must be the monorepo root (see render.yaml dockerContext).
FROM node:20-alpine AS builder

WORKDIR /app

RUN corepack enable && corepack prepare pnpm@9.15.0 --activate

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY backend ./backend

RUN pnpm install --frozen-lockfile --filter myndora-care-backend...

WORKDIR /app/backend

RUN pnpm exec prisma generate && pnpm run build

FROM node:20-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production

RUN corepack enable && corepack prepare pnpm@9.15.0 --activate

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY backend/package.json backend/package.json
COPY backend/prisma backend/prisma
COPY --from=builder /app/backend/dist backend/dist
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/backend/node_modules ./backend/node_modules

WORKDIR /app/backend

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=60s --retries=3 \
  CMD wget -qO- "http://127.0.0.1:${PORT:-8080}/api/v1/health" || exit 1

CMD ["sh", "-c", "pnpm exec prisma migrate deploy && node dist/main.js"]
