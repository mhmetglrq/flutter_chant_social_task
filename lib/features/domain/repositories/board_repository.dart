import 'package:flutter_chant_social_task/core/resources/data_state.dart';

import '../entities/board_entity.dart';

abstract class BoardRepository {
  Stream<List<BoardEntity>> getBoards();
  Stream<BoardEntity> getBoard(String boardId);
  Future<DataState<String>> updateBoard(BoardEntity board);
  Future<DataState<String>> deleteBoard(String boardUid);
}
