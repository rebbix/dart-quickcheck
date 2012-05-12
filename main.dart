#import("qc.dart");
main () {
  forAll(Int(0, 1), (x) => id(x) === x);
  forAll(ListOf(Int()), (List xs) => xs.isEmpty());
}


id(x) => x;