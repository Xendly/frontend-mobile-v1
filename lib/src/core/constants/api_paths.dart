class ApiUrls {
  static const String baseUrl = 'https://xendly.up.railway.app';
  static const String newBaseUrl = 'https://api.xendly.co';
  // static const String baseUrl = 'https://api.xendly.co';

  // >>> Authentication <<< //
  static String register() => '$baseUrl/api/auth/register';
  static String login() => '$baseUrl/api/auth/login';
  static String verifyEmail() => "$baseUrl/api/auth/verify/email";
  static String loginAuth() => "$baseUrl/api/auth/login/authorize";
  static String forgotPassword() => "$baseUrl/api/auth/password/forgot";
  static String resetPassword = "$baseUrl/api/auth/password/reset";
  static String virtualAccount() => "$baseUrl/api/users/virtual-account";
  static String createPin() => "$baseUrl/api/users/pin/create";
  static String verifyPin() => "$baseUrl/api/users/pin/verify";
  static String resendOtp() => '$baseUrl/api/auth/verify/resend';
  static String logout() => '$baseUrl/api/users/logout';

  // wallet
  static String getUserWallets() => "$baseUrl/api/wallets/user";
  static String p2pTransfer() => "$baseUrl/api/wallets/transfer/p2p";
  static String exchange() => "$baseUrl/api/wallets/currency/exchange";

  // beneficiaries
  static String getBeneficiaries() => "$baseUrl/api/beneficiaries/all";
  static String createBankBeneficiary() => "$baseUrl}/api/bank-beneficiaries";

  // >>> Transactions <<< //
  static String createPaymentLink() =>
      "$baseUrl/api/transactions/create-payment-link";
  static String withdrawMoney() => '$baseUrl/accounts/withdraw';
  static String sendFunds() => '$baseUrl/accounts/transfer';
  static String transactions() {
    return '$baseUrl/api/transactions/summary?page=1&limit=50';
  }

  static String currencyTransactions(String currency) {
    return '$baseUrl/api/transactions/summary/currency/$currency?page=1&limit=50';
  }

  // user
  static String getProfile() {
    return '$baseUrl/api/users/profile';
  }

  static String bvnVerification = '$baseUrl/api/users/bvn-verification';
  static String addressUpdate = '$baseUrl/api/users/address';

  static String getUserData(String? username) {
    return '$baseUrl/api/users/info/username/$username';
  }

  static String updatePin() {
    return '$baseUrl/api/users/pin/update';
  }

  // misc
  static String rate(String fromCurrency, String toCurrency) {
    return "$baseUrl/api/misc/single-currency-pair/$fromCurrency/$toCurrency";
  }

  static String getBanksList = "$baseUrl/api/misc/banks/list";
  static String getAcctInfo = "$baseUrl/api/misc/resolve-account-number";
  static String bankTransfer = "$baseUrl/api/wallets/bank-transfer";
  static String fcmToken = "$baseUrl/api/users/fcm-token";

  static String getBanks() {
    return "$baseUrl/api/misc/banks/NG";
  }

  static String resolveAccount() {
    return "$baseUrl/api/misc/resolve-bank-account";
  }
}
