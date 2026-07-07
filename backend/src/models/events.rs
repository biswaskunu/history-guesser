use serde::{Deserialize, Serialize};
use uuid::Uuid;

// Full row, including the answer key (lat/lng)
#[derive(Debug, sqlx::FromRow)]
pub struct Event {
    pub id: Uuid,
    pub image_url: String,
    pub title: String,
    pub description: String,
    pub latitude: f64,
    pub longitude: f64,
    pub year: i32,
    pub difficulty: i16,
}

// What the client actually receives for a round: everything needed to render
#[derive(Debug, Serialize)]
pub struct PublicEvent {
    pub id: Uuid,
    pub image_url: String,
    pub title: String,
    pub description: String,
    pub year: i32,
    pub difficulty: i16,
}

impl From<Event> for PublicEvent {
    fn from(e: Event) -> Self {
        PublicEvent {
            id: e.id,
            image_url: e.image_url,
            title: e.title,
            description: e.description,
            year: e.year,
            difficulty: e.difficulty,
        }
    }
}


#[derive(Debug, Deserialize)]
pub struct GuessRequest {
    pub latitude: f64,
    pub longitude: f64,
}

#[derive(Debug, Serialize)]
pub struct GuessResponse {
    pub distance_km: f64,
    pub score: u32,
    pub actual_latitude: f64,
    pub actual_longitude: f64,
    pub year: i32,
}

/// Great-circle distance between two points in kilometers.
pub fn haversine_km(lat1: f64, lon1: f64, lat2: f64, lon2: f64) -> f64 {
    const EARTH_RADIUS_KM: f64 = 6371.0;

    let (lat1_r, lat2_r) = (lat1.to_radians(), lat2.to_radians());
    let d_lat = (lat2 - lat1).to_radians();
    let d_lon = (lon2 - lon1).to_radians();

    let a = (d_lat / 2.0).sin().powi(2)
        + lat1_r.cos() * lat2_r.cos() * (d_lon / 2.0).sin().powi(2);
    let c = 2.0 * a.sqrt().asin();

    EARTH_RADIUS_KM * c
}

/// Converts a distance into a 0-5000 score. Full marks within 1km, tapering
/// to 0 by ~2000km. Tune this curve once real playtesting data exists.
pub fn score_from_distance(distance_km: f64) -> u32 {
    const MAX_SCORE: f64 = 5000.0;
    const SCALE_KM: f64 = 2000.0;

    if distance_km <= 1.0 {
        return MAX_SCORE as u32;
    }

    let score = MAX_SCORE * (-distance_km / SCALE_KM).exp();
    score.round().max(0.0) as u32
}