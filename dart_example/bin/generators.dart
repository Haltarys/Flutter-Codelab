// Generators

void main() {
  // Synchronous generator
  Iterable<int> naturalsTo(int n) sync* {
    int k = 0;
    while (k < n) {
      yield k++;
    }
  }

  for (var n in naturalsTo(5)) {
    print('Synchronous $n'); // 0 1 2 3 4
  }

  // Recursive generators
  Iterable<int> naturalsDownFrom(int n) sync* {
    if (n > 0) {
      yield n;
      yield* naturalsDownFrom(n - 1); // yield* delegates to another generator
    }
  }

  for (var n in naturalsDownFrom(5)) {
    print('Recursive $n'); // 5 4 3 2 1
  }
}
