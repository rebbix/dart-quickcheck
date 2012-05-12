class AnyList<T> implements Iterator<List<T>> {
  final Iterator<T> g;
  final int minLen, maxLen;
  AnyList(this.g, [this.minLen = 0, this.maxLen = 42]);
  bool hasNext() => true;
  List<T> next() {
    int len = randomInRange(minLen, maxLen);
    List<T> list = new List<T>();
    for (int i = 0; i < len; ++i) {
      list.add(g.next());
    }
    return list;
  }
}

class AnyInt implements Iterator<int> {
  final int start, end;
  AnyInt(int this.start, int this.end);
  
  bool hasNext() => true;
  int next() => randomInRange(start, end);
}