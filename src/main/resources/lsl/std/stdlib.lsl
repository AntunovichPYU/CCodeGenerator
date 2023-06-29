libsl "1.1.0";

library `stdlib.h`
	version "C23"
	language "C"
	url "-";

import "std/utils/semantic";
import "std/utils/definitions";
import "std/utils/actions";
import "std/ctype";

include "<stdlib.h>";
include "<ctype.h>";


type free_block
{
	size: size_t;
	next: free_block;
}


automaton STDLIB: int 
{
	//defined values
    val EXIT_FAILURE: int = 0;
    val EXIT_SUCCESS: int = 1;
    val RAND_MAX: int = 32767;

    val alignment: int = 8;
    var free_block_list_head: free_block;
	proc __malloc(size: size_t): *void
    {
        var block: free_block;

        var blk_size: size_t = ((size) + (alignment - 1)) & ~(alignment - 1);
        block = free_block_list_head.next;
        result = action FIND_FIT(block, blk_size);

    }



	/* returns absolute value
	 */
	fun abs(n: int): int
	{
		ensures result >= 0;

		if (n < 0) {
			result = -n;
		} else {
			result = n;
		}
	}
	
	fun labs(n: long): long
	{
		ensures result >= 0;

		if (n < 0) {
			result = -n;
		} else {
			result = n;
		}
	}
	
	fun llabs(n: `long long`): `long long`
	{
		ensures result >= 0;

		if (n < 0) {
			result = -n;
		} else {
			result = n;
		}
	}
	
	/* div, ldiv, lldiv compute quotient and remainder in a single operation 
	 */
	fun div(x: int, y: int): div_t
	{
		requires y != 0;
        ensures (result.quot == x / y) & (result.rem == x % y);

		val div_result: div_t;
		div_result.quot = x / y;
		div_result.rem = x % y;
		if (x >=0 && div_result.rem < 0) {
			div_result.quot++;
			div_result.rem -= y;
		}
		result = div_result;
	}
	
	fun ldiv(x: long, y: long): ldiv_t

	{
		requires y != 0;
        ensures (result.quot == x / y) & (result.rem == x % y);

		val div_result: ldiv_t;
		div_result.quot = x / y;
		div_result.rem = x % y;
		if (x >=0 && div_result.rem < 0) {
			div_result.quot++;
			div_result.rem -= y;
		}
		result = div_result;
	}
	
	fun lldiv(x: `long long`, y: `long long`): lldiv_t
	{
		requires y != 0;
        ensures (result.quot == x / y) & (result.rem == x % y);

		val div_result: lldiv_t;
		div_result.quot = x / y;
		div_result.rem = x % y;
		if (x >=0 && div_result.rem < 0) {
			div_result.quot++;
			div_result.rem -= y;
		}
		result = div_result;
	}
	
	/* converts string pointed to by nptr to double 
	 */
	fun atof(@const nptr: *char): double
	{
		requires nptr != null;

	}
	
	/* atoi, atol, atoll convert string pointed to by
	 * nptr to int, long, long long respectively
	 */
	fun atoi(@const nptr: *char): int
	{
        requires nptr != null;
	}
	
	fun atol(@const nptr: *char): long
	{
        requires nptr != null;
	}
	
	fun atoll(@const nptr: *char): `long long`
	{
        requires nptr != null;
	}
	
	/* convert string pointed by nptr to long, long long, unsigned long,
	 * unsigned long long respectively
	 */
	fun strtol(@const @restrict nptr: *char, @restrict endptr: *`*char`, base: int): long
	{
		requires endptr != null;
	}
	
	fun strtoll(@const @restrict nptr: *char, @restrict endptr: *`*char`, base: int): `long long`
	{
        requires endptr != null;
	}
	
	fun strtoul(@const @restrict nptr: *char, @restrict endptr: *`*char`, base: int): `unsigned long`
	{
        requires endptr != null;
	}
	
	fun strtoull(@const @restrict nptr: *char, @restrict endptr: *`*char`, base: int): `unsigned long long`
	{
        requires endptr != null;
	}
	
	/* convert string pointed by nptr to float, double, long double respectively
	 */
	fun strtof(nptr: *char, endptr: *`*char`): float
	{
		requires endptr != null;
	}
	
	fun strtod(nptr: *char, endptr: *`*char`): double
	{
		requires endptr != null;
	}
	
	fun strtold(nptr: *char, endptr: *`*char`): `long double`
	{
        requires endptr != null;
	}
	
	
	@static var next: `unsigned long` = 1;
	
	/* computes pseudorandom value in range 0 to RAND_MAX
	 */
	fun rand(): int
	{
		ensures result > 0;

		next = next * 1103515245 + 12345;
		val r: unsigned = (next / 65536) % (RAND_MAX + 1);
		result = r;
	}
	
	/* uses argument as a seed to a new random number returned by rand()
	 */
	fun srand(seed: unsigned)
	{
		ensures next == seed;

		next = seed;
	}
	
	/* determines the number of bytes contained in the multibyte character pointed by `s`;
	 * returns 0 if a nullpointer, number of bytes or -1 if invalid value 
	 */
	fun mblen(@const s: *char, n: size_t): int
	{
        ensures result >= -1;
	}
	
	/* returns number of bytes needed to complete the next multibyte character;
	 * inspects at most `n` characters;
	 * stores value in the object pointed by `pwc` 
	 */
	fun mbtowc(@restrict pwc: *wchar_t, @const @restrict s: *char, n: size_t): int
	{
        ensures result >= -1;
	}
	
	/* returns number of bytes needed to complete the next multibyte wide character;
	 * stores in the array pointed to by `s`
	 */
	fun wctomb(s: *char, wc: wchar_t): int
	{
        ensures result >= -1;
	}
	
	/* converts a sequence of multibyte characters that begins in the initial shift
     * state from the array pointed to by `s` into a sequence of corresponding wide characters 
	 * and stores not more than `n` wide characters into the array pointed to by `pwcs`
	 */
	fun mbstowcs(@restrict pwcs: *wchar_t, @const @restrict s: *char, n: size_t): size_t
	{
        ensures result >= -1;
	}
	
	/* converts a sequence of wide characters from the array pointed to by pwcs
	 * into a sequence of corresponding multibyte characters that begins in the initial 
	 * shift state, and stores these multibyte characters into the array pointed to by s, 
	 * stopping if a multibyte character would exceed the limit of n total bytes or if 
	 * a null character is stored
	 */
	fun wcstombs(s: *char, pwcs: *wchar_t, n: size_t): size_t
	{
	    ensures result >= -1;
	}
	
	/* sorts an array of `nmemb` elements, the initial element of which is pointed by `base`;
	 * the size of each element is specified by `size`;
	 * the contents of the array are sorted into ascending order according to a comparison 
	 * function `compar`
	 */
	fun qsort(
		base: *void, 
		nmemb: size_t, 
		size: size_t, 
		@fun_pointer("const void *, const void *") compar: *int
	)
	{
		action SORT(base, nmemb, size, compar);
	}
	
	/* searches array of `nmemb` objects, initial element of which is pointed by `base`,
	 * for an element that matches the object pointed to by `key`, size of each element 
	 * is specified by `size`, comparison function is pointed by `compar` and called with
	 * two arguments that point to the `key` object and to an array element
	 */
	fun bsearch(
		@const key: *void, 
		base: *void, 
		nmemb: size_t, 
		size: size_t, 
		@fun_pointer("const void *, const void *") compar: *int
	): *void
	{
		result = action SEARCH(key, base, nmemb, size, compar);
	}
	
	fun malloc(size: size_t): *void
	{
		result = __malloc(size);
	}
	
	fun calloc(nmemb: size_t, size: size_t): *void
	{
	
	}
	
	fun realloc(ptr: *void, size: size_t)
	{
	
	}
	
	fun free(ptr: *void)
	{
		action FREE_BLOCK(ptr, block);
		block.next = free_block_list_head.next;
		free_block_list_head.next = block;
	}
	
	fun aligned_alloc(alignment: size_t, size: size_t): *void
	{
	
	}
	
	
	fun abort()
	{
	
	}
	
	
	fun exit(status: int)
	{
	    requires (status == EXIT_SUCCESS) || (status == EXIT_FAILURE);
	}
	
	fun quick_exit(status: int)
	{
	
	}
	
	fun _Exit(status: int)
	{
	
	}
	
	fun atexit(@fun_pointer("void") func: *void): int
	{
	
	}
	
	fun at_quick_exit(@fun_pointer("void") func: *void): int
	{
	
	}
	
	fun system(string: *char): int
	{
	    ensures result >= 0;
	}
	
	fun getenv(name: *char): *char
	{
	
	}
	
}