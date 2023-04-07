import 'package:equatable/equatable.dart';

class WalletEntity extends Equatable {
  final bool? status;
  final dynamic message, data;

  const WalletEntity({
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
