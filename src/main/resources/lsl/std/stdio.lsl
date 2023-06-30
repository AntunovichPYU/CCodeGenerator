libsl "1.0.0";

library stdio.h 
	version ""
	language "C"
	url "";


import "std/utils/semantic";
import "std/utils/definitions";

include "<stdio.h>";
include "<string.h>";

typealias va_list = char;
typealias fpos_t = char;


automaton STDIO: int 
{
	var stderr: FILE;
	var stdin: FILE;
	var stdout: FILE;

	proc __getc(stream: *FILE): int
	{
	    requires (stream._flags & __SEOF) == 0;
	    requires (stream._flags & __SERR) == 0;
	    ensures (stream._ptr) == (stream._ptr)' + 1;
	}

    proc __putc(c: int, stream: *FILE): int
    {
        ensures result == c;
    }

    proc __fseek(stream: *FILE, offset: `long int`, whence: int): int
    {
        requires stream._flags & __SRW;
        requires whence == (SEEK_CUR || SEEK_SET || SEEK_END);
        ensures result == 0; //success

    }

    proc __fwrite(ptr: *void, size: size_t, nmemb: size_t, stream: *FILE): size_t
    {
        requires stream._flags & __SRW;
        ensures result <= nmemb;

    }

    proc __fputs(s: *char, stream: *FILE): int
    {
        val l: size_t = __strlen(s);
        val write: size_t = __fwrite(s, 1, l, stream);
        result = (write == l) - 1;
    }

    proc __setvbuf(stream: *FILE, buf: *char, mode: int, size: size_t): int
    	{
    	    requires mode == (_IONBF || _IOLBF || _IOFBF);
    	    requires size <= INT_MAX;
    	    ensures result == 0;

            if (mode == _IONBF) {
                stream._bufsiz = 0;
                stream._flags |= __SNBF;
            }
            if (mode == _IOLBF || mode == _IOFBF) {
                stream._bufsiz = size;
                stream._buf = buf;
            }
            if (mode == _IOLBF) {
                stream._flags |= __SLBF;
            }

            result = 0;
    	}




	fun clearerr(stream: *FILE)
	{
        stream._flags &= ~(__SERR|__SEOF);
	}
	
	fun fclose(stream: *FILE): int
	{
        requires stream._flags != 0; //file is opened
        ensures stream._flags == 0; //file is closed


	}
	
	fun feof(stream: *FILE): int
	{
	    result = (stream._flags & __SEOF);
	}
	
	fun ferror(stream: *FILE): int
	{
	    result = (stream._flags & __SERR);
	}
	
	fun fflush(stream: *FILE): int
	{
	    requires stream._flags & (__SWR | __SRW) == 0;
	    ensures result == 0;


	}
	
	fun fgetc(stream: *FILE): int
	{
	    result = __getc(stream);
	}
	
	fun fopen(filename: *char, mode: *char): *FILE
	{
        requires mode[0] == ("r" || "w" || "a");
        ensures result._flags != 0;

        var file: FILE;
        if (mode[0] == "r") {
            file._flags = __SRD;
        }
        if (mode[0] == "w") {
            file._flags = __SWR;
        }
        if (mode[0] == "a") {
            file._flags = __SWR
        }


	}

	fun fputc(c: int, stream: *FILE): int
	{
        result = __putc(c, stream);
	}
	
	fun fputs(s: *char, stream: *FILE): int
	{
        result = __fputs(s, stream);
	}
	
	fun fread(ptr: *void, size: size_t, nmemb: size_t, stream: *FILE): size_t
	{
	    ensures result == nmemb;

	}

	fun fseek(stream: *FILE, offset: `long int`, whence: int): int
	{
	    result = __fseek(stream, offset, whence);

	}
	
	fun fsetpos(stream: *FILE, pos: *fpos_t): int
	{
        result = __fseek(stream, pos, SEEK_SET);
	}
	
	fun fwrite(ptr: *void, size: size_t, nmemb: size_t, stream: *FILE): size_t
	{
	    result = __fwrite(ptr, size, nmemb, stream);
	}
	
	fun getc(stream: *FILE): int
	{
	    result = __getc(stream);
	}
	
	fun getchar(): int
	{
	    resutl = getc(stdin);
	}

	fun putc(c: int, stream: *FILE): int
	{
	    result = __putc(c, stream);
	}
	
	fun putchar(c: int): int
	{
	    result = __putc(c, stdout);
	}
	
	fun puts(s: *char): int
	{
        result = __fputs(s, stdout);
	}
	
	fun rewind(stream: *FILE)
	{
	    __fseek(stream, 0, SEEK_SET);
	    stream._flags &= ~__SERR;
	}
	
	fun setbuf(stream: *FILE, buf: *char)
	{
        if (buf == null) {
            __setvbuf(stream, buf, _IOFBF, BUFSIZ);
        } else {
            __setvbuf(stream, null, _IONBF, 0);
        }
	}
	
	fun setvbuf(stream: *FILE, buf: *char, mode: int, size: size_t): int
	{
	    result = __setvbuf(stream, buf, mode, size);
	}
	


/* not implemented
	fun fgetpos(stream: *FILE, pos: *fpos_t): int
	{

	}

	fun fgets(s: *char, n: int, stream: *FILE): *char
	{

	}

	fun freopen(filename: *char, mode: *char, stream: *FILE): *FILE
	{

	}

	fun fprintf(stream: *FILE, format: *char, ...): int
	{

	}

	fun fscanf(stream: *FILE, format: *char, ...): int
	{

	}

	fun ftell(stream: *FILE): `long int`
	{

	}

	fun perror(s: *char)
	{

	}

	fun printf(format: *char, ...): int
	{

	}

	fun sprintf(s: *char, format: *char, ...): int
	{

	}

	fun remove(filename: *char): int
	{

	}

	fun rename(oldName: *char, newName: *char): int
	{

	}

	fun scanf(format: *char, ...): int
	{

	}


	fun sscanf(s: *char, format: *char): int
	{

	}

    fun tmpfile(): *FILE
	{

	}

	fun tmpnam(s: *char): *char
	{

	}

	fun ungetc(c: int, stream: *FILE): int
	{

	}

	fun vprintf(format: *char, arg: va_list): int
	{
	
	}
	
	fun vscanf(format: *char, arg: va_list): int
	{
	
	}
	
	fun vfprintf(stream: *FILE, format: *char, arg: va_list): int
	{
	
	}
	
	fun vfscanf(stream: *FILE, format: *char, arg: va_list): int
	{
	
	}
	
	fun vsprintf(s: *char, format: *char, arg: va_list): int
	{
	
	}
	
	fun vsscanf(s: *char, format: *char, arg: va_list): int
	{
	
	}
*/
}
