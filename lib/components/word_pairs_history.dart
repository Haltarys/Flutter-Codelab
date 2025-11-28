import 'package:flutter/material.dart';
import 'package:flutter_codelab/main.dart';
import 'package:provider/provider.dart';

class WordPairsHistory extends StatefulWidget {
  const WordPairsHistory({super.key});

  @override
  State<WordPairsHistory> createState() => _WordPairsHistoryState();
}

class _WordPairsHistoryState extends State<WordPairsHistory> {
  /// Needed so that [MyAppState] can tell [AnimatedList] below to animate
  /// new items.
  final _key = GlobalKey();

  @override
  Widget build(final BuildContext context) {
    final appState = context.watch<MyAppState>();
    final favourites = appState.favourites;
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    appState.historyListKey = _key;

    return Theme(
      data: theme.copyWith(
        textTheme: theme.textTheme.apply(bodyColor: primaryColor, displayColor: primaryColor),
        primaryTextTheme: theme.primaryTextTheme.apply(
          bodyColor: primaryColor,
          displayColor: primaryColor,
        ),
        iconTheme: theme.iconTheme.copyWith(
          color: primaryColor,
          size: theme.textTheme.bodyMedium?.fontSize,
        ),
      ),
      child: AnimatedList(
        key: _key,
        reverse: true, // Makes the list scroll from bottom up instead of from top to bottom
        initialItemCount: appState.history.length,
        itemBuilder: (final context, final index, final animation) {
          final pair = appState.history.elementAt(appState.history.length - 1 - index);

          return SizeTransition(
            sizeFactor: animation,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: [
                  if (favourites.contains(pair))
                    const Icon(Icons.favorite, semanticLabel: 'Favourited'),
                  Text(
                    pair.asLowerCase,
                    // This style shouldn't be needed because of the Theme above but for some reason,
                    // it doesn't work: the theme by itself does not apply the `primaryColor` hence the
                    // `TextStyle` (I should look more into why this doesn't work)
                    style: TextStyle(color: primaryColor),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
