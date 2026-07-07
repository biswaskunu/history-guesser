use crate::models::events::{
    haversine_km, score_from_distance, Event, GuessRequest, GuessResponse, PublicEvent,
};
use crate::AppState;
use axum::{
    extract::{Path, Query, State},
    http::StatusCode,
    Json,
};
use serde::Deserialize;
use serde_json::json;
use std::sync::Arc;
use uuid::Uuid;

#[derive(Debug, Deserialize)]
pub struct RandomEventParams {
    /// Optional difficulty filter, 1 (easiest) to 5 (hardest).
    pub difficulty: Option<i16>,
}

pub async fn random_event(
    State(state): State<Arc<AppState>>,
    Query(params): Query<RandomEventParams>,
) -> Result<Json<PublicEvent>, (StatusCode, Json<serde_json::Value>)> {
    if let Some(d) = params.difficulty {
        if !(1..=5).contains(&d) {
            return Err((
                StatusCode::BAD_REQUEST,
                Json(json!({ "error": "difficulty must be between 1 and 5" })),
            ));
        }
    }

    let result = sqlx::query_as::<_, Event>(
        r#"
        SELECT id, image_url, title, description, latitude, longitude, year, difficulty
        FROM events
        WHERE $1::smallint IS NULL OR difficulty = $1
        ORDER BY random()
        LIMIT 1
        "#,
    )
    .bind(params.difficulty)
    .fetch_optional(&state.db)
    .await;

    match result {
        Ok(Some(event)) => Ok(Json(PublicEvent::from(event))),
        Ok(None) => Err((
            StatusCode::NOT_FOUND,
            Json(json!({ "error": "no events found" })),
        )),
        Err(e) => {
            tracing::error!("random_event query failed: {e}");
            Err((
                StatusCode::INTERNAL_SERVER_ERROR,
                Json(json!({ "error": "database error" })),
            ))
        }
    }
}

pub async fn submit_guess(
    State(state): State<Arc<AppState>>,
    Path(event_id): Path<Uuid>,
    Json(guess): Json<GuessRequest>,
) -> Result<Json<GuessResponse>, (StatusCode, Json<serde_json::Value>)> {
    if !(-90.0..=90.0).contains(&guess.latitude) || !(-180.0..=180.0).contains(&guess.longitude) {
        return Err((
            StatusCode::BAD_REQUEST,
            Json(json!({ "error": "latitude/longitude out of range" })),
        ));
    }

    let event = sqlx::query_as::<_, Event>(
        r#"
        SELECT id, image_url, title, description, latitude, longitude, year, difficulty
        FROM events
        WHERE id = $1
        "#,
    )
    .bind(event_id)
    .fetch_optional(&state.db)
    .await;

    match event {
        Ok(Some(event)) => {
            let distance_km =
                haversine_km(guess.latitude, guess.longitude, event.latitude, event.longitude);
            let score = score_from_distance(distance_km);

            Ok(Json(GuessResponse {
                distance_km: (distance_km * 100.0).round() / 100.0,
                score,
                actual_latitude: event.latitude,
                actual_longitude: event.longitude,
                year: event.year,
            }))
        }
        Ok(None) => Err((
            StatusCode::NOT_FOUND,
            Json(json!({ "error": "event not found" })),
        )),
        Err(e) => {
            tracing::error!("submit_guess query failed: {e}");
            Err((
                StatusCode::INTERNAL_SERVER_ERROR,
                Json(json!({ "error": "database error" })),
            ))
        }
    }
}