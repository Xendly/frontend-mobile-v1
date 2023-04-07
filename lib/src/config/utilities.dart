import 'package:flutter/material.dart';

Map<String, String> currencies = {
  'NGN': 'Nigerian Naira',
  'USD': 'United States Dollar',
};

String getCurrency(String currencyCode) {
  if (currencies.containsKey(currencyCode)) {
    return currencies[currencyCode]!;
  } else {
    return "#";
  }
}

void snackBar(BuildContext context, String message,
    [Duration timer = const Duration(milliseconds: 4000)]) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
      ),
      duration: timer,
    ),
  );
}