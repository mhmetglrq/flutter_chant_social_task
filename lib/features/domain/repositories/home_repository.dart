import 'package:flutter_chant_social_task/features/domain/entities/board_entity.dart';


abstract class HomeRepository {
  Future<String> createBoard(BoardEntity board);
}
