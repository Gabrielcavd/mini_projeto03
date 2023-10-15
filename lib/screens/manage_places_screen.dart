import 'package:f03_lugares/components/main_drawer.dart';
import 'package:f03_lugares/data/my_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/repositories/places_repository.dart';
import '../models/place.dart';
import '../utils/app_routes.dart';

class ManagePlacesScreen extends StatefulWidget {
  const ManagePlacesScreen({super.key});

  @override
  State<ManagePlacesScreen> createState() => _ManagePlacesPageState();
}

class _ManagePlacesPageState extends State<ManagePlacesScreen> {
  @override
  Widget build(BuildContext context) {
    List<Place> places = Provider.of<PlacesRepository>(context).places;
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Lugares'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: places.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(places[index].imagemUrl),
                ),
                title: Text(places[index].titulo),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.EDIT_PLACES,
                            arguments: places[index],
                          );
                        },
                        icon: Icon(Icons.edit),
                        color: Colors.amber,
                      ),
                      IconButton(
                        onPressed: () {
                          Provider.of<PlacesRepository>(context, listen: false)
                              .removePlace(places[index]);
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}
