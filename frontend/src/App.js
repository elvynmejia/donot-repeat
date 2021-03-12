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
  }, [])


  useEffect(() => {
    fetchData();
  }, [fetchData]);

  return (
    <div>
      <h5>Welcome to Repeat</h5>
      <p>See analytics some analytics below</p>
      <pre>{JSON.stringify(data)}</pre>
    </div>

  )
}
export default App;
