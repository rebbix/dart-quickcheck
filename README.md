Dart QuickCheck
===============

Abstract
--------
'Dart QuickCheck' (or simply _qc_) is a set of hacks developed in a try to port Haskell Quickcheck to Dart language. Abandon all hope you, who wants to actually use it for real project.

For more info on QuickCheck and property based tetsing read [Wikipedia Article](http://en.wikipedia.org/wiki/QuickCheck)


Example usage
---
The most canonical example is to test Lists reverse function. Of course, for this we have to create one ourselves :) , like this: 

```dart
reverse(L) {
  var L2 = [];
  for (int i = L.length -1; i>=0; --i) {
    L2.add(L[i]);         
  }
  return L2;
}
```

And make a small helper to test for list equality:

```dart
listsEqual(L1, L2) {
  try {
    Expect.listEquals(L1, L2);
  } catch (var _) {
    return false;
  }
  return true;  
}
```

And then, after very annoying couple of minutes we can actulay test our function:

```dart
#import("qc.dart");

main() {
  property("reverse of reverse of list should equal initial list",
    ForAll.lists.with.integers,
    (xs) => listsEqual(xs, reverse(reverse(xs))));
  checkAll();
}
```

For more examples take a look at our extensive set of tests for qc itself :)
```dart
#import("qc.dart");

main () {
  property("any int over 5", ForAll.positiveIntegers.greaterThan(5), (x) => x > 5);
  property("any int under 5", ForAll.positiveIntegers.lessThan(5), (x) => x < 5); 
  
  property("positive ints", ForAll.positiveIntegers, (x) => x > 0);
  property("negative ints", ForAll.negativeIntegers, (x) => x < 0);
  property("non-negative ints", ForAll.nonNegativeIntegers, (x) => x >= 0);
  property("non-positive ints", ForAll.nonPositiveIntegers, (x) => x <= 0);
  property("integers", ForAll.integers, (x) => x is int);
  
  property("chars", ForAll.chars, (x) => x is String);
  property("chars in range", ForAll.chars.ofRange('A','F'), (x) => "ABCDEF".indexOf(x) != -1);
  
  property("lists of positive integers", ForAll.lists.with.positiveIntegers, 
    (x) => x is List && x.every((e) => e >= 0)
  );

  property("lists of list of integers", ForAll.lists.with.lists.with.positiveIntegers, 
    (x) => x is List && x.every((e) => e is List)
  );
  
  property("choice", ForAll.objectsIn([1, "a"]), (x) => x == 1 || x == "a");
  property("list of choice", ForAll.lists.with.objectsIn([1, "a"]), 
    (xs) => xs.every((x) => x == 1 || x == "a")
  );
  checkAll();
}

```

