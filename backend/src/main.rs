mod models;
mod routes;

use axum::{routing::{get,post}, Router};
use sqlx::postgres::PgPoolOptions;
use std::sync::Arc;
use tower_http::cors::{Any, CorsLayer};

pub struct AppState {
    pub db: sqlx::PgPool,
}

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    dotenvy::dotenv().ok();
    tracing_subscriber::fmt::init();

    let database_url = std::env::var("DATABASE_URL")
        .expect("DATABASE_URL must be set");

    let pool = PgPoolOptions::new()
        .max_connections(5)
        .connect(&database_url)
        .await?;

    let state = Arc::new(AppState { db: pool });

    // Dev-permissive CORS: allows any origin, GET/POST, and a JSON content
    // type. Tighten this to specific origins before shipping to production.
    let cors = CorsLayer::new()
        .allow_origin(Any)
        .allow_methods(Any)
        .allow_headers(Any);

    let app = Router::new()

        .route("/health", get(routes::health::health_check))
        .route("/db-check", get(routes::health::db_check))
        .route("/events/random", get(routes::events::random_event))
        .route("/events/{id}/guess", post(routes::events::submit_guess))


        .layer(cors)
        .with_state(state);

    let listener = tokio::net::TcpListener::bind("0.0.0.0:8000").await?;
    tracing::info!("Server running on http://0.0.0.0:8000");
    axum::serve(listener, app).await?;

    Ok(())
}