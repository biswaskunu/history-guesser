use axum::{routing::get, Router, extract::State, Json};
use sqlx::postgres::PgPoolOptions;
use std::sync::Arc;
use serde_json::json;

#[derive(Clone)]
struct AppState {
    db: sqlx::PgPool,
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
        .route("/health", get(health_check))
        .route("/db-check", get(db_check))
        .with_state(state);

    let listener = tokio::net::TcpListener::bind("0.0.0.0:8000").await?;
    tracing::info!("Server running on http://0.0.0.0:8000");
    axum::serve(listener, app).await?;

    Ok(())
}

async fn health_check() -> Json<serde_json::Value> {
    Json(json!({ "status": "ok" }))
}

async fn db_check(State(state): State<Arc<AppState>>) -> Json<serde_json::Value> {
    let result: Result<(i32,), _> = sqlx::query_as("SELECT 1")
        .fetch_one(&state.db)
        .await;

    match result {
        Ok(_) => Json(json!({ "database": "connected" })),
        Err(e) => Json(json!({ "database": "error", "message": e.to_string() })),
    }
}