import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codelab/home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(),
  );
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.prefs});

  final SharedPreferencesWithCache prefs;
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  // This widget is the root of your application.
  @override
  Widget build(final BuildContext context) {
    return ChangeNotifierProvider(
      create: (final context) => MyAppState(_scaffoldKey, prefs),
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
  MyAppState(this._scaffoldKey, this._prefs) {
    _loadState();
  }

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey;
  final SharedPreferencesWithCache _prefs;

  late WordPair current;
  late Set<WordPair> favourites;

  void _loadState() {
    final (storedFirst, storedSecond) = (_prefs.getString('first'), _prefs.getString('second'));
    print('$storedFirst, $storedSecond');
    current = storedFirst == null || storedSecond == null
        ? WordPair.random()
        : WordPair(storedFirst, storedSecond);

    final storedFavourites = _prefs.getStringList('favourites');
    print('$storedFavourites');
    favourites = storedFavourites == null || storedFavourites.isEmpty
        ? <WordPair>{}
        : storedFavourites.map((final s) {
            final [first, second] = s.split('|');
            return WordPair(first, second);
          }).toSet();
  }

  void _showFavouritedToast(final String message) {
    _scaffoldKey.currentState!.showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }

  List<String> serialiseFavourites() {
    return favourites.map((final pair) => '${pair.first}|${pair.second}').toList();
  }

  void getNext() {
    current = WordPair.random();

    _prefs.setString('first', current.first); // Dangling Future
    _prefs.setString('second', current.second); // Dangling Future

    notifyListeners();
  }

  void toggleFavourite() {
    if (favourites.contains(current)) {
      favourites.remove(current);
      _showFavouritedToast('"${current.asLowerCase}" was removed from favourites.');
    } else {
      favourites.add(current);
      _showFavouritedToast('"${current.asLowerCase}" was added to favourites.');
    }

    _prefs.setStringList('favourites', serialiseFavourites());
    notifyListeners();
  }

  void removeFavourite(final WordPair favourite) {
    favourites.remove(favourite);
    _showFavouritedToast('"${favourite.asLowerCase}" was removed from favourites.');

    _prefs.setStringList('favourites', serialiseFavourites());
    notifyListeners();
  }
}
