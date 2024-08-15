// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_chant_social_task/features/data/data_sources/cloud/firebase_service.dart';
import 'package:flutter_chant_social_task/features/data/models/board_model.dart';
import 'package:flutter_chant_social_task/features/domain/repositories/boards_repository.dart';

class BoardsRepositoryImpl extends BoardsRepository {
  FirebaseService firebaseService;
  BoardsRepositoryImpl({
    required this.firebaseService,
  });

  @override
  Stream<List<BoardModel>> getBoards() {
    return firebaseService.getBoards();
  }
}
