import 'package:flutter_chant_social_task/features/data/models/board_model.dart';
import 'package:flutter_chant_social_task/features/domain/entities/board_entity.dart';

import '../../../domain/repositories/home_repository.dart';
import '../../data_sources/cloud/firebase_service.dart';

class HomeRepositoryImpl implements HomeRepository {
  final FirebaseService firebaseService;

  HomeRepositoryImpl({required this.firebaseService});

  @override
  Future<String> createBoard(BoardEntity board) {
    BoardModel boardModel = BoardModel.fromEntity(board);
    return firebaseService.createBoard(boardModel);
  }
}
