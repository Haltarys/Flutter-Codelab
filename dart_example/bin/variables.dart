// ignore_for_file: unused_local_variable

// Variables

void main() {
  int a;
  int i = 10;
  double d = 3.14;
  bool b = true;
  String s = 'Hello, Dart!'; // Use single or double quotes

  // String interpolation
  print('i = $i, d = $d, i + d = ${i + d}'); // Interpolate variable names or expressions

  // `is` is like the `instanceof` keyword in JavaScript
  print((i + d) is int); // false

  // .runtimeType is the type of an object at runtime
  print((i + d).runtimeType); // double

  // Dynamic and inferred types
  Object dynamic; // Dynamic type, since no initial value is assigned (could also be written as `var dynamic;`)
  var inferred = s; // Inferred type String

  inferred = 'hello, world'; // OK
  // inferred = 123; // Error: even though the type was inferred, it is still statically typed from the declaration

  dynamic = b;
  dynamic = inferred;

  // final and const
  final fi = i + 5; // Final variable, can only be set once (like `const` in JavaScript)
  const ci = 3.14; // Compile-time constant

  // Null safety
  String? nullable; // Nullable type

  print(nullable); // null by default

  if (dynamic is String) {
    nullable = 'Now I have a value!';
  }
  String str = nullable!; // Non-null assertion operator (throws if null)

  print(str);

  final animal = Animal();
  animal.goBig();
}

// Late variables
class Animal {
  // Sometimes, you want to declare a non-nullable variable, but you don't actually have the value to initialize it yet.
  // In that case, you can use the `late` keyword to tell the compiler that you'll initialize it later, before you use
  // it. If you try to use it before it's initialized, you'll get a runtime error.

  late final String _size; // Late variable, initialized later

  void goBig() {
    // print(_size); // Error if accessed before initialization
    _size = 'big';
    print(_size);
  }
}
