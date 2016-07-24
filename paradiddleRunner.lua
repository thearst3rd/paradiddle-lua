-- Barely functional (but functional) runner for paradiddle. Use at your own risk.

require( "paradiddle" );

io.write( "---- Enter Paradiddle code (in one line) ----\r\n\r\n" );
io.flush();
local code = io.read( "*line" );

io.write( "\r\n---- Enter standard input (one line) ----\r\n\r\n" );
io.flush();
local stdin = io.read( "*line" );

io.write( "\r\n---- Code output ----\r\n\r\n" );
io.flush();

local output = paradiddle( code, stdin );
io.write( output );