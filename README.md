# Lua Receipt Maker
This Lua script allows users to generate and manage receipts for their purchases. Users can add items, specify quantities, and calculate totals. Below is a breakdown of the script and its functionalities.

# Variables
The script declares the following variables:

user_input, items, item_count, item_cost: Store information about items and their quantities.

total_cost: Keeps track of the total cost.

tax_rate: Specifies the tax rate.

store_name: Stores the name of the store.

alltime_item_count, alltime_item_cost, alltime_items: Tracks historical item data.

total: Holds the total cost.

# Functions
initial_setup()
Sets up the initial environment by prompting the user to input the store name and displaying the current date and time.

print_hedder()
Prints the header with the name of the script.

current_time()
Formats the current date and time.

print_questions()
Displays the main menu with options for creating a new order or viewing statistics.

new_order()
Handles the creation of a new order.
Allows users to add items, specify prices and quantities, and view the receipt.

load_stats()
Displays statistics such as store name, item names, quantities, and costs.

print_items()
Prints the receipt with item details and calculates the subtotal and total including tax.

count_occurrences(table, value)
Counts occurrences of a value in a table.

remove_item()
Allows users to remove an item from the receipt.

find_item_position(list, item)
Finds the position of an item in a list.

# Usage
Run the script.
Follow the prompts to set up the store name and create new orders.
Add items, specify prices and quantities, and view the receipt.
Remove items if needed.
View statistics to track historical data.
# Notes
Make sure to keep both main.lua and functions.lua in the same directory for proper execution.
This script provides a simple way to manage receipts and track purchases. Feel free to customize it further to suit your needs.
