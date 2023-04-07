import 'package:equatable/equatable.dart';
import 'package:xendly_mobile/src/domain/entities/wallet_entity.dart';

class WalletModel extends Equatable {
  final bool? status;
  final dynamic message, data;

  const WalletModel({
    this.status,
    this.message,
    this.data,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      status: json["status"],
      message: json["message"],
      data: json["data"],
    );
  }

  WalletEntity toEntity() {
    return WalletEntity(
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
