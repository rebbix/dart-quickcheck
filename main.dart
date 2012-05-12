#import("qc.dart");

main () {
  // forAll(Int(0, 1), (x) => id(x) === x);
  // forAll(ListOf(Int()), (List xs) => xs.isEmpty());
  // forAll(ListOf(Choice([0, 1, 2])), (List xs) => xs.indexOf(3) == -1);
  // forAll(ListOf(Single('A')), (List xs) => xs.indexOf('B') == -1);  
  // forAll(ListOf(CharRange('c', 'a')), (List xs) => xs.indexOf('Z') == -1);
  // var g = ForAll.integers.between(10, 20).toArbitrary();
  // forAll(g, (x) => x >= 15 && x <= 20);
  // g = ForAll.integers.lessThan(5).toArbitrary();
  // forAll(g, (x) => x < 5);
  
  var lg = ForAll.lists.ofLength(5, 15).with.lists.ofLength(2, 4).with.integers.lessThan(5).toArbitrary();
  forAll(lg, (List xs) => xs.length  > 10);
}

id(x) => x;