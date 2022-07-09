import 'package:flutter/material.dart';

// I am using Get dialogs, but you can declare all your dialogs here or remove this file
// left an example below

Future<void> showLoader(BuildContext ctx) {
  return showDialog(
    context: ctx,
    builder: (_) => const AlertDialog(
      title: CircularProgressIndicator(),
    ),
  );
}
