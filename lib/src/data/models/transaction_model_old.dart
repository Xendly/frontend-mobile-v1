class TransactionModel {
  final int id;
  final String title;
  final double amount;
  final String currency;
  final String entry;
  final String type;
  final String status;
  final double? fee;
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.title,
    required this.currency,
    required this.amount,
    required this.entry,
    required this.status,
    required this.type,
    this.fee,
    required this.date,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      title: json['title'],
      amount: double.tryParse(json['amount']) ?? 0.0,
      entry: json['entry'],
      type: json['type'],
      currency: json['currency'],
      status: json['status'] ?? 'success',
      fee: double.tryParse(json['fee'] ?? '0.0') ?? 0.0,
      date: DateTime.tryParse(json['created_at'] ?? 'null') ?? DateTime.now(),
    );
  }
}
