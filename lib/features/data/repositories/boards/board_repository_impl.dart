// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_chant_social_task/core/resources/data_state.dart';
import 'package:flutter_chant_social_task/features/data/data_sources/cloud/firebase_service.dart';
import 'package:flutter_chant_social_task/features/data/models/board_model.dart';
import 'package:flutter_chant_social_task/features/domain/entities/board_entity.dart';
import 'package:flutter_chant_social_task/features/domain/repositories/board_repository.dart';

class BoardRepositoryImpl extends BoardRepository {
  FirebaseService firebaseService;
  BoardRepositoryImpl({
    required this.firebaseService,
  });

  @override
  Stream<List<BoardModel>> getBoards() {
    return firebaseService.getBoards();
  }

  @override
  Stream<BoardEntity> getBoard(String boardId) {
    return firebaseService.getBoard(boardId);
  }

  @override
  Future<DataState<String>> updateBoard(BoardEntity board) {
    return firebaseService.updateBoard(BoardModel.fromEntity(board));
  }

  @override
  Future<DataState<String>> deleteBoard(String boardUid) {
    return firebaseService.deleteBoard(boardUid);
  }
}
