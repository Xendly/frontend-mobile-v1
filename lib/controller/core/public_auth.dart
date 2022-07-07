import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xendly_mobile/model/country_model.dart';

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
}
