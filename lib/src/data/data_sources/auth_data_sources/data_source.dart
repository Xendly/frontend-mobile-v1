import 'package:xendly_mobile/src/data/models/auth_model.dart';

abstract class AuthDataSource {
  Future<AuthModel> userLogin(Map<String, dynamic> data);
  Future<AuthModel> signUp(Map<String, dynamic> data);
  Future<AuthModel> verifyEmail(Map<String, dynamic> data);
  Future<AuthModel> loginAuth(Map<String, dynamic> data);
  Future<AuthModel> createPin(Map<String, dynamic> data);
  Future<AuthModel> verifyPin(Map<String, dynamic> data);
  Future<AuthModel> forgotPassword(Map<String, dynamic> data);
  Future<AuthModel> resetPassword(Map<String, dynamic> data);
  Future<AuthModel> resendOtp(String? email);
  Future<AuthModel> logout();
}
