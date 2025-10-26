// Async

void main() async {
  // Future

  // A Future is like a promise in JavaScript
  var delay = Future.delayed(Duration(seconds: 5));

  delay.then((value) => print('I have been waiting')).catchError((err) {
    print(err);
    return null;
  });

  // Async-await
  Future<String> runInTheFuture() async {
    var data = await Future.value('world');

    return 'hello $data';
  }

  print(await runInTheFuture());

  // Stream

  var stream = Stream.fromIterable([1, 2, 3, 4, 5]);

  await for (final int i in stream) {
    print('Stream $i');
  }

  // Listen to a stream multiple times (only once by default)
  var stream2 = Stream.fromIterable([1, 2, 3]).asBroadcastStream();

  stream2.listen((i) => print('Broadcast stream $i'));
  stream2.map((x) => x * 2).listen((i) => print('Broadcast stream $i'));

  // Asynchronous generator
  asynchronousNaturalsTo(5).listen((n) {
    print('Asynchronous $n'); // 0 1 2 3 4
  });
}

Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) {
    yield k++;
  }
}
