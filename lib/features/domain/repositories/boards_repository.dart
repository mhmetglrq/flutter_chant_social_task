import '../entities/board_entity.dart';

abstract class BoardsRepository {
  Stream<List<BoardEntity>> getBoards();
}
