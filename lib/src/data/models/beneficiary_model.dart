class Beneficiary {
  final int? id;
  final String? name;
  final String? phoneNo;
  final int? amount;
  final String? currency;
  final int? beneficiaryId;

  Beneficiary({
    this.id,
    this.name,
    this.phoneNo,
    this.amount,
    this.beneficiaryId,
    this.currency,
  });

  factory Beneficiary.fromMap(Map<String, dynamic> jason) {
    return Beneficiary(
      id: jason['id'],
      name: jason['name'],
      phoneNo: jason['phoneNo'],
      amount: jason['amount'],
      beneficiaryId: jason['beneficiary_id'],
      currency: jason['currency'],
    );
  }
}

class BeneficiaryData {
  final int id;
  final String? displayName;
  final String? phoneNo;
  // final int? amount;
  final String? country;
  final int beneficiaryId;
  final DateTime date;

  BeneficiaryData({
    required this.id,
    this.displayName,
    this.phoneNo,
    required this.beneficiaryId,
    this.country,
    required this.date,
  });

  factory BeneficiaryData.fromJson(Map<String, dynamic> json) {
    return BeneficiaryData(
      id: json['id'],
      displayName: json['display_name'],
      beneficiaryId: json['beneficiary_id'],
      phoneNo: json['beneficiary']['phone'],
      country: json['beneficiary']['country'],
      date: DateTime.tryParse(json['created_at'] ?? 'none') ?? DateTime.now(),
    );
  }
}
