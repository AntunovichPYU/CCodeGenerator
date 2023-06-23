libsl "1.1.0";

library example
	version ""
	language "C"
	url "";

import "c";

include "actions.h";
include "<assert.h>";

type Point {
	X: int;
	Y: long;
}

type int_ref;


define action SOMETHING(arg: any): any;

automaton A: int 
{
	var automaton_var: int = 0;


    proc _proc1(arg: int): int
    {
        result = arg == 0;
    }

	fun foo1(@const arg: int)
	{
	    requires (arg == 0);

    	val local_val: *char = action SOMETHING("foo");
    	var local_var: *char;
    	var structure: Point;
    	structure.X = 1;
    	var div: div_t;
    	div.quot = 1;
    	div.rem = 1;

		automaton_var = 1;
		if (automaton_var == 1)
		{
		    val local_if_var: int = local_val[0];
		    automaton_var -= arg + 1 + arg == automaton_var;
		    local_var = "smthng";
		}
		else
		{
		    automaton_var += arg * (33333 + 2);
		}
	}
	
	fun foo2(arg1: `long long`, arg2: int): long
	{
	    ensures (automaton_var' >= automaton_var);
		result = _proc1(arg2, );
	}
}