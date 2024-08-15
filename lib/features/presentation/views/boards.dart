import 'package:flutter/material.dart';
import 'package:flutter_chant_social_task/config/extensions/context_extension.dart';
import 'package:flutter_chant_social_task/features/domain/entities/board_entity.dart';
import 'package:flutter_chant_social_task/features/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/items/colors/app_colors.dart';
import '../../data/models/board_model.dart';
import '../widgets/board_card.dart';

class Boards extends StatelessWidget {
  const Boards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: context.paddingAllDefault,
          child: Column(
            children: [
              Padding(
                padding: context.paddingVerticalLow,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Games 🎮",
                    style: context.textTheme.labelMedium?.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  return Expanded(
                    child: StreamBuilder<List<BoardEntity>>(
                      stream: ref.watch(getBoardsProvider).call(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          final boards = snapshot.data;
                          final List<BoardModel>? boardModels = boards
                              ?.map((e) => BoardModel.fromEntity(e))
                              .toList();
                          boardModels?.sort(
                              (a, b) => a.createdAt!.compareTo(b.createdAt!));
                          final sortedBoards = boardModels?.reversed.toList();
                          return ListView.builder(
                            itemCount: sortedBoards?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              final item = sortedBoards?[index];
                              return BoardCard(item: item);
                            },
                          );
                        } else {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        }
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
