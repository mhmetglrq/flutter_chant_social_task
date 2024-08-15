import 'package:flutter_chant_social_task/features/domain/usecases/board/get_boards.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data_sources/cloud/firebase_service.dart';
import '../../data/repositories/boards/board_repository_impl.dart';
import '../../data/repositories/home/home_repository_impl.dart';
import '../../domain/repositories/board_repository.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/usecases/board/delete_board.dart';
import '../../domain/usecases/board/get_board.dart';
import '../../domain/usecases/board/update_board.dart';
import '../../domain/usecases/home/create_board.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final firebaseService = ref.watch(firebaseServiceProvider);
  return HomeRepositoryImpl(firebaseService: firebaseService);
});

final boardsRepositoryProvider = Provider<BoardRepository>((ref) {
  final firebaseService = ref.watch(firebaseServiceProvider);
  return BoardRepositoryImpl(firebaseService: firebaseService);
});

final createBoardProvider = Provider<CreateBoard>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return CreateBoard(homeRepository: homeRepository);
});

final getBoardsProvider = Provider<GetBoards>(
    (ref) => GetBoards(boardsRepository: ref.watch(boardsRepositoryProvider)));

final getBoardProvider = Provider<GetBoard>((ref) {
  final boardRepository = ref.watch(boardsRepositoryProvider);
  return GetBoard(boardRepository: boardRepository);
});

final updateBoardProvider = Provider<UpdateBoard>((ref) {
  final boardRepository = ref.watch(boardsRepositoryProvider);
  return UpdateBoard(boardRepository: boardRepository);
});

final deleteBoardProvider = Provider<DeleteBoard>((ref) {
  final boardRepository = ref.watch(boardsRepositoryProvider);
  return DeleteBoard(boardRepository: boardRepository);
});
