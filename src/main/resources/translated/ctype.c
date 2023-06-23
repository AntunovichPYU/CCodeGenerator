#include <ctype.h>

int __isalpha(int c)
{
	int result;
	const int is_upper = __isuper(c);
	const int is_lower = __islower(c);
	result = is_upper || is_lower;
	
	return result;
}

int __isdigit(int c)
{
	int result;
	const char first_digit = '0';
	const unsigned char uc = c;
	result = uc - first_digit < 10;
	
	return result;
}

int __isalnum(int c)
{
	int result;
	const int is_alpha = __isalpha(c);
	const int is_digit = __isdigit(c);
	result = is_alpha || is_digit;
	
	return result;
}

int __islower(int c)
{
	int result;
	const unsigned char uc = c;
	const char first_letter = 'a';
	result = uc - first_letter < 26;
	
	return result;
}

int __isuper(int c)
{
	int result;
	const unsigned char uc = c;
	const char first_letter = 'A';
	result = uc - first_letter < 26;
	
	return result;
}

int __isgraph(int c)
{
	int result;
	const unsigned char uc = c;
	result = uc - 33 < 94;
	
	return result;
}

int isalnum(int c)
{
	int result;
	result = __isalnum(c);
	
	return result;
}

int isalpha(int c)
{
	int result;
	result = __isalpha(c);
	
	return result;
}

int iscntrl(int c)
{
	int result;
	const unsigned char uc = c;
	result = uc < 32 || c == 127;
	
	return result;
}

int isdigit(int c)
{
	int result;
	result = __isdigit(c);
	
	return result;
}

int isgraph(int c)
{
	int result;
	result = __isgraph(c);
	
	return result;
}

int islower(int c)
{
	int result;
	result = __islower(c);
	
	return result;
}

int isprint(int c)
{
	int result;
	const unsigned char uc = c;
	const int is_graph = __isgraph(c);
	const char space = ' ';
	result = is_graph || c == space;
	
	return result;
}

int ispunct(int c)
{
	int result;
	const int is_graph = __isgraph(c);
	const int is_al_num = __isalnum(c);
	result = is_graph && !is_al_num;
	
	return result;
}

int isspace(int c)
{
	int result;
	const unsigned char uc = c;
	const char space = ' ';
	const char tab = '\t';
	result = c == space || uc - tab < 5;
	
	return result;
}

int isupper(int c)
{
	int result;
	result = __isupper(c);
	
	return result;
}

int isxdigit(int c)
{
	int result;
	const unsigned char uc = c;
	const int is_digit = __isdigit(c);
	const char a_letter = 'a';
	result = is_digit || (uc | 32) - a_letter < 6;
	
	return result;
}

int isblank(int c)
{
	int result;
	const char space = ' ';
	const char tab = '\t';
	result = c == space || c == tab;
	
	return result;
}

int tolower(int c)
{
	int result;
	const int is_upper = __isupper(c);
	if (is_upper) {
		result = c | 32;
	} else {
		result = c;
	}
	
	return result;
}

int toupper(int c)
{
	int result;
	const int is_lower = __islower(c);
	if (is_lower) {
		result = c & 95;
	} else {
		result = c;
	}
	
	return result;
}


