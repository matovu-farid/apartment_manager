import React from 'react'
import 'react-dom'

import { createRoot } from 'react-dom/client';
import MyApp from '../components/App';


document.addEventListener('DOMContentLoaded', () => {
  const rootElement = document.getElementById('root')
  if (rootElement) {
    console.log('Root element found')
    const root = createRoot(rootElement)
    root.render(<div><MyApp /></div>)
  }})

