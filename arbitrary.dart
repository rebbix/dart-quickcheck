interface Arbitrary<T> extends Iterator<T> {
}

abstract class BasicArbitrary<T> implements Arbitrary<T> {
  bool hasNext() => true;
}

class ArbitraryList<T> extends BasicArbitrary<List<T>> {
  final Iterator<T> g;
  final int minLen, maxLen;
  ArbitraryList(this.g, [this.minLen = 0, this.maxLen = 42]);
  List<T> next() {
    int len = randomInRange(minLen, maxLen);
    List<T> list = new List<T>();
    for (int i = 0; i < len; ++i) {
      list.add(g.next());
    }
    return list;
  }
}

class ArbitraryInt extends BasicArbitrary<int> {
  final int start, end;
  ArbitraryInt(int this.start, int this.end);
  int next() => randomInRange(start, end);
}

class ArbitraryChoice<T> extends BasicArbitrary<T> {
  final List<T> elements;
  ArbitraryChoice(List<T> this.elements);
  T next() => elements[randomInRange(0, elements.length)];
}


