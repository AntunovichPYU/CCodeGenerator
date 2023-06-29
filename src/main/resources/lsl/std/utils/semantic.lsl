libsl "1.1.0";

library stdlib
	version "C23"
	language "C"
	url "-";


// ---------------------standard c types--------------------------
typealias `*unsigned char` = *unsigned8;
typealias *short = *int16;
typealias `*unsigned short` = *unsigned16;
typealias *int = *int32;
typealias `*unsigned` = *unsigned32;
typealias *long = *int64;
typealias `*unsigned long` = *unsigned64;
typealias `*long long` = *int64;
typealias `*unsigned long long` = *unsigned64;

typealias `unsigned char` = unsigned8;
typealias short = int16;
typealias `unsigned short` = unsigned16;
typealias int = int32;
typealias unsigned = unsigned32;
typealias long = int64;
typealias `unsigned long` = unsigned64;
typealias `long long` = int64;
typealias `unsigned long long` = unsigned64;

typealias float = float32;
typealias double = float64;
typealias `long double` = float64;


// ----------------------annotations-------------------------------

annotation const();

annotation restrict();

annotation volatile();

annotation static();

annotation register();

annotation _Atomic();

annotation complex();

annotation struct();

// function pointers: int(*fun)(int *) - pointer to function with int argument that returns int value
// usage example: @fun_pointer(["int *"]) var fun: *int;
annotation fun_pointer(
	args: string
);


// -----------------------actions-----------------------------------

// type convertion
define action CONVERT(
		type_s: string,
		value: any
	): any;

// sizeof()
define action SIZEOF(
		obj: any
	): size_t;

define action ALIGNOF(
        obj: any
    ): size_t;

define action SYS_RAISE_SIG(
        msg: *char
    ): void;

//------------------------constants----------------------------------

val null: any = 0;
val nullptr: any = null;
val INF: int = 1;
val NAN: int = 0;