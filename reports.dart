class Reporter {
  final bool verbose;
  
  Reporter(this.verbose);
  
  void testStart(Property<Object> p) =>
    print("Testing property: '${p.name}'");
  
  void testSuccess(Property<Object> p, Results rs) =>
    print("SUCCESS: '${p.name}' after ${rs.count()} checks.\n");  
  
  void testFail(Property<Object> p, Results rs) =>
    print("FAIL: '${p.name}' after ${rs.count()} checks.\n");
  
  void singleCheck(Result<Object> r) =>
      r.result ? _success(r) : _fail(r);
      
  void summary(List<bool> rs) {
    var failed = rs.filter((r) => !r);
    int numFailed = failed.length;
    if (numFailed > 0) 
      print ("FAILURE: ${numFailed} tests failed!");
  }
  
  void _fail(Result<Object> r) =>
    print("\tFAILED for '${r.input.toString()}'");
  
  void _success(Result<Object> r) =>
      verbose ? print ("\tSUCCESS for '${r.input.toString()}'") : _skip();
}

_skip() {}