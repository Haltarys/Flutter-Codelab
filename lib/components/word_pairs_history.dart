import 'package:flutter/material.dart';
import 'package:flutter_codelab/main.dart';
import 'package:provider/provider.dart';

class WordPairsHistory extends StatelessWidget {
  const WordPairsHistory({super.key});

  @override
  Widget build(final BuildContext context) {
    final appState = context.watch<MyAppState>();
    final favourites = appState.favourites;
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

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
      child: ListView(
        reverse: true, // Makes the list scroll from bottom up instead of from top to bottom
        children: [
          // `.reversed` to show the most recent word first
          for (final pair in appState.history.reversed)
            Padding(
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
        ],
      ),
    );
  }
}
