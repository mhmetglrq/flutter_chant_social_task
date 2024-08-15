import '../../../../core/usecase/usecase.dart';
import '../../entities/board_entity.dart';
import '../../repositories/board_repository.dart';

class GetBoard implements StreamUseCase<BoardEntity, GetBoardParams> {
  final BoardRepository boardRepository;

  GetBoard({required this.boardRepository});

  @override
  Stream<BoardEntity> call({GetBoardParams? params}) {
    return boardRepository.getBoard(params!.uid);
  }
}

class GetBoardParams {
  final String uid;

  GetBoardParams({
    required this.uid,
  });
}
