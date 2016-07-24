-- Paradiddle esoteric programming language
-- Created by Terry Hearst

require( "Stack" ); -- Stack class

local debugMode = false;

function paradiddle( code, stdin )

	do -- cleans code
	
		local oldcode = code;
		local location = 1; -- location in the string of code
		code = "";
		while location <= oldcode:len() do
			local ltr = oldcode:sub( location, location );
			if ltr == 'R' or ltr == 'L' then -- if R or L then keep it in the code
				code = code .. ltr;
			elseif ltr == '"' then -- if " then skip to next "
				local brk = false;
				while location <= oldcode:len() and not brk do
					location = location + 1;
					brk = oldcode:sub( location, location ) == '"';
				end
			end
			location = location + 1;
		end
		if code:len() % 2 == 1 then -- if code length is an odd number, cut off last character
			code = code:sub( 1, code:len() - 1 );
		end
		
	end
	
	if debugMode then print( code ); end -- debug, print cleaned code
	
	local ops = {}; -- table of all operations
	
	do -- parse code into ops table
	
		local location = 1;
		while location <= code:len() do
			--io.write( code:sub( location, location ), code:sub( location + 1, location + 1 ), tostring( code:sub( location, location ) == code:sub( location + 1, location + 1 ) ), '\n' )
			if not ( code:sub( location, location ) == code:sub( location + 1, location + 1 ) ) then
				local oldlocation = location;
				local brk = false;
				while location <= code:len() and not brk do
					location = location + 2;
					brk = not ( code:sub( location, location ) == code:sub( location + 1, location + 1 ) );
				end
				location = location - 2;
				table.insert( ops, ( location - oldlocation ) / 2 )
			end
			location = location + 2;
		end
	
	end
	
	if debugMode then for k, v in ipairs( ops ) do io.write( tostring( v ), ' ' ); end print(); end -- debug, print op values
	
	local output = "";
	
	do -- perform operations
	
		local location = 1;
		local stack = Stack:new();
		
		local inputLoc = 1;
		
		while location <= #ops do
			
			if ops[location] == 1 then -- push
				location = location + 1;
				stack:push( ops[location] );
				
			elseif ops[location] == 2 then -- add
				stack:push( stack:pop() + stack:pop() );
				
			elseif ops[location] == 3 then -- sub
				stack:push( -stack:pop() + stack:pop() );
				
			elseif ops[location] == 4 then -- mult
				stack:push( stack:pop() * stack:pop() );
				
			elseif ops[location] == 5 then -- div
				stack:push( ( 1 / stack:pop() ) * stack:pop() );
				
			elseif ops[location] == 6 then -- num
				output = output .. tostring( stack:pop() );
				
			elseif ops[location] == 7 then -- char
				output = output .. string.char( stack:pop() );
				
			elseif ops[location] == 8 then -- dup
				stack:push( stack:peek() );
				
			elseif ops[location] == 9 then -- if
				if stack:pop() == 0 then
					location = location + 2;
				end
			
			elseif ops[location] == 10 then -- skip
				location = location + stack:pop();
				
			elseif ops[location] == 11 then -- input
				if inputLocation <= stdin:len() then
					stack:push( stdin:sub( inputLocation, inputLocation ):byte() );
				else
					stack:push( 0 );
				end
				
			end
			location = location + 1;
			if debugMode then for k, v in ipairs( stack ) do io.write( tostring( v ), ' ' ); end print(); end -- debug, print values of stack
			
		end
		
	end
	
	return output;
	
end