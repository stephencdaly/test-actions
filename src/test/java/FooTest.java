import org.junit.jupiter.api.Test;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;

class FooTest {
    @Test
    void shouldReturn1() {
        assertThat(Foo.getNumber(), is(1));
    }
}