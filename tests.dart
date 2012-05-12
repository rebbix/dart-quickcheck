#import("qc.dart");

main () {
  property("any int over 5", ForAll.positiveIntegers.greaterThan(5), (x) => x > 5);
  property("any int under 5", ForAll.positiveIntegers.lessThan(5), (x) => x < 5); 
  
  property("positive ints", ForAll.positiveIntegers, (x) => x > 0);
  property("negative ints", ForAll.negativeIntegers, (x) => x < 0);
  property("integers", ForAll.integers, (x) => x is int);

  checkAll();
}
