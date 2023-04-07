class AppConstantData {
  static const appName = "Xendly Mobile";
  static const apiUrl = "https://xendly-api.herokuapp.com";
  static const baseUrl = "https://web-production-efab.up.railway.app";
}

class ApiUrls {
  static const baseUrl = 'https://xendly.up.railway.app'; // >>> Dev URL <<< //
  // static const baseUrl = 'https://xendly.up.railway.app'; // >>> Live URL <<< //

  // === Authentication === //
  static userLogin() => "$baseUrl/api/auth/login";
  static userSignUp() => "$baseUrl/api/auth/register";
  // static emailVerification() => "$baseUrl/api/auth/verify/email";
}
