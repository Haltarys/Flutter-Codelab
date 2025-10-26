// Control flow

void main() {
  // If-else statement
  String status = 'loading';

  if (status == 'loading') {
    print('The application is loading...');
  } else if (status == 'success') {
    print('The application loaded successfully!');
  } else // Curly braces are optional for single statements
    print('The application failed to load.');

  // Condition must be explicitly boolean
  bool? b;

  if (b == true) print('b is true');

  // If-case statement
  var time = (h: 23, minutes: 42); // Record type (int, int)

  // case can be used for destructuring
  if (time case (h: var h, minutes: var m) when h >= 0 && h < 24 && m >= 0 && m < 60) {
    print('Valid time: $h:$m');
  } else {
    print('Invalid time: $time');
  }

  // Switch statement
  const failure = 'failure';

  status = 'pending';
  switch (status) {
    loading:
    case 'loading':
      print('Switch: loading');
      break;
    case 'pending' || 'processing': // `||` allows multiple values in a single case
      print('Switch: pending');
      continue loading; // Jumps to the `loading` case above
    case 'success'
        when b == true: // guard clause with the `when` keyword adds a boolean expression that must also be true
      print('Switch: success');
      break;
    case failure: // const variables can also be used as case value
    case 'error':
    case _: // or `default:`
      print('Switch: failure');
  }

  // Switch expressions
  status = 'processing';
  int statusCode = switch (status) {
    'loading' => 100,
    'pending' ||
    (== 'processing') => 102, // For some reason, the 'status' variable name is not required in the expression
    'success' => 200,
    'error' || failure => 500,
    _ => throw Exception('Unknown status'),
  };
  print('Status code: $statusCode');

  // While loop
  int count = 0;
  while (count < 3) {
    print('While loop count: $count');
    count++;
  }

  // For loop
  for (int i = 0; i < 3; i++) {
    print('For loop i: $i');
    // break;
    continue;
  }

  // Do-while loop
  int i = 0;
  do {
    print('Do-while i: $i');
    i++;
  } while (i < 3);

  // Assert
  /**
   * `assert` is used for debugging purposes to check for conditions that should always be true.
   * It throws an AssertionError if the condition is false AND only runs in debug mode.
   * In release mode, asserts are ignored.
   * Run with `dart --enable-asserts control_flow.dart` to enable asserts.
   */
  print('i = $i');
  assert(i == 3);
  assert(i != 0, 'i should not be zero');

  // Labels
  outerLoop:
  for (var i = 1; i <= 3; i++) {
    for (var j = 1; j <= 3; j++) {
      print('i = $i, j = $j');
      if (i == 2 && j == 2) {
        break outerLoop; // Breaks out of the outer loop
      }
    }
  }
  print('outerLoop exited');
  // Output:
  // i = 1, j = 1
  // i = 1, j = 2
  // i = 1, j = 3
  // i = 2, j = 1
  // i = 2, j = 2
  // outerLoop exited

  outerLoop:
  for (var i = 1; i <= 3; i++) {
    for (var j = 1; j <= 3; j++) {
      if (i == 2 && j == 2) {
        continue outerLoop; // Continues with the next iteration of the outer loop
        // (skips remaining iterations for i = 2)
      }
      print('i = $i, j = $j');
    }
  }
  // Output:
  // i = 1, j = 1
  // i = 1, j = 2
  // i = 1, j = 3
  // i = 2, j = 1
  // i = 2, j = 2 (skipped)
  // i = 2, j = 3 (skipped)
  // i = 3, j = 1
  // i = 3, j = 2
  // i = 3, j = 3

  // Guard clauses
  const arch = 'x86-64';
  final registerSize = switch (arch) {
    'x86-64' || 'arm64' when arch.endsWith('64') => 64, // guard clause with `when` to further refine the case
    'x86' || 'arm32' => 32,
    _ => throw Exception('Unknown architecture'),
  };
  print('Register size for $arch: $registerSize bits');
}
