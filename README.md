# History Guesser

A GeoGuessr-style game for history buffs — you're shown a historical photo and its title/description, then you drop a pin on the map for where (and are scored on how close) it happened.

**Live demo:** https://history-guesser-game.netlify.app

## How it works

Each round:
1. The client fetches a random historical event (image, title, description, year, difficulty) from the backend.
2. You click the map to place a guess.
3. On submit, the backend computes the great-circle (haversine) distance between your guess and the actual location, and returns a distance-based score.
4. Your session score, streak, and history are tracked client-side.

## Tech stack

**Backend**
- [Rust](https://www.rust-lang.org/) + [Axum](https://github.com/tokio-rs/axum)
- [SQLx](https://github.com/launchbadge/sqlx) + PostgreSQL
- `tower-http` for CORS/tracing

**Frontend**
- React 19 + Vite
- [Leaflet](https://leafletjs.com/) / react-leaflet for the map

**Infra**
- Backend + Postgres: [Railway](https://railway.app/)
- Frontend: [Netlify](https://www.netlify.com/)
- A Cloudflare Worker reverse-proxies frontend → backend API requests through a stable anycast hostname (works around ISP-level DNS filtering of Railway's domain)


## Running locally

The whole stack (Postgres, backend, frontend) runs via Docker Compose:

```bash
docker compose up
```

- Frontend: http://localhost:5173
- Backend: http://localhost:8000
- Postgres: localhost:5432

Backend picks up `DATABASE_URL`, `FRONTEND_ORIGIN`, and `PORT` from the environment (see `backend/.env.example`). Frontend reads the API base URL from `VITE_API_URL`.

### Without Docker

**Backend**
```bash
cd backend
cp .env.example .env
cargo run
```

**Frontend**
```bash
cd frontend
npm install
npm run dev
```

## Deployment

- **Backend**: deployed on Railway from `backend/Dockerfile.prod`, health-checked on `/health`. Config in `backend/railway.json`.
- **Frontend**: deployed on Netlify, built with `npm run build`. `VITE_API_URL` should point at the Cloudflare Worker proxy URL (not the raw Railway domain), since some users hit DNS filtering on Railway's domain directly.
- **Proxy**: a Cloudflare Worker forwards requests to the Railway backend. See `wrangler.jsonc` — no `[assets]` block, and no scaffolded `public/` folder (newer Wrangler versions auto-detect that as a Workers Assets dir, which breaks pure Worker deploys).

## Roadmap

- [ ] Auth (JWT or anonymous sessions)
- [ ] Multiplayer via WebSockets (will need the Cloudflare Worker to add WS-forwarding support)
- [ ] Content pipeline for adding new historical events
- [ ] Leaderboards
- [ ] Profile / Settings pages (currently placeholder stubs pending auth)

## Notes

- Migrations are embedded at compile time via `sqlx::migrate!("./migrations")` in `main.rs`, so the runtime Docker image only needs the compiled binary — no migrations directory is copied into it.
