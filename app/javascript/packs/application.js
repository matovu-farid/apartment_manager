
// app/javascript/packs/application.js
import 'core-js/stable'
import 'regenerator-runtime/runtime'
import 'react'
import 'react-dom'
import { createRoot } from 'react-dom/client'
import App from './components/App'
import "sweetalert"
console.log('Hello from pack application.js')
document.addEventListener('DOMContentLoaded', () => {
  const rootElement = document.getElementById('root')
  if (rootElement) {
    const root = createRoot(rootElement)
    root.render(<App />)
  }
})
