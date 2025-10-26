// Mixins

void main() {}

abstract interface class Animal {
  final int legs;

  Animal(this.legs);
}

mixin LaysEggs {
  int eggs = 0;

  void layEgg() {
    print('Eggs layed: $eggs');
  }
}

mixin IsMammal {
  void lactate() {
    print('Lactating...');
  }
}

class Duck extends Animal with LaysEggs {
  Duck() : super(2);
}
