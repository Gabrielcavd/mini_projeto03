import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/place.dart';

class FavoritesRepository extends ChangeNotifier {
  List<Place> _favoritePlaces = [];

  UnmodifiableListView<Place> get favoritePlaces =>
      UnmodifiableListView(_favoritePlaces);

  void toggleFavorite(Place place) {
    _favoritePlaces.contains(place)
        ? _favoritePlaces.remove(place)
        : _favoritePlaces.add(place);
    notifyListeners();
  }
}
