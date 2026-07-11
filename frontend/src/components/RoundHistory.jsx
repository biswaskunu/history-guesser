function verdictFor(score) {
  if (score >= 4500) return 'Bullseye'
  if (score >= 3000) return 'Close guess'
  if (score >= 1000) return 'In the region'
  return 'Way off'
}

/**
 * Scrollable list of completed rounds this session, most recent first.
 */
export default function RoundHistory({ history }) {
  if (history.length === 0) {
    return (
      <div className="history-panel history-empty">
        Your completed rounds will show up here.
      </div>
    )
  }

  const reversed = [...history].reverse()

  return (
    <div className="history-panel">
      <h3 className="history-title">Session history</h3>
      <ul className="history-list">
        {reversed.map((entry) => (
          <li key={entry.round} className="history-item">
            <span className="history-round">#{entry.round}</span>
            <div className="history-main">
              <span className="history-event">{entry.title}</span>
              <span className="history-meta">
                {entry.year} · {entry.distance_km} km · {verdictFor(entry.score)}
              </span>
            </div>
            <span className="history-score">{entry.score}</span>
          </li>
        ))}
      </ul>
    </div>
  )
}
