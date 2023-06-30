libsl "1.1.0";

library wctype
	version ""
	language "C"
	url "";

import "std/utils/semantic";
import "std/utils/definitions";

include "<wctype.h>";


automaton WCTYPE: int 
{
	proc __iswdigit(wc: wint_t): int
    {
        val uc: unsigned = wc - "0";
        result = uc < 10;
    }

    proc __iswspace(wc: wint_t): int
    {
        if (wc == (" " || "\t" || "\n" || "\r" || 11 || 12 || 133 || 8192 || 8193 || 8194 || 8195 || 8196 || 8197 || 8198 || 8200 || 8201 || 8202 || 8232 || 8233 || 8287 || 12288 || 0)) {
            result = 1;
        } else {
            result = 0;
        }
    }

    proc __iswprint(wc: wint_t): int
        {
           if (wc < 255) {
               result = (wc + 1 & 127) >= 33;
           }
           if (wc < 8232 || wc - 8234 < 47062 || wc - 57344 < 8185) {
               result = 1;
           }
           if (wc - 65532 > 1048579 || (wc & 65534) == 65534) {
               result = 0;
           }
        }



	
	fun iswdigit(wc: wint_t): int
	{
        result = __isdigit(wc);
	}
	
	fun iswxdigit(wc: wint_t): int
	{
        val is_digit: int = __iswdigit(wc);
        val a_letter: char = "a";

        val uc: unsigned = (wc | 32) - a_letter;
        result = is_digit || (uc < 6); //digits and first 6 letters in any case
	}
	
	fun iswgraph(wc: wint_t): int
	{
	    val is_space: int = __iswspace(wc);
	    val is_print: int = __iswprint(wc);
	    result = !is_space && is_print;
	}
	
	fun iswspace(wc: wint_t): int
	{
	    result = __iswspace(wc);
	}
	
	fun iswblank(wc: wint_t): int
	{
	    val space: char = " ";
        val tab: char = "\t";
        result = wc == space || wc == tab;
	}
	
	fun iswprint(wc: wint_t): int
	{
        result = __iswprint(wc);
	}

/*  not implemented

    fun iswcntrl()

	fun iswpunct()
	
	fun iswctype()
	
	fun wctype()
	
	fun towlower()
	
	fun towupper()
	
	fun towctrans()
	
	fun wctrans()

	fun iswalnum()

	fun iswalpha()

	fun iswlower()

	fun iswupper()
*/
}