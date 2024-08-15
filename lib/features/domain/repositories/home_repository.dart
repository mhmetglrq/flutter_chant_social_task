import 'package:flutter_chant_social_task/features/domain/entities/board_entity.dart';

import '../../../core/resources/data_state.dart';


abstract class HomeRepository {
  Future<DataState<String>> createBoard(BoardEntity board);
}
