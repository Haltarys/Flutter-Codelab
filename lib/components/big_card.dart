import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.pair});

  final WordPair pair;

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
        child: Text(pair.asLowerCase, style: style, semanticsLabel: pair.asPascalCase),
      ),
    );
  }
}
