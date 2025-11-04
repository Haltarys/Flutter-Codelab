import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codelab/home.dart';
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
        home: const Home(),
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

  void removeFavourite(final WordPair favourite) {
    favourites.remove(favourite);
    notifyListeners();
  }
}
