Int([int start = 0, int end = 42]) { 
    if (start <= end)
      return new ArbitraryInt(start, end + 1);
    else
      return new ArbitraryInt(end, start + 1);
}
Arbitrary<List<Object>> ListOf(Iterator<Object> g) =>
    new ArbitraryList<Object>(g);
Arbitrary<Object> Choice(List<Object> elements) =>
    new ArbitraryChoice<Object>(elements);
Arbitrary<Object> Single(Object o) => Choice([o]);
Arbitrary<Object> CharRange(String a, String b) =>     
      Int(a.charCodeAt(0), b.charCodeAt(0)).passThrough((x) => new String.fromCharCodes([x]));