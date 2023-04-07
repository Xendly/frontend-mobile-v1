import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final bool? status;
  final dynamic message, data;

  const UserEntity({
    this.status,
    this.message,
    this.data,
  });

  @override
  List<Object> get props {
    return [
      status!,
      message!,
      data!,
    ];
  }
}
