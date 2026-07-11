mod models;
mod routes;

use axum::{routing::{get,post}, Router};
use axum::http::{HeaderValue, Method, header};
use sqlx::postgres::PgPoolOptions;
use std::sync::Arc;
use tower_http::cors::CorsLayer;

pub struct AppState {
    pub db: sqlx::PgPool,
}

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    dotenvy::dotenv().ok();
    tracing_subscriber::fmt()
    .with_env_filter(
        tracing_subscriber::EnvFilter::try_from_default_env()
            .unwrap_or_else(|_| tracing_subscriber::EnvFilter::new("info")),
    )
    .init();

    let database_url = std::env::var("DATABASE_URL")
        .expect("DATABASE_URL must be set");

    let pool = PgPoolOptions::new()
        .max_connections(5)
        .connect(&database_url)
        .await?;

    sqlx::migrate!("./migrations")
        .run(&pool)
        .await
        .expect("failed to run database migrations");


    let state = Arc::new(AppState { db: pool });

    // CORS configuration
    let frontend_origin = std::env::var("FRONTEND_ORIGIN")
    .unwrap_or_else(|_| "http://localhost:5173".to_string());

    let origins: Vec<HeaderValue> = frontend_origin
        .split(',')
        .map(|o| o.trim().parse().expect("invalid FRONTEND_ORIGIN value"))
        .collect();

    let cors = CorsLayer::new()
        .allow_origin(origins)
        .allow_methods([Method::GET, Method::POST])
        .allow_headers([header::CONTENT_TYPE]);



    let app = Router::new()

        .route("/health", get(routes::health::health_check))
        .route("/db-check", get(routes::health::db_check))
        .route("/events/random", get(routes::events::random_event))
        .route("/events/{id}/guess", post(routes::events::submit_guess))


        .layer(cors)
        .with_state(state);


    let port = std::env::var("PORT").unwrap_or_else(|_| "8000".to_string());
    let addr = format!("0.0.0.0:{port}");

    let listener = tokio::net::TcpListener::bind(&addr).await?;
    tracing::info!("Server running on http://{addr}");
    axum::serve(listener, app).await?;

    Ok(())
}