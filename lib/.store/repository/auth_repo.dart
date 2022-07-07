import 'package:get/get.dart';
import 'package:xendly_mobile/model/request_result.dart';
import 'package:xendly_mobile/provider/auth_provider.dart';
// import 'package:xendly_mobile/repository/helpers.dart';

class AuthRepo extends GetxService {
  // declare providers here
  final AuthProvider _authProvider = AuthProvider();

  // declare properties here
  final Rx<String> userToken = "".obs;

  // === SIGN UP AUTHENTICATOR === //
  Future<RequestResult> signUp(Map<String, dynamic> data) async {
    try {
      final httpResult = await _authProvider.signUpUser(data);
      if (httpResult.status == true || httpResult.statusCode == 201) {
        final data = httpResult.data as Map<String, dynamic>;
        return RequestResult(
          httpResult.status,
          "${data['id']}",
        );
      } else {
        // return parseHttpError(httpResult);
        return RequestResult(
          httpResult.status,
          "Issue with the REG request",
          data: httpResult.data,
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
