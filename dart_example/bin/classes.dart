// Classes

// ignore_for_file: unused_local_variable, unnecessary_new, invalid_null_aware_operator, unnecessary_this, unused_field

void main() {
  // Basic
  var basic = new Basic(1);
  Basic? basic2 = Basic(2);

  print(basic.id); // Dot notation to access members
  basic2?.printSelf(); // Null-aware access operator

  Basic.staticMethod(); // Calling static method

  // Constructors
  var rect = Rectangle(10, 20, 'MyRectangle'); // Positional optional parameter
  const circle = Circle(radius: 15, name: 'MyCircle'); // Named parameters
  var circle2 = const Circle(radius: 15, name: 'MyCircle'); // const constructor
  var circle3 = Circle(radius: 15, name: 'MyCircle'); // const constructor
  assert(identical(circle, circle2)); // Both refer to the same instance because they are const
  assert(!identical(circle, circle3)); // Different instances

  // Named constructors
  var point1 = Point.fromXY(10, 20); // Using named constructor
  var point2 = Point.fromMap({'lat': 30, 'long': 40});

  // Factory constructors
  // The constructor doesn't always create a new instance of its class. Although a factory constructor can't return
  // null, it might return an existing instance from a cache instead of creating a new one or a new instance of a
  // subtype.

  var logger = Logger('UI');
  logger.log('Button clicked');

  var logMap = {'name': 'UI'};
  var loggerJson = Logger.fromJson(logMap);

  // Constructor tear-offs
  var charCodes = [65, 66, 67];
  // Use a tear-off for a named constructor:
  var strings = charCodes.map(String.fromCharCode);

  // Use a tear-off for an unnamed constructor:
  var buffers = charCodes.map(StringBuffer.new);
}

class Basic {
  int type = 5;
  int id;

  Basic(this.id);

  void printSelf() {
    print('Basic type: $type, id: $id');
  }

  static void staticMethod() {
    print('This is a static method.');
  }
}

class Rectangle {
  final int width;
  final int height;
  late final int area;
  String? name;

  // `name` is a positional optional parameter
  Rectangle(this.width, this.height, [this.name]) {
    this.area = width * height; // `this` is optional
  }
}

class Circle {
  const Circle({required int radius, String? name}); // const constructor
}

class Point {
  final int lat;
  final int long;

  // Named constructor fromXY
  Point.fromXY(this.lat, this.long);

  // Named constructor fromMap
  Point.fromMap(Map<String, int> coords) : lat = coords['lat'] ?? 0, long = coords['long'] ?? 0;
}

// Late fields
double initialX = 1.5;

class Coordinates {
  // OK, can access declarations that do not depend on `this`:
  double? x = initialX;

  // ERROR, can't access `this` in non-`late` initializer:
  // double? y = this.x;

  // OK, can access `this` in `late` initializer:
  late double? z = this.x;

  // OK, `this.x` and `this.y` are parameter declarations, not expressions:
  // Coordinates(this.x, this.y);

  Coordinates.optional([this.x = 0, this.z = 1]); // Optional formal parameters
}

// Final fields
class ProfileMark {
  final String name;
  final DateTime start = DateTime.now(); // Initialized at declaration

  ProfileMark(this.name); // Initialized in constructor
  ProfileMark.unnamed() : name = ''; // Initialized in initializer list
}

// Constructors
class A {} // Default constructor, unnamed and no parameters

class B {
  B(); // Generative constructor, explicitly defined
}

class C {
  C.named(); // Named constructor
}

class D {
  const D(); // Const constructor
}

class E {
  String i;
  E(this.i); // Constructor with parameter
  E.redirect() : this('42'); // Redirecting constructor
}

class Logger {
  final String name;
  bool mute = false;

  // _cache is library-private, thanks to
  // the _ in front of its name.
  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name) {
    // Factory constructors can't access this
    return _cache.putIfAbsent(name, () => Logger._internal(name));
  }

  factory Logger.fromJson(Map<String, Object> json) {
    return Logger(json['name'].toString());
  }

  factory Logger.redirect(String name) = Logger._internal; // Redirecting factory constructor

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) print(msg);
  }
}

class Foo {
  final double _x;
  final double _y;

  // Error: can't use private names in parameter list
  // ONLY FOR NAMED PARAMETERS
  // Foo.namedPrivate({required double _x, required double _y});
  Foo.namedPrivate(double y, {required double x}) : _x = x, _y = y;
}
