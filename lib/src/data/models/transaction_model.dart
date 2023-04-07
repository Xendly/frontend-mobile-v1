import 'package:equatable/equatable.dart';
import 'package:xendly_mobile/src/domain/entities/transaction_entity.dart';

class TransactionModel extends Equatable {
  final bool? status;
  final dynamic message, data;

  const TransactionModel({
    this.status,
    this.message,
    this.data,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      status: json["status"],
      message: json["message"],
      data: json["data"],
    );
  }

  TransactionEntity toEntity() {
    return TransactionEntity(
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
