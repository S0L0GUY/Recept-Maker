
-- Initialize an empty table for receipt lines
local receipt_lines = {}

-- Function to add a line to the receipt
local function add_receipt_line(item_name, item_quantity, item_price)
    local line_sale_total = item_quantity * item_price
    table.insert(receipt_lines, {
        item_name = item_name,
        item_quantity = item_quantity,
        item_price = item_price,
        line_sale_total = line_sale_total
    })
end


-- Function to add a line to the receipt
local function add_receipt_line(item_name, item_quantity, item_price)
    local line_sale_total = item_quantity * item_price
    table.insert(receipt_lines, {
        item_name = item_name,
        item_quantity = item_quantity,
        item_price = item_price,
        line_sale_total = line_sale_total
    })
end

-- Function to input a receipt item from the user
local function input_receipt_item()
    print("Enter item name:")
    local item_name = io.read()
    print("Enter item quantity:")
    local item_quantity = tonumber(io.read())
    print("Enter item price:")
    local item_price = tonumber(io.read())

    -- Adding the entered item to the receipt lines
    add_receipt_line(item_name, item_quantity, item_price)
end

-- Function to print the receipt
local function print_receipt()
    print("Receipt Summary:")
    for i, line in ipairs(receipt_lines) do
        print(i .. ". " .. line.item_name .. " - Quantity: " .. line.item_quantity .. ", Price: $" .. line.item_price .. ", Total: $" .. line.line_sale_total)
    end
end

-- Function to display the menu and handle user input
local function display_menu()
    local choice = 0
    while choice ~= 3 do
        print("\nMenu:")
        print("1. Add Item")
        print("2. Print Receipt")
        print("3. Exit")
        print("Enter your choice:")
        choice = tonumber(io.read())

        if choice == 1 then
            input_receipt_item()
        elseif choice == 2 then
            print_receipt()
        elseif choice == 3 then
            print("Exiting...")
        else
            print("Invalid choice, please try again.")
        end
    end
end
