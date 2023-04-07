class CountryModel {
  final int? id;
  final String? country;
  final String? dialCode;
  final String? shortCode;

  CountryModel({
    this.id,
    this.country,
    this.dialCode,
    this.shortCode,
  });

  factory CountryModel.fromJson(Map<String, dynamic> jsonData) {
    return CountryModel(
      id: jsonData["id"],
      country: jsonData["country"],
      dialCode: jsonData["dial_code"],
      shortCode: jsonData["short_code"],
    );
  }
}
