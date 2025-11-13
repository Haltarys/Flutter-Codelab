import 'package:flutter/material.dart';
import 'package:flutter_codelab/pages/favourites_page.dart';
import 'package:flutter_codelab/pages/generator_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  @override
  Widget build(final BuildContext context) {
    final Widget page;
    switch (selectedIndex) {
      case 0:
        page = const GeneratorPage();
        break;
      case 1:
        page = const FavouritesPage();
        break;
      default:
        throw UnimplementedError('No widget for $selectedIndex!');
    }

    // The container for the current page, with its background color
    // and subtle switching animation.
    final mainArea = ColoredBox(
      // color: colorScheme.surfaceContainerHighest,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: AnimatedSwitcher(duration: const Duration(milliseconds: 2000), child: page),
    );

    return LayoutBuilder(
      builder: (final context, final constraints) {
        return Scaffold(
          body: (constraints.maxWidth < 450)
              ?
                // Use a more mobile-friendly layout with BottomNavigationBar
                // on narrow screens.
                Column(
                  children: [
                    Expanded(child: mainArea),
                    BottomNavigationBar(
                      items: const [
                        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
                      ],
                      currentIndex: selectedIndex,
                      onTap: _setTab,
                    ),
                  ],
                )
              : Row(
                  children: [
                    SafeArea(
                      child: NavigationRail(
                        extended: constraints.maxWidth >= 600,
                        destinations: const [
                          NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
                          NavigationRailDestination(
                            icon: Icon(Icons.favorite),
                            label: Text('Favourites'),
                          ),
                        ],
                        selectedIndex: selectedIndex,
                        onDestinationSelected: _setTab,
                      ),
                    ),
                    Expanded(child: mainArea),
                  ],
                ),
        );
      },
    );
  }

  void _setTab(final int value) {
    print('selected: $value');
    setState(() {
      selectedIndex = value;
    });
  }
}
