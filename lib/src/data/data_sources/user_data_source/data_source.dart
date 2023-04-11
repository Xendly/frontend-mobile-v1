import 'package:xendly_mobile/src/data/models/user_model.dart';

abstract class UserDataSource {
  Future<UserModel> getProfile();
  Future<UserModel> getUserData(String username);
  Future<UserModel> updatePin(Map<String, dynamic> data);
  Future<UserModel> bvnVerification(Map<String, dynamic> data);
  Future<UserModel> updateAddress(Map<String, dynamic> data);
  Future<UserModel> updateUsername(String? username);
  Future<UserModel> updatePhone(String? phone);
  Future<UserModel> virtualAccount(Map<String, dynamic> data);
}
