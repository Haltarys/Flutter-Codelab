// Inheritance

// ignore_for_file: unused_local_variable

void main() {
  dynamic tv = SmartTelevision();

  print(tv.volume = 10);

  tv.nonExistentMethod(); // Calls noSuchMethod()
}

class Television {
  void _illuminateDisplay() {}
  void _activateIrSensor() {}

  void turnOn() {
    _illuminateDisplay();
    _activateIrSensor();
  }

  set volume(int v) {
    print('TV volume set: $v');
  }
}

class SmartTelevision extends Television {
  void _bootNetworkInterface() {}
  void _initializeMemory() {}
  void _upgradeApps() {}

  @override // Optional but preferred
  void turnOn() {
    super.turnOn();
    _bootNetworkInterface();
    _initializeMemory();
    _upgradeApps();
  }

  // Getters & setters can be overridden too
  @override
  // The return type must be the same type as (or a subtype of) the overridden method's return type.
  // Parameters of the overriding method must be of the same type or a super-type of it
  // Here, `num` is a super type of `int` and `double`
  set volume(num v) {
    print('Boost bass...');
    super.volume = v as int;
  }

  // Override `noSuchMethod` to detect when calling a non-existent method or accessing a non-existent member
  // Unless you override noSuchMethod, using a
  // non-existent member results in a NoSuchMethodError.
  @override
  void noSuchMethod(Invocation invocation) {
    print(
      'You tried to use a non-existent member: '
      '${invocation.memberName}',
    );
  }
}

// Abstract class
abstract class Vehicle {
  void moveForward(int meters); // Abstract method
}

class Car extends Vehicle {
  @override
  void moveForward(int meters) {
    print('Driving $meters forward...');
  }
}
