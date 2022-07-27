class VirtualAccount {
  final int? id;
  final int? userId;
  final String? orderRef;
  final String? reference;
  final String? accountNumber;
  final String? accountName;
  final String? bankName;
  final String? currency;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  VirtualAccount({
    this.id,
    this.userId,
    this.orderRef,
    this.reference,
    this.accountNumber,
    this.accountName,
    this.bankName,
    this.currency,
    this.createdAt,
    this.updatedAt,
  });

  factory VirtualAccount.fromJson(Map<String, dynamic> json) => VirtualAccount(
        id: json["id"],
        userId: json["user_id"],
        orderRef: json["order_ref"],
        reference: json["reference"],
        accountNumber: json["account_number"],
        accountName: json["account_name"],
        bankName: json["bank_name"],
        currency: json["currency"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
