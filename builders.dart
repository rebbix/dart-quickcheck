Int([int start = 0, int end = 42]) =>
    new ArbitraryInt(start, end + 1);

Arbitrary<List<Object>> ListOf(Iterator<Object> g) =>
    new ArbitraryList<Object>(g);
Arbitrary<Object> Choice(List<Object> elements) =>
    new ArbitraryChoice<Object>(elements);
Arbitrary<Object> Single(Object o) => Choice([o]);