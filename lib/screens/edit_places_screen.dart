import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/main_drawer.dart';
import '../components/recomendationsModal.dart';
import '../components/textFieldDecoration.dart';
import '../data/my_data.dart';
import '../data/repositories/places_repository.dart';
import '../models/country.dart';
import '../models/place.dart';

class EditPlacesScreen extends StatefulWidget {
  const EditPlacesScreen({super.key, this.place});
  final Place? place;

  @override
  State<EditPlacesScreen> createState() => _EditPlacesScreenState();
}

class _EditPlacesScreenState extends State<EditPlacesScreen> {
  late List<Country> countriesList;
  late List<bool> checkboxValues;

  TextEditingController recomendationController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> recomendations = [];

  List<String> get selectedCountriesId {
    return checkboxValues
        .asMap()
        .entries
        .where((element) => element.value)
        .map((e) => countriesList[e.key].id)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    countriesList = DUMMY_COUNTRIES;
  }

  @override
  Widget build(BuildContext context) {
    final place = ModalRoute.of(context)!.settings.arguments as Place;
    nameController.text = place.titulo;
    imageUrlController.text = place.imagemUrl;
    recomendations = place.recomendacoes;
    checkboxValues = countriesList.map((e) {
      return place.paises.contains(e.id);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar o Lugar'),
      ),
      drawer: MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um nome';
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: getTextFieldDecoration("Nome do lugar"),
                ),
                SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma url';
                    }
                    return null;
                  },
                  controller: imageUrlController,
                  decoration: getTextFieldDecoration("Url da imagem"),
                ),
                const Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 5),
                  child: Text(
                    'Selecione os paíeses que deseja cadastrar o lugar:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: countriesList.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 160,
                          child: CheckboxListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(countriesList[index].title),
                            value: checkboxValues[index],
                            onChanged: (value) {
                              setState(() {
                                checkboxValues[index] = value!;
                              });
                            },
                          ),
                        );
                      }),
                ),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        isDismissible: false,
                        context: context,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        )),
                        builder: (BuildContext context) {
                          return recomendationsModal(
                            titleControler: recomendationController,
                            onSubmit: (String opa) {
                              setState(() {
                                recomendations.add(opa);
                              });
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.add_circle),
                    label: const Text('Adicione uma recomendação'),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: recomendations.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.grey[300],
                        child: ListTile(
                          title: Text(recomendations[index]),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                recomendations.removeAt(index);
                                recomendationController.clear();
                              });
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Consumer<PlacesRepository>(
        builder: (context, value, child) {
          return FloatingActionButton(
            onPressed: () {
              final isValidForm = formKey.currentState!.validate();
              if (isValidForm && selectedCountriesId.isNotEmpty) {
                Place newPlace = Place(
                  id: place.id,
                  titulo: nameController.text,
                  paises: selectedCountriesId,
                  avaliacao: 4.7,
                  custoMedio: 150,
                  recomendacoes: recomendations,
                  imagemUrl: imageUrlController.text,
                );

                value.updatePlace(newPlace);

                const snackBar = SnackBar(
                  content: Text('O lugar foi atualizado'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.of(context).pushNamed(
                  '/',
                );
              }
              if (selectedCountriesId.isEmpty) {
                const snackBar = SnackBar(
                  content: Text('Selecione pelo menos um país'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: const Icon(Icons.done),
          );
        },
      ),
    );
  }
}
