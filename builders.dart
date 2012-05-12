Int([int start = 0, int end = 42]) => new AnyInt(start, end + 1);

Iterator<List<Object>> ListOf(Iterator<Object> g) => new AnyList<Object>(g);