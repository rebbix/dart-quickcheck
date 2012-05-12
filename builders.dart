Int([int start = 0, int end = 42]) { 
    if (start <= end)
      return new ArbitraryInt(start, end + 1);
    else
      return new ArbitraryInt(end, start + 1);
}
Arbitrary<List<Object>> ListOf(Iterator<Object> g, [minLength, maxLength]) =>
    new ArbitraryList<Object>(g, minLength, maxLength);

Arbitrary<Object> Choice(List<Object> elements) =>
    new ArbitraryChoice<Object>(elements);

Arbitrary<Object> Single(Object o) => Choice([o]);

Arbitrary<Object> CharRange(String a, String b) =>     
      Int(a.charCodeAt(0), b.charCodeAt(0)).passThrough((x) => new String.fromCharCodes([x]));

interface ArbitraryBuilderMarker<T> {
}

class ArbitraryIntBuilder implements ArbitraryBuilderMarker<int> {
  int start = 0, end = 42;
  var parent;
  
  ArbitraryIntBuilder();
  ArbitraryIntBuilder.withParent(this.parent);
  
  ArbitraryIntBuilder between(int a, int b) => 
      greaterOrEqual(a).lessThan(b);
  
  ArbitraryIntBuilder lessThan(int x) => lessOrEqual(x-1);
  
  ArbitraryIntBuilder greaterThan(int x) => greaterOrEqual(x+1);
  
  ArbitraryIntBuilder lessOrEqual(int x) {
    end = x;
    return this;
  }
  
  ArbitraryIntBuilder greaterOrEqual(int x) {
    start = x;
    return this;
  }
  
  Arbitrary<Object> toArbitrary() {
    if(parent !== null) {
      return parent.toArbitrary(Int(start, end));
    } else {
      return Int(start, end);
    }
  }
}

class ArbitraryListBuilder implements ArbitraryBuilderMarker {
  int minLength = 0, maxLength = 42;
  
  var parent;
  
  ArbitraryListBuilder();
  ArbitraryListBuilder.withParent(this.parent);
  
  ArbitraryListBuilder ofLength(int min, [int max]) {
    if (max === null) {
      max = min;
    }
    this.minLength = min;
    this.maxLength = max;
    return this;
  }
  
  ForAllProxy get with() => new ForAllProxy(this);
  
  Arbitrary toArbitrary(iterator) {
    if (parent !== null) {
      return parent.toArbitrary(ListOf(iterator, minLength, maxLength));
    } else {
      return ListOf(iterator, minLength, maxLength);
    }
  }
}

class ArbitraryCharBuilder implements ArbitraryBuilderMarker<String> {
  String rangeStart = 'a', rangeEnd = 'z';
  var parent;
  
  ArbitraryCharBuilder();
  ArbitraryCharBuilder.withParent(this.parent);
  
  
  ArbitraryCharBuilder ofRange(String a, String b) {
    this.rangeStart = a;
    this.rangeEnd = b;
    return this;
  }
  
  Arbitrary toArbitrary() {
    if (parent !== null) {
      return parent.toArbitrary(CharRange(rangeStart, rangeEnd));
    } else {
      return CharRange(rangeStart, rangeEnd);
    }
  }

}

class ForAll {
  static ArbitraryIntBuilder get integers() =>
      new ArbitraryIntBuilder();
  
  static ArbitraryIntBuilder get positiveIntegers() => 
      integers.greaterThan(0);
  
  static ArbitraryIntBuilder get negativeIntegers() =>
      integers.lessThan(0).greaterThan(-42);
  
  static ArbitraryIntBuilder get nonNegativeIntegers() =>
      integers.greaterOrEqual(0);
  
  static ArbitraryIntBuilder get nonPositiveIntegers() =>
      integers.lessOrEqual(0).greaterThan(-42);
  
  static ArbitraryListBuilder get lists() =>
      new ArbitraryListBuilder();
  
  static ArbitraryCharBuilder get chars() =>
      new ArbitraryCharBuilder();
  
  // static of() 
}

class ForAllProxy {
  var parent;
  
  ForAllProxy(this.parent);
  
  get integers() {
    if(parent !== null) {
      return new ArbitraryIntBuilder.withParent(parent);
    } else {
      return ForAll.integers;
    }
  }
  
  get lists() {
    if (parent !== null) {
      return new ArbitraryListBuilder.withParent(parent);
    } else {
      return ForAll.lists;
    }
  }
  
  get chars() {
    if (parent !== null) {
      return new ArbitraryCharBuilder.withParent(parent);
    } else {
      return ForAll.chars;
    }
  }
  
  ArbitraryIntBuilder get positiveIntegers() => 
      integers.greaterThan(0);
  
  ArbitraryIntBuilder get negativeIntegers() =>
      integers.lessThan(0).greaterThan(-42);
  
  ArbitraryIntBuilder get nonNegativeIntegers() =>
      integers.greaterOrEqual(0);
  
  ArbitraryIntBuilder get nonPositiveIntegers() =>
      integers.lessOrEqual(0).greaterThan(-42);
  
  
}
