import yfinance as yf
import matplotlib.pyplot as plt

# Download stock data for NVDA and TESLA (Year-to-Date)
nvda_data = yf.download("NVDA", period="ytd")
tesla_data = yf.download("TSLA", period="ytd")

# Plotting the stock prices
plt.figure(figsize=(12, 6))

plt.plot(nvda_data['Close'], label='NVDA', color='blue')
plt.plot(tesla_data['Close'], label='TSLA', color='red')

plt.title('NVIDIA (NVDA) vs. Tesla, Inc. (TSLA) - Year-to-Date Stock Prices')
plt.xlabel('Date')
plt.ylabel('Stock Price (USD)')
plt.legend()
plt.grid(True)

# Save the plot as a PNG file
plt.savefig('nvda_tesla_stock_chart.png')

print("Chart saved as nvda_tesla_stock_chart.png")
