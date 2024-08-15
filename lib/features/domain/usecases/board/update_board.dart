import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../entities/board_entity.dart';
import '../../repositories/board_repository.dart';

class UpdateBoard implements UseCase<DataState<String>, UpdateBoardParams> {
  final BoardRepository boardRepository;

  UpdateBoard({required this.boardRepository});

  @override
  Future<DataState<String>> call({UpdateBoardParams? params}) {
    return boardRepository.updateBoard(params!.board);
  }
}

class UpdateBoardParams {
  final BoardEntity board;

  UpdateBoardParams({required this.board});
}
