import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class BoardEntity extends Equatable {
  final String? uid;
  final String? name;
  final List<dynamic>? moves;
  final String? opponent;
  final dynamic color;
  final String? createdBy;
  final Timestamp? createdAt;
  final String? status;
  final String? currentTurn;
  final String? winner;

  const BoardEntity(
      this.uid,
      this.name,
      this.moves,
      this.createdBy,
      this.createdAt,
      this.status,
      this.color,
      this.opponent,
      this.currentTurn,
      this.winner);

  @override
  List<Object?> get props {
    return [
      uid,
      name,
      moves,
      opponent,
      color,
      createdBy,
      createdAt,
      status,
      currentTurn,
      winner,
    ];
  }
}
