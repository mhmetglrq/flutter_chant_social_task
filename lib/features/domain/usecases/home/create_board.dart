// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_chant_social_task/core/usecase/usecase.dart';
import 'package:flutter_chant_social_task/features/domain/entities/board_entity.dart';

import '../../../../core/resources/data_state.dart';
import '../../repositories/home_repository.dart';

class CreateBoard implements UseCase<DataState<String>, CreateBoardParams> {
  HomeRepository homeRepository;
  CreateBoard({
    required this.homeRepository,
  });
  @override
  Future<DataState<String>> call({CreateBoardParams? params}) {
    return homeRepository.createBoard(params!.boardEntity);
  }
}

class CreateBoardParams {
  final BoardEntity boardEntity;

  CreateBoardParams({
    required this.boardEntity,
  });
}
