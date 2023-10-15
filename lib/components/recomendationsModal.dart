import 'package:f03_lugares/components/textFieldDecoration.dart';
import 'package:flutter/material.dart';

class recomendationsModal extends StatelessWidget {
  const recomendationsModal(
      {super.key, required this.titleControler, required this.onSubmit});
  final TextEditingController titleControler;
  final void Function(String) onSubmit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormField(
            controller: titleControler,
            decoration: getTextFieldDecoration("Recomendação"),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (titleControler.text != "") {
                    onSubmit(titleControler.text);
                    titleControler.clear();
                  }
                },
                child: const Text("Submeter"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancelar"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
