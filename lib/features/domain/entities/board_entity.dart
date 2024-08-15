import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class BoardEntity extends Equatable {
  final String? uid;
  final String? name;
  final List<dynamic>? participants;
  final dynamic color;
  final String? createdBy;
  final Timestamp? createdAt;
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
