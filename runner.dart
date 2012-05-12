forAll(generator, callable) {
  final int NUM_RUNS = 100;
  for (int i = 0; i < NUM_RUNS; i++) {
    var next = generator.next();
    print("Next = $next");
    var result = callable(next);
    print ("Result = $result");
  }
}

//check(List property) {
//  property.forEach()
//}