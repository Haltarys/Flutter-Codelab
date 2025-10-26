// Collections

// ignore_for_file: dead_code, unused_local_variable, invalid_null_aware_operator, avoid_init_to_null

void main() {
  // List
  var list = [1, 2, 3]; // type inferred as List<int>
  list.add(4);
  list.removeLast(); // removes 4
  list.insert(0, 0); // inserts 0 at index 0
  // list.add('5'); // Error: A value of type 'String' can't be assigned to a variable of type 'int'.
  print('List: $list');
  for (var n in list) {
    print(n);
  }

  // Lists are zero-based indexed
  assert(list[0] == 0);
  assert(list.length == 4);

  final list2 = list.sublist(2, 4); // from index 2 to 4 exclusive
  print('Sublist: $list2');

  // Dart passes by reference for objects, so all elements refer to the same object. So, prefer using List.generate for
  // non-primitive types.
  final list3 = List.filled(5, 'a');
  print('Filled list: $list3');

  final list4 = List.generate(5, (i) => [i * i]); // [0, 1, 4, 9, 16]
  print('Generated list: $list4');

  final props = (list.first, list.last, list.length);
  print('First: ${props.$1}, Last: ${props.$2}, Length: ${props.$3}');

  List<int>? a = null;
  var b = [1, null, 3];
  var items = [0, ...?a, ...?b, 4]; // [0, 1, null, 3, 4]

  // Condtional collection elements
  bool depressed = true;
  final cart = ['milk', 'eggs', if (depressed) 'Vodka' else 'Chocolate'];
  print('Shopping cart: $cart');
  cart.removeWhere(
    (item) => item == 'Vodka',
  ); // Final lists can still be modified, though the variable cannot be reassigned

  // Const list
  const constantList = [1, 2, 3];
  var anotherConstantList = const [4, 5, 6];
  // constantList.add(4); // Error: Can't add to an unmodifiable list
  print('Constant list: $constantList');

  // Set
  // /!\ Sets are unordered collections of unique items
  var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'}; // type inferred as Set<String>
  halogens.add('iodine');
  halogens.add('fluorine'); // Duplicate, will be ignored
  print('Set(${halogens.length}), first: ${halogens.first}, last: ${halogens.last}');
  assert(halogens.contains('chlorine'));
  for (var element in halogens) {
    print(element);
  }
  var elements = <String>{};
  elements.add('fluorine');
  elements.addAll(halogens);
  assert(elements.length == 5);

  // Map
  var gifts = {
    // Key:   Value
    'first': 'partridge',
    'second': 'turtledoves',
    'fifth': 'golden rings',
  }; // type inferred as Map<String, String>
  gifts['fourth'] = 'calling birds';
  print('Map: $gifts');
  for (var key in gifts.keys) {
    print('Key: $key, Value: ${gifts[key]}');
  }
  assert(gifts.length == 4);

  var emptyMap = {}; // type inferred as Map<dynamic, dynamic>
  var explicitMap = <String, int>{};
  // ignore: prefer_collection_literals
  var explicitMap2 = Map<String, int>();
  assert(explicitMap2.isEmpty);

  assert(gifts['zeroth'] == null); // Non-existing keys return null

  // Const map
  final constantMap = const {2: 'helium', 10: 'neon', 18: 'argon'};
  const anotherConstantMap = {1: 'hydrogen', 8: 'oxygen'};
  print('Constant map: $constantMap');
  // constantMap[2] = 'Helium'; // This line will cause an error.

  // Collection elements

  // For lists
  int? absentValue = null;
  int? presentValue = 3;
  var items2 = [
    1,
    ?absentValue, // null will be ignored
    ?presentValue, // 3 will be added
    absentValue, // null will be added
    5,
  ]; // [1, 3, null, 5]

  // For maps
  String? presentKey = 'Apple';
  String? absentKey = null;

  int? presentValue2 = 3;
  int? absentValue2 = null;

  var itemsA = {presentKey: absentValue2}; // {Apple: null}
  var itemsB = {presentKey: ?absentValue2}; // {}

  var itemsC = {absentKey: presentValue2}; // {null: 3}
  var itemsD = {?absentKey: presentValue2}; // {}

  var itemsE = {absentKey: absentValue2}; // {null: null}
  var itemsF = {?absentKey: ?absentValue2}; // {}

  // If elements
  var name = 'apple';
  var nums = [0, if (name == 'kiwi') 1 else if (name == 'pear') 10, 2, 3]; // [0, 2, 3]

  Object data = 123;
  var typeInfo = [
    if (data case int i) 'Data is an integer: $i',
    if (data case String s) 'Data is a string: $s',
    if (data case bool b) 'Data is a boolean: $b',
    if (data case double d) 'Data is a double: $d',
  ]; // [Data is an integer: 123, Data is a double: 123]

  var word = 'hello';
  var lengths = [1, if (word case String(length: var wordLength)) wordLength, 3]; // [1, 5, 3]

  // For elements
  var numbers = [2, 3, 4];
  var squares = [1, for (var n in numbers) n * n, 25]; // [1, 4, 9, 16, 25]
  print('Squares: $squares');

  var evens = {for (var n = 0; n < 10; n += 2) n}; // {0, 2, 4, 6, 8}
  print('Evens: $evens');

  var fizzbuzz = [
    for (var n = 0; n <= 45; n++)
      if (n % 3 == 0 && n % 5 == 0) n else null,
  ];
  print('FizzBuzz: $fizzbuzz');

  var nestItems = true;
  var ys = [1, 2, 3, 4];
  var stuff = [
    if (nestItems) ...[
      for (var x = 0; x < 3; x++)
        for (var y in ys)
          if (x < y) x + y * 10,
    ],
  ]; // [10, 20, 30, 40, 21, 31, 41, 32, 42]
  print('Stuff: $stuff');
}
