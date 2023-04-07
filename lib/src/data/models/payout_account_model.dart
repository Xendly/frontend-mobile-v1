class PayoutAccountModel {
  final int id;
  final String accountName;
  final String accountNumber;
  final String bankCode;
  final String bankName;
  final String currency;
  final String? branchCode;
  final DateTime date;

  PayoutAccountModel({
    required this.id,
    required this.accountName,
    required this.currency,
    required this.accountNumber,
    required this.bankName,
    required this.bankCode,
    this.branchCode,
    required this.date,
  });

  factory PayoutAccountModel.fromJson(Map<String, dynamic> json) {
    return PayoutAccountModel(
      id: json['id'],
      accountName: json['account_name'],
      accountNumber: json['account_number'],
      bankName: json['bank_name'],
      bankCode: json['bank_code'],
      currency: json['currency'],
      branchCode: json['branch_code'],
      date: DateTime.tryParse(json['created_at'] ?? 'null') ?? DateTime.now(),
    );
  }
}
