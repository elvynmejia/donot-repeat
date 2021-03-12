import React, { useState, useEffect } from 'react';
import axios from 'axios';


import logo from './logo.svg';
import './App.css';

// function App() {
//   return (
//     <div className="App">
//       <header className="App-header">
//         <img src={logo} className="App-logo" alt="logo" />
//         <p>
//           Edit <code>src/App.js</code> and save to reload.
//         </p>
//         <a
//           className="App-link"
//           href="https://reactjs.org"
//           target="_blank"
//           rel="noopener noreferrer"
//         >
//           Learn React
//         </a>
//       </header>
//     </div>
//   );
// }

const API_URL = 'http://localhost:9292/stats';

const App = (props) => {
  const [data, setData] = useState({
    ltvs: {},
    orders_placed: 0,
    revenue_by_product: {},
  });


  useEffect(async () => {
    const result = await axios(
      API_URL,
    );

    setData(result.data);
  });

  return (
    <div>
      <h5>Welcome to Repeat</h5>
      <p>See analytics some analytics below</p>
      <pre>{data}</pre>
    </div>

  )
}
export default App;
