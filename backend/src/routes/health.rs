use crate::AppState;
use axum::{extract::State, Json};
use serde_json::json;
use std::sync::Arc;

pub async fn health_check() -> Json<serde_json::Value> {
    Json(json!({ "status": "ok" }))
}

pub async fn db_check(State(state): State<Arc<AppState>>) -> Json<serde_json::Value> {
    let result: Result<(i32,), _> = sqlx::query_as("SELECT 1")
        .fetch_one(&state.db)
        .await;

    match result {
        Ok(_) => Json(json!({ "database": "connected" })),
        Err(e) => Json(json!({ "database": "error", "message": e.to_string() })),
    }
}