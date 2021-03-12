import { render, screen } from '@testing-library/react';
import App from './App';

test('checks page content', () => {
  render(<App />);
  const mainHeading = screen.getByText(/Welcome to Repeat Analytics/i);
  const ltvsHeading = screen.getByText(/LTVS by Customer Name/i);
  const revenueHeading = screen.getByText(/LTVS by Customer Name/i);


  expect(mainHeading).toBeInTheDocument();
  expect(ltvsHeading).toBeInTheDocument();
  expect(revenueHeading).toBeInTheDocument();

  // should add some expectations for the dynamic data being displayed on inside
  // ul elements
});
