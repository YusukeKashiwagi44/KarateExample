package mock;

public class SequenceUtils {

    static int num = 0;

    public static int getSequence() {
        return num++ ;
    }
}
