class BankModel {
  final int id;
  final String bankCode;
  final String bankName;

  BankModel({
    required this.id,
    required this.bankCode,
    required this.bankName,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      id: json['id'],
      bankCode: json['code'],
      bankName: json['name'],
    );
  }
}
