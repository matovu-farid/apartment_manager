import React from 'react'
import 'react-dom'

import { createRoot } from 'react-dom/client';
import MyApp from '../components/App';


function SwitchDemo() {
  return (
    <div className="flex items-center space-x-2 bg-black">
    </div>
  )
}
//import { document } from 'postcss';



document.addEventListener('DOMContentLoaded', () => {
  const rootElement = document.getElementById('root')
  if (rootElement) {
    console.log('Root element found')
    const root = createRoot(rootElement)
    root.render(<div><MyApp /></div>)
  }

  const switches = document.querySelectorAll('.switch')
  switches.forEach((element) => {
    console.log('Switch element found')
    const root = createRoot(element)
    root.render(<div><SwitchDemo /></div>)
  })
})


