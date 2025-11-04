import 'package:flutter/material.dart';
import 'package:flutter_codelab/main.dart';
import 'package:provider/provider.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(final BuildContext context) {
    final appState = context.watch<MyAppState>();
    final favourites = appState.favourites;

    if (appState.favourites.isEmpty) {
      return const Center(child: Text('No favourites yet'));
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have ${appState.favourites.length} favourites:'),
        ),
        for (final pair in favourites)
          ListTile(
            title: Text(pair.asLowerCase),
            leading: const Icon(Icons.favorite),
            onLongPress: () {
              appState.removeFavourite(pair);
              print('Favourite ${pair.asLowerCase} removed');
              print('Favourites: $favourites');
            },
          ),
      ],
    );
  }
}
