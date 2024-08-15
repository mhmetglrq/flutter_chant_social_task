import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../repositories/board_repository.dart';

class DeleteBoard implements UseCase<DataState<String>, DeleteBoardParams> {
  final BoardRepository boardRepository;

  DeleteBoard({required this.boardRepository});

  @override
  Future<DataState<String>> call({DeleteBoardParams? params}) async {
    return await boardRepository.deleteBoard(params!.boardId);
  }
}

class DeleteBoardParams {
  final String boardId;

  DeleteBoardParams({required this.boardId});
}
