import 'package:f03_lugares/components/place_item.dart';
import 'package:f03_lugares/data/my_data.dart';
import 'package:f03_lugares/data/repositories/places_repository.dart';
import 'package:f03_lugares/models/country.dart';
import 'package:f03_lugares/models/place.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryPlacesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final country = ModalRoute.of(context)!.settings.arguments as Country;
    List<Place> places = Provider.of<PlacesRepository>(context).places;

    final countryPlaces = places.where((places) {
      return places.paises.contains(country.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(country.title),
      ),
      body: ListView.builder(
          itemCount: countryPlaces.length,
          itemBuilder: (ctx, index) {
            return PlaceItem(countryPlaces[index]);
          }),
    );
  }
}
