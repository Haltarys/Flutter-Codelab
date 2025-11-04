import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codelab/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  // This widget is the root of your application.
  @override
  Widget build(final BuildContext context) {
    return ChangeNotifierProvider(
      create: (final context) => MyAppState(_scaffoldKey),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
        scaffoldMessengerKey: _scaffoldKey,
        home: const Home(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  MyAppState(this._scaffoldKey);

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey;

  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favourites = <WordPair>{};

  void _showFavouritedToast(final String message) {
    _scaffoldKey.currentState!.showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }

  void toggleFavourite() {
    if (favourites.contains(current)) {
      favourites.remove(current);
      _showFavouritedToast('"${current.asLowerCase}" was removed from favourites.');
    } else {
      favourites.add(current);
      _showFavouritedToast('"${current.asLowerCase}" was added to favourites.');
    }
    print('Favourites: $favourites');

    notifyListeners();
  }

  void removeFavourite(final WordPair favourite) {
    favourites.remove(favourite);
    _showFavouritedToast('"${current.asLowerCase}" was removed from favourites.');

    notifyListeners();
  }
}
