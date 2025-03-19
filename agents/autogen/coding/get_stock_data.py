# filename: get_stock_data.py

# Check for installed libraries and if not, we need to install them
try:
    import yfinance as yf
    import matplotlib.pyplot as plt
except ImportError:
    print("Please install the required libraries first. Run the following command in your terminal:")
    print("pip install yfinance matplotlib")
    exit()

# Import necessary libraries
import yfinance as yf
import matplotlib.pyplot as plt