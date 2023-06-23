#include actions.h
#include <assert.h>

typedef struct {
	int X;
	long Y;
} Point;
typedef struct int_ref;

int automaton_var;

int _proc1(int arg)
{
	int result;
	result = arg == 0;
	
	return result;
}

void foo1(const int arg)
{
	//requires arg == 0;
	assert(arg == 0);
	
	const char *local_val = SOMETHING("foo");
	char *local_var;
	Point structure;
	structure.X = 1;
	div_t div;
	div.quot = 1;
	div.rem = 1;
	automaton_var = 1;
	if (automaton_var == 1) {
		const int local_if_var = local_val[0];
		automaton_var -= arg + 1 + arg == automaton_var;
		local_var = "smthng";
	} else {
		automaton_var += arg * (33333 + 2);
	}
}

long foo2(long long arg1, int arg2)
{
	long result;
	int old_automaton_var = automaton_var;
	result = _proc1(arg2);
	
	//ensures (automaton_var)' > automaton_var;
	assert(old_automaton_var > automaton_var);
	
	return result;
}


