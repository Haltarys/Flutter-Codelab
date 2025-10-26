// Functions

// ignore_for_file: unused_element, unused_local_variable

// External functions (e.g., implemented in another language or in another Dart library)
external void someFunc(int i);

void main(List<String> arguments) {
  // Optionnally, the main function can accept command-line arguments as parameter
  print(arguments);

  // Functions can be nested
  greet(String name) {
    print('Hello, $name!');
  }

  dynamic res = greet('Dart'); // returns null by default because no return statement
  assert(res == null);

  // Return types can be specified explicitly or inferred
  String shout(String message) {
    return message.toUpperCase();
  }

  shoutInferred(String message) {
    // inferred return type String
    return message.toUpperCase();
  }

  // Arrow syntax for short functions
  int add(int x, int y) => x + y;

  res = add(2, 3);
  print('2 + 3 = $res');

  // Functions are first-class objects
  var f = greet;
  f('Flutter'); // Call via the variable

  call(Function fn) {
    return fn('from call()');
  }

  print(call(shout)); // Pass function as argument

  // Anonymous function
  call((_) => print('Hello from anonymous function!'));
  call((_) {
    print('Hello from another anonymous function!');
  });

  // Optional positional parameters
  void buildMessage(String name, [String? prefix, String? suffix]) {
    print('${prefix ?? ''}$name${suffix ?? ''}');
  }

  buildMessage('Dart'); // No prefix/suffix (would throw an error were it not for the square brackets and nullables)
  buildMessage('Dart', 'Hello, '); // With prefix (same reason)
  buildMessage('Dart', 'Hello, ', '!'); // With prefix and suffix

  // Named parameters
  namedParameters(int x, {required int a, int b = 0, int? c}) {
    return a + b + (c ?? 0);
  }

  res = namedParameters(1, a: 2); // b and c are optional
  assert(res == 2);
  res = namedParameters(a: 2, b: 3, c: 4, 1); // Postional arguments can come in any order
  assert(res == 9);

  nullableRequired({required int a, required int? b}) {} // Required named parameters can be nullable
  nullableRequired(a: 1, b: null); // A value for b is still required, even if it's null

  // Lexical closures
  Function makeAdder(int addBy) {
    return (int i) => addBy + i;
  }

  var add2 = makeAdder(2);
  res = add2(3); // 5
  assert(res == 5);

  // Tear-offs
  var charCodes = [68, 97, 114, 116];
  var buffer = StringBuffer();

  charCodes.forEach(print); // Tear-off of top-level function
  charCodes.forEach(buffer.writeCharCode); // Tear-off of instance method

  // Static methods and instance methods
  A.staticMethod(); // Call static method
  var a = A();
  a.instanceMethod(); // Call instance method
  var b = A();
  assert(a.instanceMethod != b.instanceMethod); // Different tear-offs

  // Records
  (int, String) getRecord() {
    return (42, 'Dart'); // Return multiple values at once with a record (like tuples in other languages)
  }

  // Getters & setters
  // Every property access (top-level, static, or instance) is an invocation of a getter or a setter.
  // A variable implicitly creates a getter and, if it's mutable, a setter. This is why when you access a property,
  // you're actually calling a small function in the background. Reading a property calls a getter function,
  // and writing one calls a setter function, even in cases where the property is declared a variable.

  // Reading the value calls the getter.
  print('Current message: $secret');

  /*
  Output:
  Getter was used!
  Current message: HELLO
  */

  // Assigning a value calls the setter.
  secret = 'Dart is fun';

  // Reading it again calls the getter to show the new computed value
  print('New message: $secret');

  /*
  Output:
  Setter was used! New secret: "Dart is fun"
  Getter was used!
  New message: DART IS FUN
  */
}

// Defines a variable `_secret` that is private to the library since
// its identifier starts with an underscore (`_`).
String _secret = 'Hello';

// A public top-level getter that
// provides read access to [_secret].
String get secret {
  print('Getter was used!');
  return _secret.toUpperCase();
}

// A public top-level setter that
// provides write access to [_secret].
set secret(String newMessage) {
  print('Setter was used!');
  if (newMessage.isNotEmpty) {
    _secret = newMessage;
    print('New secret: "$newMessage"');
  }
}

class A {
  static void staticMethod() {}
  void instanceMethod() {}
}
