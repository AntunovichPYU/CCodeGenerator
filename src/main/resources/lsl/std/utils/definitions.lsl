libsl "1.1.0";

library stdlib
version "C23"
language "C"
url "-";


//---------------typealiases----------------

//stddef.h
typealias size_t = unsigned16;
typealias wchar_t = unsigned16;

//time.h
typealias time_t = long;
typealias clock_t = int;

//wchar.h
typealias wchar_t = char;
typealias wint_t = int;

//----------------TYPEDEFS------------------

//stdlib.h
type div_t
{
    quot: int;
    rem: int;
}

type ldiv_t
{
    quot: long;
    rem: long;
}

type lldiv_t
{
    quot: `long long`;
    rem: `long long`;
}


//stdio.h
type FILE
{
    _ptr: *char;
    _flags: short;
    _buf: *char;
    _bufsiz: size_t;
}


//------------------constants-----------------

//limits.h
val INT_MAX: int = 2147483647;
val INT_MIN: int = -2147483647;


//stdio.h
val __SLBF: int = 1;
val __SNBF: int = 2;
val __SRD: int = 4;
val __SWR: int = 8;
val __SRW: int = 16;
val __SEOF: int = 32;
val __SERR: int = 64;

val SEEK_SET: int = 0;
val SEEK_CUR: int = 1;
val SEEK_END: int = 2;

val _IOFBF: int = 0;
val _IOLBF: int = 1;
val _IONBF: int = 2;

val EOF: int = -1;

val BUFSIZ: int = 1024;


//signal.h
val NSIG: int = 23;
val SIG_DFL: void = 0;
val SIG_IGN: void = 1;
val SIG_GET: void = 2;
val SIG_SGE: void = 3;
val SIG_ACK: void = 4;
val SIG_ERR: void = -1;

val SIGINT: int = 2;
val SIGILL: int = 4;
val SIGFPE: int = 8;
val SIGSEGV: int = 11;
val SIGTERM: int = 15;
val SIGABRT: int = 22;
