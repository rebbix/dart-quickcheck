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
  
  // property("choice", ForAll.objectsIn([1, "a"]), (x) => x == 1 || x == "a");
  
  checkAll();
}
