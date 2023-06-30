libsl "1.0.0";

library signal
	version ""
	language "C"
	url "";

import "std/utils/semantic";
import "std/utils/definitions";

include "<signal.h>";

typealias sig_fn = void;
typealias `*sig_fn` = sig_fn;

automaton SIGNAL: int 
{
	var sig_table: array<sig_fn>;

	fun signal(sig: int, handler: sig_fn): `*sig_fn`
	{
        var s: sig_fn;
        if (sig <= 0 || sig >= NSIG || handler == SIG_ERR) {
            result = SIG_ERR;
        } else {
            s = sig_table[sig];
            sig_table[sig] = handler;
            result = s;
        }
	}
	
	fun raise(sig_num: int): int
	{
        var s: sig_fn;

        if (sig_num <= 0 || sig_num >= NSIG) {
            result = -1;
        } else {
            s = sig_table[sig_num];
            if (s != SIG_IGN && s != SIG_DFL) {
                sig_table[sig_num] = SIG_DFL;
                s(sig_num);
            } else {
                if (s == SIG_DFL) {
                    action SYS_RAISE_SIGNAL("error");
                } else {
                    result = 0;
                }
            }
        }
	}

}