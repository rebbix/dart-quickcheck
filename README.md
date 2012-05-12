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

For more examples take alook at our extensive [set of tests for qc itself](https://github.com/rebbix/dart-quickcheck/blob/master/tests.dart).
