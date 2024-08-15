import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chant_social_task/features/domain/entities/board_entity.dart';

class BoardModel extends BoardEntity {
  const BoardModel({
    String? uid,
    String? name,
    List<dynamic>? moves,
    String? createdBy,
    Timestamp? createdAt,
    String? status,
    String? color,
    String? opponent,
    String? currentTurn,
    String? winner,
  }) : super(
          uid,
          name,
          moves,
          createdBy,
          createdAt,
          status,
          color,
          opponent,
          currentTurn,
          winner,
        );

  factory BoardModel.fromJson(Map<String, dynamic> json) {
    return BoardModel(
      uid: json['uid'],
      name: json['name'],
      moves: json['participants'],
      createdBy: json['createdBy'],
      createdAt: json['createdAt'],
      status: json['status'],
      color: json['color'],
      opponent: json['opponent'],
      currentTurn: json['currentTurn'],
      winner: json['winner'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'participants': moves,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'status': status,
      'color': color,
      'opponent': opponent,
      'currentTurn': currentTurn,
      'winner': winner,
    };
  }

  factory BoardModel.fromEntity(BoardEntity entity) {
    return BoardModel(
      uid: entity.uid,
      name: entity.name,
      moves: entity.moves,
      createdBy: entity.createdBy,
      createdAt: entity.createdAt,
      status: entity.status,
      color: entity.color,
      opponent: entity.opponent,
      currentTurn: entity.currentTurn,
      winner: entity.winner,
    );
  }

  //copyWith method
  BoardModel copyWith({
    String? uid,
    String? name,
    List<dynamic>? moves,
    String? createdBy,
    Timestamp? createdAt,
    String? status,
    String? color,
    String? opponent,
    String? currentTurn,
    String? winner,
  }) {
    return BoardModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      moves: moves ?? this.moves,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      color: color ?? this.color,
      opponent: opponent ?? this.opponent,
      currentTurn: currentTurn ?? this.currentTurn,
      winner: winner ?? this.winner,
    );
  }
}
