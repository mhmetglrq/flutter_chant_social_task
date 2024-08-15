import 'package:flutter_chant_social_task/features/domain/usecases/boards/get_boards.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data_sources/cloud/firebase_service.dart';
import '../../data/repositories/boards/boards_repository_impl.dart';
import '../../data/repositories/home/home_repository_impl.dart';
import '../../domain/repositories/boards_repository.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/usecases/home/create_board.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final firebaseService = ref.watch(firebaseServiceProvider);
  return HomeRepositoryImpl(firebaseService: firebaseService);
});

final boardsRepositoryProvider = Provider<BoardsRepository>((ref) {
  final firebaseService = ref.watch(firebaseServiceProvider);
  return BoardsRepositoryImpl(firebaseService: firebaseService);
});

final createBoardProvider = Provider<CreateBoard>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return CreateBoard(homeRepository: homeRepository);
});

final getBoardsProvider = Provider<GetBoards>(
    (ref) => GetBoards(boardsRepository: ref.watch(boardsRepositoryProvider)));
