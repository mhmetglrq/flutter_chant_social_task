import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data_sources/cloud/firebase_service.dart';
import '../../data/repositories/home/home_repository_impl.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/usecases/home/create_board.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final firebaseService = ref.watch(firebaseServiceProvider);
  return HomeRepositoryImpl(firebaseService: firebaseService);
});

final createBoardRepositoryProvider = Provider<CreateBoard>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return CreateBoard(homeRepository: homeRepository);
});
