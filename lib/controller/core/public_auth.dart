import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:http/http.dart' as http;
import 'package:xendly_mobile/model/country_model.dart';
import 'package:xendly_mobile/model/wallet_model.dart';

class PublicAuth {
  // === FETCH COUNTRIES === //
  Future<List<CountryModel>> getCountry() async {
    http.Response response = await http.get(
      Uri.parse(
        'https://xendly-api.herokuapp.com/api/misc/countries',
      ),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final List responseData = jsonDecode(response.body)['data'];
      return responseData
          .map(((country) => CountryModel.fromJson(country)))
          .toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  // === HANDLE WALLET FUNDING === //
  // void handlePaymentInit(
  //   BuildContext context,
  //   String name,
  //   String phone,
  //   String email,
  //   String amount,
  //   String currency,
  // ) async {
  //   try {
  //     final style = FlutterwaveStyle(
  //       appBarText: "My Standard Blue",
  //       buttonColor: const Color(0xffd0ebff),
  //       appBarIcon: const Icon(
  //         Icons.message,
  //         color: Color(0xffd0ebff),
  //       ),
  //       buttonTextStyle: const TextStyle(
  //         color: Colors.black,
  //         fontWeight: FontWeight.bold,
  //         fontSize: 18,
  //       ),
  //       appBarColor: const Color(0xffd0ebff),
  //       dialogCancelTextStyle: const TextStyle(
  //         color: Colors.redAccent,
  //         fontSize: 18,
  //       ),
  //       dialogContinueTextStyle: const TextStyle(
  //         color: Colors.blue,
  //         fontSize: 18,
  //       ),
  //     );

  //     final Customer customer = Customer(
  //       name: name,
  //       phoneNumber: phone,
  //       email: email,
  //     );

  //     final Flutterwave flutterwave = Flutterwave(
  //       isTestMode: false,
  //       context: context,
  //       style: style,
  //       publicKey: "FLWPUBK_TEST-9da57004452405fe95c857f569eac55f-X",
  //       currency: currency,
  //       redirectUrl: "my_redirect_url",
  //       txRef: "unique_transaction_reference",
  //       amount: amount,
  //       customer: customer,
  //       paymentOptions: "card",
  //       customization: Customization(title: "Xendly Test Payment"),
  //     );

  //     final ChargeResponse response = await flutterwave.charge();
  //     if (response != null) {
  //       print("Flutterwave Standard User is TRUE, User PROCEED with Tx!");
  //       print(response.toJson());
  //       if (response.success == true) {
  //         print("Flutterwave Standard is TRUE, Tx might be a SUCCESS!");
  //       } else {
  //         print("Flutterwave Standard is FALSE, Tx is defintely a FAILURE!");
  //       }
  //     } else {
  //       print("Flutterwave Standard User is FALSE, User CANCELLED Tx!");
  //     }
  //   } catch (err) {
  //     throw Exception(err);
  //   }
  // }
}
