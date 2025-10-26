// Import

// ignore_for_file: unused_local_variable

import 'inheritance.dart' as tv; // Import the whole file with namespace
import 'inheritance.dart' hide Television; // Import the whole file but the Television class
import 'inheritance.dart' show SmartTelevision; // Import only the SmartTelevision class
import 'inheritance.dart'; // Import the whole file

class Television {
  // Shadows the Television class from 'inheritance.dart'
}

void main() {
  var tv1 = SmartTelevision();
  var tv2 = tv.Television();
}
