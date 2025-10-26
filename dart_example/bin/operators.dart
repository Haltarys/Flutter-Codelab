// Operators

void main() {
  // Arithmetic operators
  assert(2 + 3 == 5);
  assert(2 - 3 == -1);
  assert(2 * 3 == 6);
  assert(5 / 2 == 2.5); // Result is a double
  assert(5 ~/ 2 == 2); // Result is an int
  assert(5 % 2 == 1); // Remainder

  assert('5/2 = ${5 ~/ 2} r ${5 % 2}' == '5/2 = 2 r 1');

  // Prefix and postfix increment/decrement
  int a = 5;
  assert(++a == 6); // Prefix increment
  assert(a++ == 6); // Postfix increment
  assert(a == 7);
  assert(--a == 6); // Prefix decrement
  assert(a-- == 6); // Postfix decrement

  // Relational operators
  assert(2 == 2);
  assert(2 != 3);
  assert(3 > 2);
  assert(2 < 3);
  assert(3 >= 3);
  assert(2 <= 3);

  // Logical operators
  assert(true && true);
  // ignore: dead_code
  assert(true || false);
  assert(!false);

  // Type test operators
  // Prefer using `is` and `is!` over `runtimeType` checks
  // ignore: unnecessary_type_check
  assert(5 is int);
  assert(5 is! String); // is! means "is not"

  // Type cast operator
  Object obj = 'Hello, Dart!';
  String str = obj as String;
  assert(str.length == 12);

  // var number = 23 as String; // Valid cast, but will throw a runtime error
  // number is String; // true

  // Bitwise operators
  assert((5 & 3) == 1); // AND: 0101 & 0011 = 0001
  assert((5 | 3) == 7); // OR: 0101 | 0011 = 0111
  assert((5 ^ 3) == 6); // XOR: 0101 ^ 0011 = 0110
  assert((~5) == -6); // NOT: ~0101 = ...1010 (two's complement)
  assert((5 << 1) == 10); // Left shift
  assert((5 >> 1) == 2); // Right shift
  assert((-5 >>> 2) == 4611686018427387902); // Unsigned right shift (for positive numbers, this is the same as >>;
  // for negative numbers, it fills with zeros on the left instead of ones, hence the large positive result)

  // Conditional (ternary) operator
  int b = 10;
  String result = (b > 5) ? 'Greater than 5' : '5 or less';
  assert(result == 'Greater than 5');

  // Null-aware operators
  String? nullableStr;
  assert((nullableStr ?? 'Default') == 'Default'); // If nullableStr is null, use 'Default'
  nullableStr ??= 'Dart'; // Assign 'Dart' if nullableStr is null
  assert(nullableStr == 'Dart');

  // Cascade notation

  // ignore: unused_local_variable
  var paint = Paint()
    ..color = Colors.black
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 5.0; // Create a value, assign properties, and return the value, all in one expression.

  // Functionnally equivalent to:
  // var paint = Paint();
  // paint.color = Colors.black;
  // paint.strokeCap = StrokeCap.round;
  // paint.strokeWidth = 5.0;

  // If the object is potentially null, use the null-shorting cascade operator `?..` FOR THE FIRST OPERATION ONLY:
  Paint? nullablePaint;
  nullablePaint
    // Only needed once!
    ?..color = Colors.black
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 5.0
    ..dry(); // No effect since nullablePaint is null
}

class Paint {
  late String color;
  late StrokeCap strokeCap;
  late double strokeWidth;

  void dry() {
    print("I'm drying my hardest!");
  }
}

enum StrokeCap { butt, round, square }

class Colors {
  static const String black = 'black';
}
