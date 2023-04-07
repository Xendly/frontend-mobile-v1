import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final bool status, verifyOtpStatus;
  final dynamic message, data;

  const AuthEntity({
    required this.status,
    this.message,
    required this.verifyOtpStatus,
    this.data,
  });

  @override
  List<Object> get props {
    return [
      status!,
      message!,
      verifyOtpStatus,
      data!,
    ];
  }
}
