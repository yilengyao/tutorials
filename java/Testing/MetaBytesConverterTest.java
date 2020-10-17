import org.junit.jupiter.api.BeforeEach;
import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class MetaBytesConverterTest {
    private final ByteArrayOutputStream outputStreamCaptor = new ByteArrayOutputStream();

    @BeforeEach
    public void setUp() {
        System.setOut(new PrintStream(outputStreamCaptor));
    }

    @Test
    public void test1() {
        MegaBytesConverter.printMegaBytesAndKiloBytes(2500);
        assertEquals("2500 KB = 2 MB and 452 KB", outputStreamCaptor.toString().trim());
    }

    @Test
    public void test2() {
        MegaBytesConverter.printMegaBytesAndKiloBytes(-1024);
        assertEquals("Invalid Value", outputStreamCaptor.toString().trim());
    }

    @Test
    public void test3() {
        MegaBytesConverter.printMegaBytesAndKiloBytes(5000);
        assertEquals("5000 KB = 4 MB and 904 KB", outputStreamCaptor.toString().trim());
    }
}
