// Generics

// ignore_for_file: unused_local_variable

void main() {
  Box<String> box1 = Box('cool');
  Box<double> box2 = Box(2.23);

  // Collection literals
  var names = <String>['Seth', 'Kathy', 'Lars'];
  var uniqueNames = <String>{'Seth', 'Kathy', 'Lars'};
  var pages = <String, String>{
    'index.html': 'Homepage',
    'robots.txt': 'Hints for web robots',
    'humans.txt': 'We are people, not machines',
  };
}

// Generic class
class Box<T extends Object> {
  // Generic class with type restriction
  T value;

  Box(this.value);

  T openBox() {
    return value;
  }
}

// Self-referential type parameter restrictions (F-bounds)

abstract interface class Comparable<T> {
  int compareTo(T o);
}

int compareAndOffset<T extends Comparable<T>>(T t1, T t2) => t1.compareTo(t2) + 1;
