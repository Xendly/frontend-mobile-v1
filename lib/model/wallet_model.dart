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

  Wallet.fromJson(Map<String, dynamic> walletData)
      : id = walletData['id'],
        userId = walletData['userId'],
        balance = walletData['balance'],
        currency = walletData['currency'],
        active = walletData['active'],
        createdAt = walletData['createdAt'],
        updatedAt = walletData['updatedAt'],
        primary = walletData['primary'];
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
