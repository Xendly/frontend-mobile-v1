import 'package:equatable/equatable.dart';
import 'package:xendly_mobile/src/domain/entities/auth_entity.dart';

class AuthModel extends Equatable {
  final bool status, verifyOtpStatus;
  final dynamic message, data;

  const AuthModel({
    required this.status,
    this.message,
    required this.verifyOtpStatus,
    this.data,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      status: json["status"],
      message: json["message"],
      verifyOtpStatus: json["verify_otp"] ?? false,
      data: json["data"],
    );
  }

  AuthEntity toEntity() {
    return AuthEntity(
      status: status,
      message: message,
      verifyOtpStatus: verifyOtpStatus,
      data: data,
    );
  }

  @override
  List<Object> get props {
    return [
      status,
      message!,
      verifyOtpStatus,
      data!,
    ];
  }
}
