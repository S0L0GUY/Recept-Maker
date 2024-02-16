-- Declairs all variadables neded
------------------------------------------------
local user_input = nil
local items = {}
local item_count = {}
local item_cost = {}
total_cost = 0
tax_rate = 7.25
local store_name = nil
local alltime_item_count = {}
local alltime_item_cost = {}
local alltime_items = {}
local total = nil
---------------------------------------------------


-- All Functions
--------------------------------------------------
function initial_setup() --Gets everything set up for the first time
  print_hedder()
  print("Store Name?")
  store_name = tostring(string.upper(io.read()))
  print_hedder()
  print("Date & Time:" .. current_time())
  os.execute("sleep 1")
end

function print_hedder() --Prints the hedder
  os.execute("clear")
  
  print("Lua Recept Maker")
  print("-------------------------------------------------------------------------------------")
end

function current_time() -- Formats the time and date.
  return os.date("%Y-%m-%d %H:%M")
end

function print_questions() -- Acting as the home, this prints the options that the user can take.
  print_hedder()
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
    print_hedder()
    print("Sorry, " .. tostring(user_input) .. "is not a valid input.")
    os.execute("sleep 2")
    print_questions()
  end
end

function new_order() -- Handles a new order
  print_hedder()

  print("")
  print("")

  local count = 1 -- Prints all of the items in the recept
  for i = 1, #items do
    os.execute("sleep 0.1")
    print(items[count] .. " (" .. item_count[count] .. ") " .. "$" .. item_cost[count])
    count = count + 1
  end
  
  print("")
  print("")
  
  print("-------------------------------------------------------------------------------------")
  
  print("1. New Item")
  print("2. Remove Item")
  print("3. Print Recept")
  local user_input = tonumber(io.read())

  if user_input == 1 then -- Handles user input.
    
    print_hedder()
    print("Item name?")
    local user_input = tostring(string.upper(io.read()))
    table.insert(items, user_input)
    table.insert(alltime_items, user_input)

    print_hedder()
    print("What is the price of this item?")
    local user_input = tonumber(io.read())
    table.insert(item_cost, user_input)
    table.insert(alltime_item_cost, user_input)

    print_hedder()
    print("How many of this item?")
    local user_input = tonumber(io.read())
    table.insert(item_count, user_input)
    table.insert(alltime_item_count, user_input)

    print_hedder()
    print("Item has been added to recept")
    os.execute("sleep 2")
    new_order()
  elseif user_input == 2 then
    remove_item()
  elseif user_input == 3 then
    print_items()
  else
    print("Sorry, " .. tostring(user_input) .. " is not a valif input.")
    os.execute("sleep 2")
    new_order()
  end
end

function load_stats() -- Loads the stats
  print_hedder( )
  print(store_name .. " Stats.")
  print("-------------------------------------------------------------------------------------")
  print("")

  local count = 1
  for i = 1, #items do
    os.execute("sleep 0.1")
    print(items[count] .. " (" .. alltime_item_count[count] .. " @ " .. item_cost[count] .. ") " .. "$" .. alltime_item_cost[count] * alltime_item_count[count])
    count = count + 1
  end

  print("")

  local total_cost = 0 -- Gets total cost of receipt
  local count = 1
  for i = 1, #alltime_item_cost do
    os.execute("sleep 0.1")
    total_cost = total_cost + alltime_item_cost[count] * alltime_item_count[count]
    count = count + 1
  end
  
  local total = total_cost * tax_rate / 100
  local total_cost = string.format("%.2f", total_cost)
  local total = string.format("%.2f", total)

  print("")
  
  print("Subtotal:  $" .. tostring(total_cost))
  print("Tax:       $" .. tostring(total))
  print("-------------------------------------")
  print("Total:     $" .. tostring(total_cost + total))
  
  print("")
  print("-------------------------------------------------------------------------------------")
  print("Press ENTER to return home")
  user_input = io.read()
  print_questions()
end

function print_items() -- Prints reciept
  print_hedder()
  print("")
  print("")

  print("                        " .. store_name)
  print("")
  


  local count = 1 -- Prints every item on receipt
  for i = 1, #items do
    os.execute("sleep 0.1")
    print(alltime_items[count] .. " (" .. alltime_item_count[count] .. " @ " .. item_cost[count] .. ") " .. "$" .. alltime_item_cost[count] * alltime_item_count[count])
    count = count + 1
  end

  
  local total_cost = 0 -- Gets total cost of receipt
  local count = 1
  for i = 1, #item_cost do
    os.execute("sleep 0.1")
    total_cost = total_cost + item_cost[count] * item_count[count]
    count = count + 1
  end
  
  print("")
  
  
  local total = total_cost * tax_rate / 100
  local total_cost = string.format("%.2f", total_cost)
  local total = string.format("%.2f", total)

  print("Subtotal:  $" .. tostring(total_cost))
  print("Tax:       $" .. tostring(total))
  print("-------------------------------------")
  print("Total:     $" .. tostring(total_cost + total))

  print("")
  print("-------------------------------------------------------------------------------------")
  print("Press enter to return home.")
  local user_input = io.read()
  print_questions()
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
  print_hedder()
  print("What is the item name?")
  local user_input = tostring(string.upper(io.read()))
  if count_occurrences(items, user_input) > 0 then
    local item_id = find_item_position(items, user_input)
    table.remove(items, item_id)
    table.remove(item_count, item_id)
    table.remove(item_cost, item_id)
    print(user_input .. " has sucsessfully been removed.")
    os.execute("sleep 2")
    new_order()
  else
    print("Sorry," .. user_input .. " is not a valid input")
    os.execute("sleep 2")
    new_order()
  end
end

function find_item_position(list, item) -- Finds the position of the user/password.
    for i, v in ipairs(list) do
        if v == item then
            return i
        end
    end
    return nil
end
