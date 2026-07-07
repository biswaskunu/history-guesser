-- Each event is a single historical photo tied to a place, time, and short description.

CREATE TABLE events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    -- Content
    image_url TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT NOT NULL,

    -- Answer keys
    latitude DOUBLE PRECISION NOT NULL CHECK (latitude BETWEEN -90 AND 90),
    longitude DOUBLE PRECISION NOT NULL CHECK (longitude BETWEEN -180 AND 180),
    year INTEGER NOT NULL,

    -- 1 .. 5 (easiest to hardest)
    difficulty SMALLINT NOT NULL CHECK (difficulty BETWEEN 1 AND 5),

    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Random-selection queries (TABLESAMPLE or ORDER BY random()) benefit from this index
-- on difficulty when filtering by round difficulty.
CREATE INDEX idx_events_difficulty ON events (difficulty);