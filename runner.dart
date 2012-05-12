prepareArbitrary(g) {
  if (g is ArbitraryBuilder)
    return g.toArbitrary();
  else
    return g;
}

check(name, generator, callable) {
  return new Property(name, prepareArbitrary(generator), callable);
}

Property property(name, generator, callable) {
  Property p = new Property(name, prepareArbitrary(generator), callable);
  Property.registerProperty(p);
  return p;
}

void checkAll() {
  run(Property.declaredProperties);
  Property.declaredProperties = null;
}
//checkFails(name, generator, callable) =>
    //new Property.negative(name, prepareArbitrary(generator), callable);

void run(List<Property<Object>> ps) {
  final config = new Config();
  (new Suite(ps, config)).run();
}

beVerbose() => Config.setVerbose(true);
shutUp() => Config.setVerbose(false);

class Config {
  static int _numRuns = 100;
  static bool _verbose = false;
  Reporter report;
  
  Config() {
      report = new Reporter(_verbose);
  }
  
  int get numRuns() => _numRuns;
  bool get verbose() => _verbose;
  
  static bool setVerbose(bool flag) => _verbose = flag;
}


class Suite {
  final List<Property<Object>> properties;
  final Config config;
  
  Suite(this.properties, this.config);
  
  void run() {
    var results = [];
    properties.forEach((p) => results.add(_testOne(p)));
    config.report.summary(results);
  }
  
  bool _testOne(Property<Object> p) {
    config.report.testStart(p);
    final Results rs = new Results();
    for (int i = 0; i<config.numRuns; ++i) {
      final Result<Object> r = p.check();      
      rs.add(r);
      config.report.singleCheck(r);
      if (! r.result) {
        return _fail(p, rs);            
      }
    }    
    return _success(p, rs);
  }
  
  bool _fail(Property p, Results rs) {
    config.report.testFail(p, rs);
    return false;
  }
  
  bool _success(Property p, Results rs) {
    config.report.testSuccess(p, rs);
    return true;
  }
}

class Result<T> {
  final Property<T> property;
  final T input;
  final bool result;
  Result(this.property, this.input, this.result);
}


class Results {
  List<Result<Object>> _results;
  
  Results() {
    _results = [];
  }
  
  void add(Result<Object> r) => _results.add(r);
  
  int count() => _results.length;
  
  Result<Object> latest() => _results.last();
}

class Property<T> {
  final String name;
  final Iterator<T> _generator;
  final Function _callable;
  Condition _condition;
  Function _filter = null;
  static List<Property> declaredProperties;
  
  static registerProperty(p) {
    if (declaredProperties == null)
      declaredProperties = new List<Property>();
    declaredProperties.add(p);
  }
  
  Property(this.name, this._generator, this._callable) {
    _condition = new AcceptPositive();    
  }
  
  Property.negative(this.name, this._generator, this._callable) {
    _condition = new AcceptNegative();
  }
  
  Result<T> check() {
    final T input = _takeWhile(_filter, _generator.next);
    
    final bool checkResult = _callable(input);
    final bool result = _condition.check(checkResult);
    return new Result<T>(this, input, result);
  }
  
  Property<T> when(filter) {
    _filter = filter;
    return this;
  }
  
  _takeWhile(condition, f) {
    // TODO: Report if too much tries.
    var r = f();
    if (condition == null) return r;
    while (! condition(r)) {
      r = f();
    }
    return r;
  }
}

abstract class Condition {
  abstract bool check(bool r);
}

class AcceptPositive extends Condition {
  bool check(bool r) => r;
}

class AcceptNegative extends Condition {
  bool check(bool r) => !r;
}

