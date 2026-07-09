import { useEffect, useState, useCallback } from 'react'
import { fetchRandomEvent, submitGuess } from './api'
import GameMap from './components/GameMap'
import './App.css'

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

  const startNewRound = useCallback(async () => {
    setGame({ event: null, guess: null, result: null, loading: true, error: null })
    try {
      const event = await fetchRandomEvent()
      setGame({ event, guess: null, result: null, loading: false, error: null })
    } catch (err) {
      setGame((g) => ({ ...g, loading: false, error: err.message }))
    }
  }, [])

  useEffect(() => {
    startNewRound()
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
    return <div className="status">Loading round…</div>
  }

  if (game.error) {
    return (
      <div className="status">
        <p>Something went wrong: {game.error}</p>
        <button onClick={startNewRound}>Try again</button>
      </div>
    )
  }

  return (
    <div className="game">
      <header className="event-card">
        <img src={game.event.image_url} alt={game.event.title} />
        <div>
          <h2>{game.event.title}</h2>
          <p>{game.event.description}</p>
        </div>
      </header>

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

      {!game.result && (
        <button onClick={handleSubmit} disabled={!game.guess}>
          {game.guess ? 'Submit guess' : 'Click the map to place your guess'}
        </button>
      )}

      {game.result && (
        <div className="result">
          <p>
            You were <strong>{game.result.distance_km} km</strong> away — the event was in{' '}
            <strong>{game.result.year}</strong>.
          </p>
          <p className="score">Score: {game.result.score} / 5000</p>
          <button onClick={startNewRound}>Next round</button>
        </div>
      )}
    </div>
  )
}

export default App