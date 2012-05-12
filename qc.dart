main () {
  forAll(Int(0, 1), (x) => id(x) === x);
  forAll(ListOf(Int()), (List xs) => xs.isEmpty());
}

id(x) => x;

class AnyInt implements Iterator<int> {
  final int start, end;
  AnyInt(int this.start, int this.end);
  
  bool hasNext() => true;
  int next() => randomInRange(start, end);
}

int randomInRange(int a, int b) => (Math.random() * (b - a)).toInt() + a;

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

Int([int start = 0, int end = 42]) => new AnyInt(start, end + 1);

Iterator<List<Object>> ListOf(Iterator<Object> g) => new AnyList<Object>(g);

forAll(generator, callable) {
  final int NUM_RUNS = 100;
  for (int i = 0; i < NUM_RUNS; i++) {
    var next = generator.next();
    print("Next = $next");
    var result = callable(next);
    print ("Result = $result");
  }
}

