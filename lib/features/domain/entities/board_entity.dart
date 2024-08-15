import 'package:equatable/equatable.dart';

class BoardEntity extends Equatable {
  final String? uid;
  final String? name;
  final List<String>? participants;
  final dynamic color;
  final String? createdBy;
  final String? createdAt;
  final String? status;

  const BoardEntity(this.uid, this.name, this.participants, this.createdBy,
      this.createdAt, this.status, this.color);

  @override
  List<Object?> get props {
    return [
      uid,
      name,
      participants,
      color,
      createdBy,
      createdAt,
      status,
    ];
  }
}
