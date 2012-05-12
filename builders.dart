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

class ArbitraryIntBuilder {
  int start = 0, end = 42;
  ArbitraryIntBuilder between(int a, int b) {
    start = a; end = b;
    return this;
  }
  ArbitraryIntBuilder lessThan(int x) {
    end = x - 1;
    return this;
  }
  ArbitraryIntBuilder greaterThan(int x) {
    start = x + 1;
    return this;
  }
  
  Arbitrary<int> toArbitrary() => Int(start, end);
}

class ForAll {
  static ArbitraryIntBuilder get integers() =>
      new ArbitraryIntBuilder();
  
  static ArbitraryIntBuilder get positiveIntegers() => 
      new ArbitraryIntBuilder().greaterThan(0);
  
  static ArbitraryIntBuilder get negativeIntegers() =>
      new ArbitraryIntBuilder().lessThan(0);
}
