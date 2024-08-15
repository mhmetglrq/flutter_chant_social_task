import 'package:flutter_chant_social_task/core/usecase/usecase.dart';

import '../../entities/board_entity.dart';
import '../../repositories/boards_repository.dart';

class GetBoards implements StreamUseCase<List<BoardEntity>, void> {
  final BoardsRepository boardsRepository;

  GetBoards({required this.boardsRepository});

  @override
  Stream<List<BoardEntity>> call({void params}) {
    return boardsRepository.getBoards();
  }
}
