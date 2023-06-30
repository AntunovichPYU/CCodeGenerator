libsl "1.1.0";

library errno.h
	version ""
	language "C"
	url "";

include "<errno.h>";

automaton ERRNO: int
{
	var errno: int = 0;
}