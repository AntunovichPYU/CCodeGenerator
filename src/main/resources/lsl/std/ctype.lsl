libsl "1.1.0";

library ctype
	version ""
	language "C"
	url "";


import "std/utils/semantic";
import "std/utils/definitions";

include "<ctype.h>";


automaton CTYPE: int 
{
	//subs
	proc __isalpha(c: int): int
	{
	    val is_upper: int = __isuper(c);
	    val is_lower: int = __islower(c);
	    result = is_upper || is_lower;
	}

	proc __isdigit(c: int): int
	{
        val first_digit: char = "0";
        val uc: `unsigned char` = c;
        result = uc - first_digit < 10;
	}

	proc __isalnum(c: int): int
	{
	    val is_alpha: int = __isalpha(c);
	    val is_digit: int = __isdigit(c);
	    result = is_alpha || is_digit;
	}

    proc __islower(c: int): int
    {
        val uc: `unsigned char` = c;
        val first_letter: char = "a";
        result = uc - first_letter < 26;
    }

    proc __isuper(c: int): int
    {
        val uc: `unsigned char` = c;
        val first_letter: char = "A";
        result = uc - first_letter < 26;
    }

    proc __isgraph(c: int): int
    {
        val uc: `unsigned char` = c;
        result = uc - 33 < 94;
    }




    //functions


    /* true for any `c` that `isalpha` or `isdigit`
     */
	fun isalnum(c: int): int
	{
	    result = __isalnum(c);
	}


	/* true for any alphabetical character
	 */
	fun isalpha(c: int): int 
	{
	    result = __isalpha(c);
	}


	/* true for any control character, i.e. codes 0x00-0x1f and 0x7f
	 */
	fun iscntrl(c: int): int
	{
	    val uc: `unsigned char` = c;
	    result = uc < 32 || c == 127;
	}


	/* true for any digit character
	 */
	fun isdigit(c: int): int
	{
	    result = __isdigit(c);
	}


	/* true for any printing character except space
	 */
	fun isgraph(c: int): int
	{
        result = __isgraph(c);
	}


	/* true for any alphabetic character that is lowercase
	 */
	fun islower(c: int): int
	{
	    result = __islower(c);
	}


	/* true for any printing character including space
     */
	fun isprint(c: int): int
	{
	    val uc: `unsigned char` = c;
	    val is_graph: int = __isgraph(c);
	    val space: char = " ";
	    result = is_graph || c == space;
	}


	/* true for any printing character for which neither isspace nor isalnum is true
	 */
	fun ispunct(c: int): int
	{
	    val is_graph: int = __isgraph(c);
	    val is_al_num: int = __isalnum(c);
	    result = is_graph && !is_al_num;
	}


	/* true for whitespace characters: ' ', '\t', '\f', '\n', '\r', '\v'
	 */
	fun isspace(c: int): int
	{
	    val uc: `unsigned char` = c;
	    val space: char = " ";
	    val tab: char = "\t";
	    result = c == space || uc - tab < 5;
	}


    /* true for any alphabetic character that is uppercase
	 */
	fun isupper(c: int): int
	{
	    result = __isupper(c);
	}


	/* true for any hex character
	 */
	fun isxdigit(c: int): int
	{
	    val uc: `unsigned char` = c;
	    val is_digit: int = __isdigit(c);
	    val a_letter: char = "a";
	    result = is_digit || (uc | 32) - a_letter < 6; //digits and first 6 letters in any case
	}


	fun isblank(c: int): int
	{
        val space: char = " ";
        val tab: char = "\t";
        result = c == space || c == tab;
	}
	
	fun tolower(c: int): int
	{
	    val is_upper: int = __isupper(c);
	    if (is_upper) {
	        result = c | 32;
	    } else {
	        result = c;
	    }
	}
	
	fun toupper(c: int): int
	{
	    val is_lower: int = __islower(c);
	    if (is_lower) {
	        result = c & 95;
	    } else {
	        result = c;
	    }
	}
	
}