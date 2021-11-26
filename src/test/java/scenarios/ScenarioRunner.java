package scenarios;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class ScenarioRunner {

    @Karate.Test
    Karate run() { return Karate.run().relativeTo(getClass()); }

    @Karate.Test
    Karate runSuccess() { return Karate.run().tags("@normal").relativeTo(getClass()); }

    // 並行処理
    @Test
    public void runParallelTest() {
        Results results = Runner.path("classpath:scenarios").parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
