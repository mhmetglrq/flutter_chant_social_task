import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_chant_social_task/config/extensions/context_extension.dart';
import 'package:flutter_chant_social_task/core/resources/data_state.dart';
import 'package:flutter_chant_social_task/features/domain/entities/board_entity.dart';
import 'package:flutter_chant_social_task/features/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../config/items/colors/app_colors.dart';
import '../../data/models/board_model.dart';
import '../../domain/usecases/board/update_board.dart';
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
                        Box userSettings = Hive.box("userSettings");
                        var currentUser = userSettings.get("name");

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          final boards = snapshot.data;

                          boards?.sort(
                              (a, b) => a.createdAt!.compareTo(b.createdAt!));
                          final sortedBoards = boards?.reversed.toList();
                          if (boards == null || boards.isEmpty) {
                            return const Center(
                              child: Text("No games found"),
                            );
                          }
                          if (currentUser == null ||
                              currentUser.isEmpty ||
                              currentUser == "") {
                            return const Center(
                              child: Text("Please enter your name!"),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: sortedBoards?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                final item =
                                    BoardModel.fromEntity(sortedBoards![index]);
                                return BoardCard(
                                  item: item,
                                  onTap: () async {
                                    if (item.opponent == null &&
                                        item.opponent != currentUser &&
                                        item.status != "Finished") {
                                      if ((currentUser == "" ||
                                              currentUser == null ||
                                              currentUser.isEmpty) &&
                                          item.createdBy == "Unknown Player") {
                                        currentUser = "Unknown Player 2";
                                      }
                                      final updatedBoard = item.copyWith(
                                        opponent: currentUser,
                                      );

                                      final dataState = await ref
                                          .watch(updateBoardProvider)
                                          .call(
                                            params: UpdateBoardParams(
                                              board: updatedBoard,
                                            ),
                                          );
                                      if (dataState is DataSuccess) {
                                        Navigator.pushNamed(context, "/board",
                                            arguments: {
                                              "boardUid": item.uid,
                                            });
                                      }
                                    }
                                  },
                                );
                              },
                            );
                          }
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
