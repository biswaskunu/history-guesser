const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8000'

/**
 * Fetch a random event to play as the next round.
 * @param {number|null} difficulty - optional filter, 1 (easiest) to 5 (hardest)
 */
export async function fetchRandomEvent(difficulty = null, excludeIds = []) {
  const url = new URL('/events/random', API_URL)
  if (difficulty) url.searchParams.set('difficulty', difficulty)
  if (excludeIds.length > 0) url.searchParams.set('exclude', excludeIds.join(','))

  const res = await fetch(url)
  if (!res.ok) {
    const body = await res.json().catch(() => ({}))
    throw new Error(body.error || `Failed to fetch event (${res.status})`)
  }
  return res.json()
}

/**
 * Submit a guess for a given event and get back the distance/score.
 * @param {string} eventId
 * @param {{ latitude: number, longitude: number }} guess
 */
export async function submitGuess(eventId, guess) {
  const res = await fetch(new URL(`/events/${eventId}/guess`, API_URL), {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(guess),
  })
  if (!res.ok) {
    const body = await res.json().catch(() => ({}))
    throw new Error(body.error || `Failed to submit guess (${res.status})`)
  }
  return res.json()
}