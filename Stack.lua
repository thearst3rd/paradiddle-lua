-- Simple class that handles the creation and usage of stacks
-- by thearst3rd

Stack = {} -- actual stack class
Stack.__index = Stack

function Stack:new() -- stack constructor
   return setmetatable( {}, Stack );
end

function Stack:push( value ) -- pushes a value to the stack
   table.insert( self, 1, value );
end

function Stack:pop() -- pops a value from the stack and returns it
   --if #self > 0 then
      return table.remove( self, 1 );
   --else
      --error( "Error: no value on stack" );
   --end
end

function Stack:peek() -- returns first value in stack
   --if #self > 0 then
      return self[1];
   --else
      --error( "Error: no value on stack" );
   --end
end