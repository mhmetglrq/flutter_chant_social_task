import 'package:flutter_chant_social_task/features/domain/entities/board_entity.dart';

class BoardModel extends BoardEntity {
  const BoardModel({
    String? uid,
    String? name,
    List<String>? participants,
    String? createdBy,
    String? createdAt,
    String? status,
    String? color,
  }) : super(
          uid,
          name,
          participants,
          createdBy,
          createdAt,
          status,
          color,
        );

  factory BoardModel.fromJson(Map<String, dynamic> json) {
    return BoardModel(
      uid: json['uid'],
      name: json['name'],
      participants: json['participants'],
      createdBy: json['createdBy'],
      createdAt: json['createdAt'],
      status: json['status'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'participants': participants,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'status': status,
      'color': color,
    };
  }

  factory BoardModel.fromEntity(BoardEntity entity) {
    return BoardModel(
      uid: entity.uid,
      name: entity.name,
      participants: entity.participants,
      createdBy: entity.createdBy,
      createdAt: entity.createdAt,
      status: entity.status,
      color: entity.color,
    );
  }
}
