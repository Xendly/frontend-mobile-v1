import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final bool? status;
  final dynamic message, data;

  const TransactionEntity({
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
