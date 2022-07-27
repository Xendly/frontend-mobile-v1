class Wallet {
  final int? id;
  final int? userId;
  final String? balance;
  final String? currency;
  final bool? active;
  final String? createdAt;
  final String? updatedAt;
  final bool? primary;

  Wallet({
    this.id,
    this.userId,
    this.balance,
    this.currency,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.primary,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json['id'],
      userId: json['user_id'],
      balance: json['balance'],
      currency: json['currency'],
      active: json['active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      primary: json['primary'],
    );
  }
}

class FundWallet {
  final int? id;
  final int? amount;

  FundWallet({
    this.id,
    this.amount,
  });

  FundWallet.fromJson(Map<String, dynamic> walletData)
      : id = walletData['id'],
        amount = walletData['amount'];
}
