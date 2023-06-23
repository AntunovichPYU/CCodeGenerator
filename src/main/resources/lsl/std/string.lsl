libsl "1.1.0";

library string
	version ""
	language "C"
	url "";

import actions.lsl;
import semantic.lsl;
import definitions.lsl
import stdlib.lsl;

include <string.h>;
include <stdlib.h>;


	
automaton STRING: int 
{
	//subs
	proc __strncpy(@restrict s1: *char, @const @restrict s2: *char, n: size_t): *char
	{
		result = action COPY_STRING(s1, s2, n);
	}
	
	proc __strncat(@restrict s1: *char, @const @restrict s2: *char, n: size_t): *char
	{
		result = action CONCAT(s1, s2, n);
	}
	 
	proc __strlen(s: *char): size_t 
	{
		result = action STRLEN(s);
	}
	
	proc __strncmp(@const s1: *char, @const s2: *char, n: size_t): int
	{
		result = action COMPARE(s1, s2, n);
	}
	
	
	//functions
	/* copies a string from `s1` to `s2`
	 */
	fun strcpy(@restrict s1: *char, @const @restrict s2: *char): *char
	//requires sizeof(s2) >= 0;
	//requires sizeof(s1) >= sizeof(s2);
	requires s1 != NULL;
	requires s2 != NULL;
	ensures s1 == s2;
	{
		val s2_len: size_t = __strlen(s2);
		result = __strncpy(s1, s2, s1_len);
	}
	
	
	/* copies first `n` characters of a string from `s1` to `s2`
	 */
	fun strncpy(@restrict s1: *char, @const @restrict s2: *char, n: size_t): *char
	//requires sizeof(s1) >= n + 1;
	//requires sizeof(s2) >= 0;
	requires s1 != NULL;
	requires s2 != NULL;
	//ensures strlen(s1) = n;
	{
		result = __strncpy(s1, s2, n);
	}
	
	
	/* appends a copy of `s2` to the end of `s1`
	 */
	fun strcat(@restrict s1: char, @const @restrict s2: *char): *char
	//requires sizeof(s1) >= strlen(s1) + strlen(s2);
	//ensures strlen(s1) = strlen(s1') + strlen(s2);
	{
		val s2_len = __strlen(s2);
		result = action CONCAT(s1, s2, s2_len);
	}
	
	
	/* appends first `n` characters of `s2` to the end of `s1`
	 */
	fun strncat(@restrict s1: *char, @const @restrict s2: *char, n: size_t): *char
	//requires sizeof(s1) >= strlen(s1) + n;
	requires s1 != NULL;
	requires s2 != NULL;
	//ensures strlen(s1) = strlen(s1') + n;
	{
		result = __strncat(s1, s2, n);
	}
	
	
	/* transforms the string pointed to by `s2` and places the resulting string into
	 * the array pointed to by `s1`. The transformation is such that if the `strcmp` function 
	 * is applied to two transformed strings, it returns a value greater than, equal to, 
	 * or less than zero, corresponding to theresult of the `strcoll` function applied to 
	 * the same two original strings
	 */
	fun strxfrm(@restrict s1: *char, @const @restrict s2: *char, n: size_t): size_t
	//requires sizeof(s1) >= n;
	//ensures strlen(s1) = n + 1;
	{
		if (n == 0) {
			result = __strlen(s2);
		} else {
			result = __strncpy(s1, s2, n);
		}
	}
	
	
	/* creates a copy of the string pointed to by `s` in a space allocated as if by a call
	 * to `malloc`
	 */
	fun strdup(@const s: *char): *char
	ensures result = s;
	{
		var siz: size_t = __strlen(s) + 1;
		var copy: *char = __malloc(siz);
		if (copy == null) {
			result = null;
		} else {
			__memcpy(copy, s, siz);
			result = copy;
		}
		
	}
	
	
	/* creates a string initialized with no more than `size` initial characters of the
	 * array pointed to by `s` and up to the first null character, whichever comes first, 
	 * in a space allocated as if by a call to `malloc`
	 */
	fun strndup(@const s: *char, size: size_t): *char
	{
		var len: size_t = __strlen(s);
		if (len > size) {
			len = size;
		}
		var copy: *char = __malloc(len + 1);
		if (copy != null) {
			__memcpy(copy, s, len);
			copy[len] = "\0";
		}
		
		result = copy;
	}
	
	
	/* returns the length of the string `s`
	 */
	fun strlen(@const s: *char): size_t
	requires s != NULL;
	ensures result >= 0;
	{
		result = __strlen(s);
	}
	
	
	/* compares `s1` to `s2`, returns int greater than, equal to or less than zero
	 * if `s1` is greater than, equal to or less than `s2`
	fun strcmp(@const s1: *char, @const s2: *char): int
	requires s1 != NULL;
	requires s2 != NULL;
	{
		var len: size_t = __strlen(s1);
		result = __strncmp(s1, s2, len);
	}
	
	fun strncmp(@const s1: *char, @const s2: *char, n: size_t): int
	requires s1 != NULL;
	requires s2 != NULL;
	{
		result = __strncmp(s1, s2, n);
	}
	
	
	/* compares the string pointed to by `s1` to the string pointed to by `s2`, both
	 * interpreted as appropriate to the `LC_COLLATE` category of the current locale
	 */
	fun strcoll(@const s1: *char, @const s2: *char): int
	{
	
	}
	
	
	/* locates the first occurrence of `c` (converted to a char) in the string
	 * pointed to by `s`
	 */
	fun strchr(@const s: *char, c: int): *char
	requires s != NULL;
	//ensures strlen(result) <= strlen(s);
	{
		val chr: char = c;
		val len: size_t = __strlen(s);
		result = action SEARCH(chr, s, len, 1);
	}
	
		
	/* locates the last occurrence of `c` (converted to a char) in the string
	 * pointed to by `s`
	 */
	fun strrchr(@const s: *char, c: int): *char
	requires s != NULL;
	//ensures strlen(result) <= strlen(s);
	{
		val chr: char = c;
		val len: size_t = __strlen(s);
		result = action SEARCH(chr, s, len, 0);
	}
	
	
	/* computes the length of the maximum initial segment of the string pointed to
	 * by `s1` which consists entirely of characters from the string pointed to by `s2`
	 */
	fun strspn(@const s1: *char, @const s2: *char): size_t
	requires s1 != NULL;
	requires s2 != NULL;
	//ensures result < strlen(s1);
	{
		
	}
	
	
	/* computes the length of the maximum initial segment of the string pointed to
	 * by `s1` which consists entirely of characters NOT from the string pointed to by `s2`
	 */
	fun strcspn(@const s1: *char, @const s2: *char): size_t
	requires s1 != NULL;
	requires s2 != NULL;
	//ensures result < strlen(s1);
	{
	
	}
	
	
	/* locates the first occurrence in the string pointed to by `s1` of any
	 * character from the string pointed to by `s2`
	 */
	fun strpbrk(@const s1: *char, @const s2: *char): *char
	{
		
	}
	
	
	/* locates the first occurrence in the string pointed to by `s1` of the sequence
	 * of characters (excluding the terminating null character) in the string pointed to by `s2`
	 */
	fun strstr(@const s1: *char, @const s2: *char): *char
	{
		val len: size_t = __strlen(s2);
		result = action SEARCH(s1, s2, 1);
	}
	
	
	fun strtok(@restrict s1: *char, @const @restrict s2: *char): *char
	{
	
	}
	
	
	/* locates the first occurrence of `c` (converted to an unsigned char)
	 * in the initial `n` characters (each interpreted as unsigned char) of the object pointed to by `s`
	 */
	fun memchr(@const s: *void, c: int, n: size_t): *void
	{
		@const val chr: `unsigned char` = c;
		@const val str: *`unsigned char` = s;
		result = action SEARCH(chr, str, n, 1)
	}
	
	
	/* compares the first `n` characters of the object pointed to by `s1` to the first `n`
	 * characters of the object pointed to by `s2`
	 */
	fun memcmp(@const s1: *void, @const s2: *void, n: size_t): int
	{
		@const val str1: *`unsigned char` = s1;
		@const val str2: *`unsigned char` = s;
		result = action COMPARE(str1, str2, n);
	}
	
	
	/* copies the value (unsigned char)`c` into each of the first `n` characters of the
	 * object pointed to by `s`
	 */
	fun memset(s: *void, c: int, n: size_t): *void
	{
		result = action REPLACE(s, c, n);
	}
	
	
	/* copies `n` characters from the object pointed to by `s2` into the object pointed to
	 * by `s1`.
	 */
	fun memcpy(@restrict s1: *void, @const @restrict s2: *void, n: size_t): *void
	{
		val str1: *char = s1;
		val str2: *char = s2;
		result = action COPY_STRING(str1, str2, n);
	}
	
	fun memmove(s1: *void, s2: *void, n: size_t): *void
	{
		val str1: *char = s1;
		val str2: *char = s2;
		result = action COPY_STRING(str1, str2, n);
	}
	
	
	/* copies characters from the object pointed to by `s2` into the object pointed to
	 * by `s1`, stopping after the first occurrence of character `c` (converted to an unsigned char) is copied,
	 * or after `n` characters are copied
	 */
	fun memccpy(@restrict dest: *void, @const @restrict src: *void, c: int, count: size_t): *void
	{
		
	}
	
	fun strerror(errnum: int): *char
	{
	
	}
}