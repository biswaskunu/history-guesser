import { useEffect, useState, useCallback } from 'react'
import { fetchRandomEvent, submitGuess } from './Api'
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
    return (
      <div className="status-container">
        <div className="spinner"></div>
        <div className="status-message">Pulling next record from archive...</div>
      </div>
    )
  }

  if (game.error) {
    return (
      <div className="status-container">
        <div className="status-message" style={{ marginBottom: '1.5rem' }}>
          Error: {game.error}
        </div>
        <button className="action-btn" style={{ maxWidth: '200px' }} onClick={() => startNewRound(false)}>
          Retry
        </button>
      </div>
    )
  }

  const caseNo = String(round).padStart(4, '0')

  return (
    <>
      {/* Header */}
      <header className="app-header">
        <div className="app-title">History<span>Guesser</span></div>
        <div className="case-badge">CASE #{caseNo}</div>
      </header>

      {/* Main Grid Container */}
      <main className="game-container">
        
        {/* Left Column: Image, Title, Description, and Submit Button */}
        <section className="left-col">
          <div className="event-card">
            <div className="photo-container">
              <img src={game.event.image_url} alt={game.event.title} />
              <div className="difficulty-pill">
                Difficulty: <span>{game.event.difficulty}/5</span>
              </div>
            </div>
            <div className="event-copy">
              <p className="eyebrow">{DIFFICULTY_LABEL[game.event.difficulty] || 'ARCHIVE FILE'}</p>
              <h2>{game.event.title}</h2>
              <p>{game.event.description}</p>
            </div>
          </div>

          {!game.result && (
            <div className="action-row">
              <button 
                className="action-btn" 
                onClick={handleSubmit} 
                disabled={!game.guess}
              >
                {game.guess ? 'Submit Coordinates' : 'Select location on map'}
              </button>
            </div>
          )}
        </section>

        {/* Right Column: Map Selection and Verdict Details */}
        <section className="right-col">
          <div className="map-card">
            <div className="map-label">
              <span>Target Coordinates</span>
            </div>
            <div className="map-wrap">
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
          </div>

          {game.result && (
            <div className="result-card">
              <div className="result-header">
                <span className={`verdict-tag verdict-${verdictFor(game.result.score)}`}>
                  {verdictFor(game.result.score)}
                </span>
                <div className="score-display">
                  {game.result.score}<span>/5000</span>
                </div>
              </div>
              <p className="result-detail">
                Your pin missed the mark by <strong>{game.result.distance_km} km</strong>. 
                This historical event occurred in the year <strong>{game.result.year}</strong>.
              </p>
              <button className="action-btn" onClick={() => startNewRound(true)}>
                Next Round
              </button>
            </div>
          )}
        </section>

      </main>
    </>
  )
}

export default App