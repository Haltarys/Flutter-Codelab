import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(final BuildContext context) {
    return ChangeNotifierProvider(
      create: (final context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
        home: HomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favourites = <WordPair>{};

  void toggleFavourite() {
    if (favourites.contains(current)) {
      favourites.remove(current);
    } else {
      favourites.add(current);
    }
    print('Favourites: $favourites');
    notifyListeners();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context) {
    final appState = context.watch<MyAppState>();

    final wordPair = appState.current;

    // Show a filled or a outlined icon depending on whether the word is favourited or not
    final icon = appState.favourites.contains(wordPair) ? Icons.favorite : Icons.favorite_border;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(wordPair: wordPair),
            SizedBox(height: 10),
            Row(
              // Center the buttons by preventing the row from taking the full available width
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.center, // Would work as well
              children: [
                ElevatedButton.icon(
                  onPressed: appState.toggleFavourite,
                  icon: Icon(icon),
                  label: Text('Like'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    print('Button pressed');
                    appState.getNext();
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.wordPair});

  final WordPair wordPair;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    // Make a copy of the style used for middle-level headings (`displayMedium`) from `theme` and
    // override its color property with a color that pairs well with the primary color of the theme.
    // `theme.colorScheme.onPrimary` pairs well with `theme.colorScheme.primary` so the resulting
    // card looks nice.
    final style = theme.textTheme.displayMedium!.copyWith(color: theme.colorScheme.onPrimary);

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          wordPair.asLowerCase,
          style: style,
          semanticsLabel: '${wordPair.first} ${wordPair.second}',
        ),
      ),
    );
  }
}
