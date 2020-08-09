import tcl.lang.*;

public class StringLengthTest {
    public static void main(String[] args) {
        int thestr_len = -1;
        String thestr = "noggy";
        Interp interp = new Interp();
        try {
            interp.eval("string length \"" + thestr + "\"");
            thestr_len = TclInteger.get(interp, interp.getResult());
        } catch (TclException ex) {
            int code = ex.getCompletionCode();
            switch (code) {
	    case TCL.ERROR:
		System.err.println(interp.getResult().toString());
		break;
	    case TCL.BREAK:
		System.err.println(
				   "invoked \"break\" outside of a loop");
		break;
	    case TCL.CONTINUE:
		System.err.println(
				   "invoked \"continue\" outside of a loop");
		break;
	    default:
		System.err.println(
				   "command returned bad error code: " + code);
		break;
            }
        } finally {
            interp.dispose();
        }

        System.out.println("string length was " + thestr_len);
    }
}
