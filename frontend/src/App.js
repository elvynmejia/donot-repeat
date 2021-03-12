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
      <h3>Welcome to Repeat Analytics</h3>
      <h4>Number of orders placed: {orders_placed}</h4>

      <h4>LTVS by Customer Name</h4>
      <ul>
        {Object.keys(ltvs).map(key => {
          const { total, customer } = ltvs[key];

          return (
            <li key={key}>
              {customer.first_name} has spent ${total.toFixed(2)}
            </li>
          )
        })}
      </ul>

      <h4>Revenue by Product Name</h4>
      <ul>
        {Object.keys(revenue_by_product).map(key => {
          const { total, line_item } = revenue_by_product[key];

          return (
            <li key={key}>
              {line_item.name} has generate ${total.toFixed(2)} in revenue
            </li>
          )
        })}
      </ul>

    </div>

  )
}
export default App;
