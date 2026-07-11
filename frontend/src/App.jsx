import { useEffect, useState, useCallback } from 'react'
import { fetchRandomEvent, submitGuess } from './api'
import GameMap from './components/GameMap'
import RoundHistory from './components/RoundHistory'
import './App.css'

const DIFFICULTY_LABEL = {
  1: 'Easy',
  2: 'Casual',
  3: 'Moderate',
  4: 'Challenging',
  5: 'Expert',
}

// A round counts toward a streak once its score clears this bar — matches
// the "Close guess" verdict tier so the streak reflects consistently good guesses.
const STREAK_THRESHOLD = 3000

function verdictFor(score) {
  if (score >= 4500) return 'Bro, touch some grass!'
  if (score >= 3000) return 'Close guess'
  if (score >= 1000) return 'In the region'
  return 'Bro really missed , is this your first time playing?'
}


function SunIcon() {
  return (
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
      <circle cx="12" cy="12" r="4.5" />
      <path d="M12 2.5v2.5M12 19v2.5M4.2 4.2l1.8 1.8M18 18l1.8 1.8M2.5 12H5M19 12h2.5M4.2 19.8L6 18M18 6l1.8-1.8" />
    </svg>
  )
}

function MoonIcon() {
  return (
    <svg viewBox="0 0 24 24" fill="currentColor">
      <path d="M20.5 14.5A8.5 8.5 0 1 1 9.5 3.5a7 7 0 0 0 11 11Z" />
    </svg>
  )
}

function usePreferredTheme() {
  const [theme, setTheme] = useState(() => {
    const stored = localStorage.getItem('theme')
    if (stored === 'light' || stored === 'dark') return stored
    return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
  })

  useEffect(() => {
    document.documentElement.dataset.theme = theme
    localStorage.setItem('theme', theme)
  }, [theme])

  return [theme, setTheme]
}

// Consecutive rounds (from the most recent backwards) scoring at or above
// the streak threshold. Resets the moment a round falls short.
function computeStreak(history) {
  let streak = 0
  for (let i = history.length - 1; i >= 0; i--) {
    if (history[i].score >= STREAK_THRESHOLD) {
      streak += 1
    } else {
      break
    }
  }
  return streak
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
  const [history, setHistory] = useState([])
  const [theme, setTheme] = usePreferredTheme()

  const totalScore = history.reduce((sum, entry) => sum + entry.score, 0)
  const streak = computeStreak(history)

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
      setHistory((h) => [
        ...h,
        {
          round,
          title: game.event.title,
          year: result.year,
          distance_km: result.distance_km,
          score: result.score,
        },
      ])
    } catch (err) {
      setGame((g) => ({ ...g, error: err.message }))
    }
  }

  function toggleTheme() {
    setTheme((t) => (t === 'dark' ? 'light' : 'dark'))
  }

  if (game.loading) {
    return (
      <div className="status">
        <div className="status-spinner" />
        Loading round…
      </div>
    )
  }

  if (game.error) {
    return (
      <div className="status">
        <p>Something went wrong: {game.error}</p>
        <button className="next-btn" onClick={() => startNewRound(false)}>
          Try again
        </button>
      </div>
    )
  }

  return (
    <div>
      <div className="top-bar">
        <span className="brand">History Guesser</span>
        <div className="top-bar-right">
          <span className="round-badge">Round {round}</span>
          {history.length > 0 && (
            <span className="total-badge">Total {totalScore}</span>
          )}
          {streak >= 2 && (
            <span className="streak-badge">🔥 {streak} streak</span>
          )}
          <button
            className="theme-toggle"
            onClick={toggleTheme}
            aria-label={theme === 'dark' ? 'Switch to light mode' : 'Switch to dark mode'}
            title={theme === 'dark' ? 'Switch to light mode' : 'Switch to dark mode'}
          >
            {theme === 'dark' ? <SunIcon /> : <MoonIcon />}
          </button>
        </div>
      </div>

      <div className="game-layout" key={game.event.id}>
        {/* Left column: event info + session history */}
        <div className="left-column">
          <div className="panel event-panel">
            <div className="event-photo">
              <img src={game.event.image_url} alt={game.event.title} />
              <span className="difficulty-chip">{DIFFICULTY_LABEL[game.event.difficulty] || 'Unknown'}</span>
            </div>
            <div className="event-body">
              <h2>{game.event.title}</h2>
              <p>{game.event.description}</p>
            </div>
            {!game.result && (
              <button
                className={`submit-btn${game.guess ? ' armed' : ''}`}
                onClick={handleSubmit}
                disabled={!game.guess}
              >
                {game.guess ? 'Submit guess' : 'Click the map to guess'}
              </button>
            )}
            {game.result && (
              <button className="next-btn" onClick={() => startNewRound(true)}>
                Next round
              </button>
            )}
          </div>

          <RoundHistory history={history} />
        </div>

        {/* Right column: map + result */}
        <div className="right-column">
          <div className="panel map-panel">
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

          {game.result ? (
            <div className="panel result-panel">
              <div className="verdict-row">
                <span className="verdict-badge">{verdictFor(game.result.score)}</span>
              </div>
              <div className="result-stats">
                <div className="stat">
                  <p className="label">Distance</p>
                  <p className="value">{game.result.distance_km} km</p>
                </div>
                <div className="stat">
                  <p className="label">Year</p>
                  <p className="value">{game.result.year}</p>
                </div>
                <div className="stat score">
                  <p className="label">Score</p>
                  <p className="value">{game.result.score}</p>
                </div>
              </div>
            </div>
          ) : (
            <div className="panel result-empty">
              Place a pin on the map, then submit your guess to see the result here.
            </div>
          )}
        </div>
      </div>
    </div>
  )
}

export default App
