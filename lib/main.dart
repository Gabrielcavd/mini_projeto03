import 'dart:ui';

import 'package:f03_lugares/data/repositories/favorites_repository.dart';
import 'package:f03_lugares/models/place.dart';
import 'package:f03_lugares/screens/countries_places_screen.dart';
import 'package:f03_lugares/screens/edit_places_screen.dart';
import 'package:f03_lugares/screens/place_detail_screen.dart';
import 'package:f03_lugares/screens/register_places_screen.dart';
import 'package:f03_lugares/screens/settings_screen.dart';
import 'package:f03_lugares/screens/tabs_screen.dart';
import 'package:f03_lugares/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/repositories/places_repository.dart';
import 'screens/countries_screen.dart';
import 'screens/manage_places_screen.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => PlacesRepository(),
          ),
          ChangeNotifierProvider(
            create: (context) => FavoritesRepository(),
          ),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<Place> _favoritePlaces;

  void _toggleFavorite(Place place) {
    Provider.of<FavoritesRepository>(context, listen: false)
        .toggleFavorite(place);
  }

  bool _isFavorite(Place place) {
    return _favoritePlaces.contains(place);
  }

  @override
  Widget build(BuildContext context) {
    _favoritePlaces = Provider.of<FavoritesRepository>(context).favoritePlaces;
    return MaterialApp(
      title: 'PlacesToGo',
      theme: ThemeData(
        colorScheme: ThemeData()
            .colorScheme
            .copyWith(primary: Colors.purple, secondary: Colors.amber),
        fontFamily: 'Raleway',
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      initialRoute: '/',
      routes: {
        AppRoutes.REGISTER_PLACES: (ctx) => RegisterPlacesScreen(),
        AppRoutes.HOME: (ctx) => TabsScreen(_favoritePlaces),
        AppRoutes.COUNTRY_PLACES: (ctx) => CountryPlacesScreen(),
        AppRoutes.PLACES_DETAIL: (ctx) =>
            PlaceDetailScreen(_toggleFavorite, _isFavorite),
        AppRoutes.SETTINGS: (ctx) => SettingsScreen(),
        AppRoutes.MANAGE_PLACES: (ctx) => ManagePlacesScreen(),
        AppRoutes.EDIT_PLACES: (ctx) => EditPlacesScreen(),
      },
    );
  }
}
