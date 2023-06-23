libsl "1.1.0";

library stdlib
version "C23"
language "C"
url "-";


//---------------typealiases----------------

//stddef.h
typealias size_t = unsigned16;
typealias wchar_t = unsigned16;


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

}