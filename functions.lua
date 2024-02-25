-- Variables -----------------------------------
local application_name = "Lua Receipt Maker"
local use_test_data = true
local store_name = nil
local user_input = nil
local receipt_line_item_name = {}
local receipt_line_quantity = {}
local receipt_line_item_price = {}
tax_rate = 7.25
local reciept_line_total_quantity = {}
local alltime_item_cost = {}
local alltime_items = {}
local total = nil
---------------------------------------------------

--20240216 MM Use evansFunctionLibrary module
local display = require("evansFunctionLibrary")
display.Text()
---------------------------------------------------


-- All Functions
---------------------------------------------------
function initialize_application() --Gets everything set up for the first time
  if use_test_data then
    display.Clear()
    display.ApplicationHeader(application_name, store_name, "-")
    display.Sleep(1)
  else
    display.Clear()
    display.ApplicationHeader(application_name, "", "-")
    display.Text("Store Name?", 0, 0)
    store_name = tostring(string.upper(io.read()))
    display.ApplicationHeader(application_name, store_name, "-")
    display.Sleep(1)
  end
end

function display_initial_menu() -- Acting as the home, this prints the options that the user can take.
  display.ApplicationHeader(application_name, "", "-")
  print("1. New Order")
  print("2. Stats")

  local user_input = io.read()
  local user_input = tonumber(user_input)
  if user_input == 1 then -- Handles the user input
    print("Loading new order..")
    new_order()
  elseif user_input == 2 then
    print("Loading stats..")
    load_stats()
  else
    display.ApplicationHeader(application_name, "", "-")
    print("Sorry, " .. tostring(user_input) .. "is not a valid input.")
    os.execute("sleep 2")
    display_initial_menu()
  end
end

function new_order() -- Handles a new order
  display.ApplicationHeader(application_name, store_name, "-")

  display.BlankLines(2)

  local count = 1 -- Prints all of the items in the recept
  for i = 1, #receipt_line_item_name do
    os.execute("sleep 0.1")
    print(receipt_line_item_name[count] ..
      " (" .. receipt_line_quantity[count] .. ") " .. "$" .. receipt_line_item_price[count])
    count = count + 1
  end

  display.DividerLine(30, "-", 2, 0)

  print("1. New Item")
  print("2. Remove Item")
  print("3. Print Recept")
  local user_input = tonumber(io.read())

  if user_input == 1 then -- Handles user input.

    display.ApplicationHeader(application_name, store_name, "-")
    print("Item name?")
    local user_input = tostring(string.upper(io.read()))
    table.insert(receipt_line_item_name, user_input)
    table.insert(alltime_items, user_input)

    display.ApplicationHeader(application_name, store_name, "-")
    print("What is the price of this item?")
    local user_input = tonumber(io.read())
    table.insert(receipt_line_item_price, user_input)
    table.insert(alltime_item_cost, user_input)

    display.ApplicationHeader(application_name, store_name, "-")
    print("How many of this item?")
    local user_input = tonumber(io.read())
    table.insert(receipt_line_quantity, user_input)
    --table.insert(reciept_line_total_quantity, user_input)

    display.ApplicationHeader(application_name, store_name, "-")
    print("Item has been added to recept")
    os.execute("sleep 2")
    new_order()
  elseif user_input == 2 then
    remove_item()
  elseif user_input == 3 then
    print_reciept_lines()
  else
    print("Sorry, " .. tostring(user_input) .. " is not a valif input.")
    display.Sleep(2)
    new_order()
  end
end

function load_stats() -- Loads the stats
  display.ApplicationHeader(application_name, store_name, "-")
  print(store_name .. " Stats.")
  display.Text("Stats", 0, 1)

  if #alltime_items > 0 then -- Cheks if any items have ever been purchased
    local count = 1
    for i = 1, #receipt_line_item_name do
      os.execute("sleep 0.1")
      print(receipt_line_item_name[count] ..
        " (" .. reciept_line_quantity[count] .. ") " .. "$" .. alltime_item_cost[count] * reciept_line_quantity[count])
      count = count + 1
    end

    print("")

    local total_cost = 0 -- Gets total cost of receipt
    local count = 1
    for i = 1, #alltime_item_cost do
      os.execute("sleep 0.1")
      total_cost = total_cost + alltime_item_cost[count] * reciept_line_total_quantity[count]
      count = count + 1
    end

    local total = total_cost * tax_rate / 100
    local total_cost = string.format("%.2f", total_cost)
    local total = string.format("%.2f", total)

    print("")
    display.Text("Subtotal:  $" .. tostring(total_cost))

    print("Tax:       $" .. tostring(total))
    display.DividerLine(37, "-", 0, 0)
    print("Total:     $" .. tostring(total_cost + total))
  else
    print("No items have been purchased.")
  end
  
  display.ApplicationHeader(application_name, store_name, "-")
  print("Press ENTER to return home")
  user_input = io.read()
  display_initial_menu()
end

function print_reciept_lines() -- Prints reciept

  display.BlankLines(2)
  display.Text("                        " .. store_name, 0, 1)
  local count = 1 -- Prints every item on receipt
  for i = 1, #receipt_line_item_name do
    os.execute("sleep 0.1")
    print(alltime_items[count] ..
      " (" ..
      reciept_line_total_quantity[count] .. ") " .. "$" .. alltime_item_cost[count] * reciept_line_total_quantity[count])
    count = count + 1
  end

  local total_cost = 0 -- Gets total cost of receipt
  local count = 1
  for i = 1, #receipt_line_item_price do
    os.execute("sleep 0.1")
    total_cost = total_cost + receipt_line_item_price[count] * receipt_line_quantity[count]
    count = count + 1
  end

  display.BlankLines(1)

  local total = total_cost * tax_rate / 100
  local total_cost = string.format("%.2f", total_cost)
  local total = string.format("%.2f", total)

  print("Subtotal:  $" .. tostring(total_cost))
  print("Tax:       $" .. tostring(total))
  display.DividerLine(37, "-", 0, 0)
  print("Total:     $" .. tostring(total_cost + total))

  display.ApplicationHeader(application_name, store_name, "-")
  print("Press enter to return home.")
  local user_input = io.read()
  display_initial_menu()
end

function count_occurrences(table, value) -- Counts if the user_input is in the tables.
  local count = 0
  for _, v in ipairs(table) do
    if v == value then
      count = count + 1
    end
  end
  return count
end

function remove_item() -- Removes an item from the reciept
  display.ApplicationHeader(application_name, store_name, "-")
  print("What is the item name?")
  local user_input = tostring(string.upper(io.read()))
  if count_occurrences(receipt_line_item_name, user_input) > 0 then
    local item_id = find_item_position(receipt_line_item_name, user_input)
    table.remove(receipt_line_item_name, item_id)
    table.remove(receipt_line_quantity, item_id)
    table.remove(receipt_line_item_price, item_id)
    print(user_input .. " has sucsessfully been removed.")
    os.execute("sleep 2")
    new_order()
  else
    print("Sorry," .. user_input .. " is not a valid input")
    os.execute("sleep 2")
    new_order()
  end
end

function find_item_position(list, item) -- Finds the position of the item.
  for i, v in ipairs(list) do
    if v == item then
      return i
    end
  end
  return nil
end
