import 'package:equatable/equatable.dart';
import 'package:xendly_mobile/src/domain/entities/misc_entity.dart';

class MiscModel extends Equatable {
  final bool? status;
  final dynamic message, data;

  const MiscModel({
    this.status,
    this.message,
    this.data,
  });

  factory MiscModel.fromJson(Map<String, dynamic> json) {
    return MiscModel(
      status: json["status"],
      message: json["message"],
      data: json["data"],
    );
  }

  MiscEntity toEntity() {
    return MiscEntity(
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
