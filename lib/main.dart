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

  GlobalKey? historyListKey;

  List<WordPair> history = [];
  late WordPair current;
  Set<WordPair> favourites = {};

  void _loadState() {
    final (storedFirst, storedSecond) = (_prefs.getString('first'), _prefs.getString('second'));
    print('Stored current: $storedFirst, $storedSecond');
    current = storedFirst == null || storedSecond == null
        ? WordPair.random()
        : WordPair(storedFirst, storedSecond);

    final storedFavourites = _prefs.getStringList('favourites');
    print('Stored favourites: $storedFavourites');
    if (storedFavourites != null && storedFavourites.isNotEmpty) {
      favourites = _deserialiseWordPairs(storedFavourites).toSet();
    }

    final storedHistory = _prefs.getStringList('history');
    print('Stored history: $storedHistory');
    history = storedHistory == null ? [current] : _deserialiseWordPairs(storedHistory).toList();
  }

  void _showFavouritedToast(final String message) {
    _scaffoldKey.currentState!.showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }

  static List<String> _serialiseWordPairs(final Iterable<WordPair> pairs) {
    return pairs.map((final pair) => '${pair.first}|${pair.second}').toList();
  }

  static Iterable<WordPair> _deserialiseWordPairs(final List<String> pairs) {
    return pairs.map((final pair) {
      final [first, second] = pair.split('|');
      return WordPair(first, second);
    });
  }

  void getNext() {
    final animatedList = historyListKey?.currentState as AnimatedListState?;
    animatedList?.insertItem(0);

    current = WordPair.random();

    _prefs.setString('first', current.first); // Dangling Future
    _prefs.setString('second', current.second); // Dangling Future

    history.add(current);
    print('History: $history');
    _prefs.setStringList('history', _serialiseWordPairs(history)); // Dangling Future

    notifyListeners();
  }

  void toggleFavourite([WordPair? pair]) {
    pair ??= current;
    if (favourites.contains(pair)) {
      favourites.remove(pair);
      _showFavouritedToast('"${pair.asLowerCase}" was removed from favourites.');
    } else {
      favourites.add(pair);
      _showFavouritedToast('"${pair.asLowerCase}" was added to favourites.');
    }

    _prefs.setStringList('favourites', _serialiseWordPairs(favourites)); // Dangling Future
    notifyListeners();
  }

  void removeFavourite(final WordPair favourite) {
    favourites.remove(favourite);
    _showFavouritedToast('"${favourite.asLowerCase}" was removed from favourites.');

    _prefs.setStringList('favourites', _serialiseWordPairs(favourites)); // Dangling Future
    notifyListeners();
  }
}
