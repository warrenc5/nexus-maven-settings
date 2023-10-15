package test;

import java.io.FileReader;
import java.io.IOException;
import javax.script.Compilable;
import javax.script.CompiledScript;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;
import org.junit.jupiter.api.Test;

/**
 *
 * @author wozza
 */
public class TestRunScriptTest {

    @Test
    public void run() throws IllegalAccessException, InstantiationException, IOException, ScriptException {
        ScriptEngineManager manager = new ScriptEngineManager();
        ScriptEngine engine = manager.getEngineByName("groovy");
        CompiledScript script = ((Compilable) engine).compile(new FileReader("./src/main/groovy/run.groovy"));
        script.eval();

    }

}
