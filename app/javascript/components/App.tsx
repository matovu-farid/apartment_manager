import { Switch } from '@radix-ui/react-switch';
import React from 'react'
import { createPortal } from 'react-dom';


function App() {
  return (
    <div>
      <h1 className='text-3xl font-bold underline text-red-500'>Title</h1>
      <p className='text'>Hello</p>
    </div>
  )
}
export function Switches(){
   const elements = document.querySelectorAll('.switch');
  console.log({elements})
   

  return Array.from(elements).map((element) => {
    return createPortal(<Switch />, element);
  });
}
export default App
