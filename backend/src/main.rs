use axum::{routing::{get,post}, Router};
use sqlx::postgres::PgPoolOptions;
use std::sync::Arc;

pub mod models;
pub mod routes;

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

    let app = Router::new()
        .route("/health", get(routes::health::health_check))
        .route("/db-check", get(routes::health::db_check))
        .route("/events/random", get(routes::events::random_event))
        .route("/events/{id}/guess", post(routes::events::submit_guess))

        
        .with_state(state);

    let listener = tokio::net::TcpListener::bind("0.0.0.0:8000").await?;
    tracing::info!("Server running on http://0.0.0.0:8000");
    axum::serve(listener, app).await?;

    Ok(())
}