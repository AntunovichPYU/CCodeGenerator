libsl "1.0.0";

library time.h
	version ""
	language "C"
	url ""

typealias *tm = long;

automaton TIME: int 
{
	fun difftime(time1: time_t, time0: time_t): double
	{
        val t1: double = time1;
        val t0: double = time0;

        if (time0 <= time1) {
            result = t1 - t0;
        } else {
            result = -(t0 - t1);
        }
	}



	//not implemented

	fun time(arg: *time_t): time_t;
	
	fun clock(): clock_t;
	
	fun ctime(@const timer: *time_t): *char;
	
	fun strftime(str: *char, count: size_t, @const format: *char, @const @struct tp: *tm): size_t;
	
	@struct fun gmtime(@const timer: *time_t): tm;
	
	@struct fun localtime(@const timer: *time_t): tm;
	
	fun mktime(@struct arg: tm): time_t;
}