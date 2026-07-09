import { MapContainer, TileLayer, Marker, CircleMarker, useMapEvents } from 'react-leaflet'
import L from 'leaflet'
import 'leaflet/dist/leaflet.css'
import markerIcon from 'leaflet/dist/images/marker-icon.png'
import markerShadow from 'leaflet/dist/images/marker-shadow.png'

// Leaflet's default marker icon paths break under Vite's bundling — this
// re-points them at the bundled asset URLs so the guess pin actually renders.
const guessIcon = L.icon({
  iconUrl: markerIcon,
  shadowUrl: markerShadow,
  iconSize: [25, 41],
  iconAnchor: [12, 41],
})

/** Captures clicks on the map and reports the lat/lng back to the parent. */
function ClickCapture({ onGuess }) {
  useMapEvents({
    click(e) {
      onGuess({ latitude: e.latlng.lat, longitude: e.latlng.lng })
    },
  })
  return null
}

/**
 * The guessing map. Shows the player's pending guess as a pin, and once a
 * result comes back, also shows the actual location as a red circle.
 */
export default function GameMap({ guess, actual, onGuess, disabled }) {
  return (
    <MapContainer
      center={[20, 0]}
      zoom={2}
      style={{ height: '360px', width: '100%' }}
      zoomControl={true}
    >
      <TileLayer
        attribution='&copy; OpenStreetMap contributors'
        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
      />
      {!disabled && <ClickCapture onGuess={onGuess} />}
      {guess && (
        <Marker position={[guess.latitude, guess.longitude]} icon={guessIcon} />
      )}
      {actual && (
        <CircleMarker
          center={[actual.latitude, actual.longitude]}
          radius={8}
          pathOptions={{ color: '#a13d2b', fillColor: '#a13d2b', fillOpacity: 0.85, weight: 2 }}
        />
      )}
    </MapContainer>
  )
}
