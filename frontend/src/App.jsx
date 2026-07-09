import { useEffect, useState, useCallback } from 'react'
import { fetchRandomEvent, submitGuess } from './api'
import GameMap from './components/GameMap'
import './App.css'

const DIFFICULTY_LABEL = {
  1: 'ROUTINE',
  2: 'STANDARD',
  3: 'SENSITIVE',
  4: 'RESTRICTED',
  5: 'CLASSIFIED',
}

function verdictFor(score) {
  if (score >= 4500) return 'BULLSEYE'
  if (score >= 3000) return 'CONFIRMED'
  if (score >= 1000) return 'NOTED'
  return 'MISSED'
}

function App() {
  // Single state object because these fields all change together at each
  // phase transition (new round -> guessing -> result).
  const [game, setGame] = useState({
    event: null,
    guess: null,
    result: null,
    loading: true,
    error: null,
  })
  const [round, setRound] = useState(1)

  const startNewRound = useCallback(async (advance = false) => {
    setGame({ event: null, guess: null, result: null, loading: true, error: null })
    try {
      const event = await fetchRandomEvent()
      setGame({ event, guess: null, result: null, loading: false, error: null })
      if (advance) setRound((r) => r + 1)
    } catch (err) {
      setGame((g) => ({ ...g, loading: false, error: err.message }))
    }
  }, [])

  useEffect(() => {
    startNewRound(false)
  }, [startNewRound])

  function handleGuess(latlng) {
    // Only allow placing a guess before the round is scored.
    if (game.result) return
    setGame((g) => ({ ...g, guess: latlng }))
  }

  async function handleSubmit() {
    if (!game.guess || !game.event) return
    try {
      const result = await submitGuess(game.event.id, game.guess)
      setGame((g) => ({ ...g, result }))
    } catch (err) {
      setGame((g) => ({ ...g, error: err.message }))
    }
  }

  if (game.loading) {
    return <div className="status">Pulling next file from the archive…</div>
  }

  if (game.error) {
    return (
      <div className="status">
        <p>Request failed: {game.error}</p>
        <button className="stamp-btn" onClick={() => startNewRound(false)}>
          Retry
        </button>
      </div>
    )
  }

  const caseNo = String(round).padStart(4, '0')

  return (
    <div className="dossier">
      <div className="dossier-header">
        <span>
          Case No. <span className="case-no">{caseNo}</span>
        </span>
        <span>History Archive Div.</span>
      </div>

      <div className="event-card">
        <div className="photo-mat">
          <img src={game.event.image_url} alt={game.event.title} />
          <div className="difficulty-stamp">
            <span>{DIFFICULTY_LABEL[game.event.difficulty] || 'FILE'}</span>
            <strong>{game.event.difficulty}/5</strong>
          </div>
        </div>
        <div className="event-copy">
          <p className="eyebrow">Field report</p>
          <h2>{game.event.title}</h2>
          <p>{game.event.description}</p>
        </div>
      </div>

      <div className="map-wrap">
        <span className="map-label">Pinpoint the location</span>
        <GameMap
          guess={game.guess}
          actual={
            game.result
              ? { latitude: game.result.actual_latitude, longitude: game.result.actual_longitude }
              : null
          }
          onGuess={handleGuess}
          disabled={!!game.result}
        />
      </div>

      {!game.result && (
        <div className="action-row">
          <button className="stamp-btn" onClick={handleSubmit} disabled={!game.guess}>
            {game.guess ? 'File guess' : 'Click the map to place a pin'}
          </button>
        </div>
      )}

      {game.result && (
        <div className="result">
          <div className="verdict-stamp">{verdictFor(game.result.score)}</div>
          <p className="detail">
            Off by <strong>{game.result.distance_km} km</strong> — the event took place in{' '}
            <strong>{game.result.year}</strong>.
          </p>
          <p className="score-line">
            Score: <strong>{game.result.score}</strong> / 5000
          </p>
          <button className="stamp-btn" onClick={() => startNewRound(true)}>
            Open next case
          </button>
        </div>
      )}
    </div>
  )
}

export default App
