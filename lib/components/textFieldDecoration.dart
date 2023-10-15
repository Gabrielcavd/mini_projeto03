import 'package:flutter/material.dart';

InputDecoration getTextFieldDecoration(String label) {
  return InputDecoration(
    label: Text(label),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Color.fromARGB(255, 105, 69, 185),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Color.fromARGB(255, 105, 69, 185),
      ),
    ),
  );
}
