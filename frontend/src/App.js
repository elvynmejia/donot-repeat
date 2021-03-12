import React, { useState, useEffect, useCallback } from 'react';
import axios from 'axios';

import './App.css';

const API_URL = 'http://localhost:9292/stats';

const App = (props) => {
  const [data, setData] = useState({
    ltvs: {},
    orders_placed: 0,
    revenue_by_product: {},
  });

  const fetchData = useCallback(async () => {
    // handle errors try/catch
    const response = await axios.get(API_URL);
    setData(response.data);
  }, []);

  useEffect(() => {
    fetchData();
  }, [fetchData]);

  const {
    orders_placed,
    ltvs,
    revenue_by_product
  } = data;

  return (
    <div>
      <h3>Welcome to Repeat</h3>
      <p>See some analytics below</p>
      <pre>{JSON.stringify(data)}</pre>
      <p>Number of orders placed: {orders_placed}</p>

      <h4>LTVS by customer</h4>
      <ul>
        {Object.keys(ltvs).map(key => {
          const { total, customer } = ltvs[key];

          return (
            <li key={key}>
              {customer.first_name} has spent ${total}
            </li>
          )
        })}
      </ul>

    </div>

  )
}
export default App;
