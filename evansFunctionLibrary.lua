local M = {} -- Create a table to hold our module

-- Define the outer function
function M.Text()

  -- Define the inner function PrintBlankLines
  function M.BlankLines(numberOfLines)
    for i = 1, numberOfLines do
      print() -- Print a blank line
    end
  end

  -- Define the inner function PrintText
  function M.Text(text,blankLinesBefore,blankLinesAfter)
    M.BlankLines(blankLinesBefore)
    print(text)
    M.BlankLines(blankLinesAfter)
  end

  function M.Clear()
    os.execute("clear")
  end

  function M.Sleep(seconds)
    os.execute(seconds)
  end

  function M.DateAndTime()
     print(os.date("%Y-%m-%d %H:%M"))
  end
  
  function M.DividerLine(length, symbol, blankLinesBefore, blankLinesAfter)  
    M.BlankLines(blankLinesBefore)
  local dividerLine = ""
    for i = 1, length do
    dividerLine = dividerLine .. symbol
    end
    print(dividerLine)
    M.BlankLines(blankLinesAfter)
  end
   

  function M.ApplicationHeader(app_name,store_name,character)
   M.Clear()
    M.Text(app_name, 3, 2)
    M.DateAndTime()
     M.DividerLine(30, character,0,0)
  end
end

return M -- Return the module table
