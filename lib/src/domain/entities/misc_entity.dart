import 'package:equatable/equatable.dart';

class MiscEntity extends Equatable {
  final bool? status;
  final dynamic message, data;

  const MiscEntity({
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
