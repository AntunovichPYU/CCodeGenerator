libsl "1.1.0";

library stdlib
	version "C23"
	language "C"
	url "-";


//----------------------------stdlib.h-----------------------------

define action ALIGN(
        size: size_t
    ): void;

define action FIND_FIT(
        block: *free_block,
        size: size_t
    ): void;

define action SKIP_SPACES(
		strptr: *char
	): void;

define action SORT(
		base: *void,
		nmemb: size_t,
		size: size_t,
		@fun_pointer(["const void *", "const void *"]) (compar): *int
	): void;

define action SEARCH(
		@const key: *void,
		base: *void,
		nmemb: size_t,
		size: size_t,
		@fun_pointer(["const void *", "const void *"]) (compar): *int
	): *void;



//---------------------------------string.h-----------------------------

//copy `size` characters from `src` to `dst` and returnes `dst`
define action COPY_STRING(
		dst: *char,
		src: *char,
		size: size_t
	): *char;

//length of string
define action STRLEN(
		str: *char
	): size_t;

//concatenates `size` characters from `s2` to `s1` and returnes `s1`
define action CONCAT(
		s1: *char,
		s2: *char,
		size: size_t
	): *char;

//compares first `size` characters from `s1` to `s2`
define action COMPARE(
		s1: *char,
		s2: *char,
		size: size_t
	): int;

//returns first, if `forward` is 1, or last, if `forward` is 0, occurrence
//of `s1` in `size` first or last characters `s2`
define action SEARCH(
		s1: *char,
		s2: *char,
		size: size_t,
		forward: int
	): *char;

//replaces first `n` characters in `s1` with `s2`
define action REPLACE(
		s1: *char,
		s2: *char,
		n: size_t
	): *char;
