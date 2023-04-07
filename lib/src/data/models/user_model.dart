import 'package:equatable/equatable.dart';
import 'package:xendly_mobile/src/domain/entities/user_entity.dart';
import 'package:xendly_mobile/src/domain/entities/wallet_entity.dart';

class UserModel extends Equatable {
  final bool? status;
  final dynamic message, data;

  const UserModel({
    this.status,
    this.message,
    this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json["status"],
      message: json["message"],
      data: json["data"],
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      status: status,
      message: message,
      data: data,
    );
  }

  @override
  List<Object> get props {
    return [
      status!,
      message!,
      data!,
    ];
  }
}
