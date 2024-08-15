import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_chant_social_task/config/extensions/context_extension.dart';
import 'package:flutter_chant_social_task/config/routes/route_names.dart';
import 'package:flutter_chant_social_task/config/utility/enum/image_enum.dart';
import 'package:flutter_chant_social_task/features/data/models/board_model.dart';
import 'package:flutter_chant_social_task/features/domain/entities/board_entity.dart';
import 'package:flutter_chant_social_task/features/domain/usecases/board/get_board.dart';
import 'package:flutter_chant_social_task/features/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/resources/data_state.dart';
import '../../domain/usecases/board/delete_board.dart';
import '../../domain/usecases/board/update_board.dart';

class Board extends StatefulWidget {
  const Board({super.key, required this.boardUid});
  final String boardUid;

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  Box userSettings = Hive.box("userSettings");
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentUser = userSettings.get("name");
        return StreamBuilder<BoardEntity>(
          stream: ref
              .watch(getBoardProvider)
              .call(params: GetBoardParams(uid: widget.boardUid)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              BoardModel board = BoardModel.fromEntity(snapshot.data!);

              Future.delayed(const Duration(seconds: 1), () async {
                if (board.status == "Finished") {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Tebrikler!"),
                        content: Text("${board.winner} kazandı!"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                RouteNames.bottomNavBar,
                                (route) => false,
                              ); // Dialog'u kapat
                            },
                            child: const Text("Tamam"),
                          ),
                        ],
                      );
                    },
                  );
                }
              });
              return PopScope(
                onPopInvokedWithResult: (didPop, result) async {
                  if (didPop) {
                    final dataState = await ref.watch(deleteBoardProvider).call(
                        params: DeleteBoardParams(boardId: widget.boardUid));
                    if (dataState is DataSuccess) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouteNames.bottomNavBar,
                        (route) => false,
                      );
                    }
                  }
                },
                child: Scaffold(
                  appBar: AppBar(),
                  body: SafeArea(
                    child: Padding(
                      padding: context.paddingAllDefault,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: context.paddingVerticalDefault,
                            child: Column(
                              children: [
                                Text(
                                  "${board.createdBy}",
                                  style: context.textTheme.labelMedium,
                                ),
                                Padding(
                                  padding: context.paddingVerticalLow,
                                  child: SvgPicture.asset(
                                      ImageEnum.firstPlayer.toSvg),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            color: Color(int.tryParse(board.color) ?? 0),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: GridView.builder(
                                itemCount: 9,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                                itemBuilder: (context, index) {
                                  final cell = board.moves?[index];

                                  return GestureDetector(
                                    onTap: (board.currentTurn == currentUser) &&
                                            (board.opponent != null) &&
                                            (board.status != "Finished")
                                        ? () async {
                                            if (cell == null || cell == "") {
                                              String currentMove =
                                                  currentUser == board.createdBy
                                                      ? "x"
                                                      : "o";

                                              board.moves?[index] = currentMove;

                                              var newBoard = board.copyWith(
                                                moves: board.moves,
                                                currentTurn: currentUser ==
                                                        board.createdBy
                                                    ? board.opponent
                                                    : board.createdBy,
                                              );
                                              final dataState = await ref
                                                  .watch(updateBoardProvider)
                                                  .call(
                                                    params: UpdateBoardParams(
                                                      board: newBoard,
                                                    ),
                                                  );
                                              bool isWin = checkWinner(
                                                  board.moves!, currentMove);
                                              bool isDraw =
                                                  checkDraw(board.moves!);
                                              if (dataState is DataSuccess) {
                                                if (isWin) {
                                                  var winnerBoard =
                                                      newBoard.copyWith(
                                                    winner: currentUser,
                                                    status: "Finished",
                                                  );
                                                  final winnerState = await ref
                                                      .watch(
                                                          updateBoardProvider)
                                                      .call(
                                                        params:
                                                            UpdateBoardParams(
                                                          board: winnerBoard,
                                                        ),
                                                      );
                                                } else if (isDraw) {
                                                  var drawBoard =
                                                      newBoard.copyWith(
                                                    moves: [
                                                      "",
                                                      "",
                                                      "",
                                                      "",
                                                      "",
                                                      "",
                                                      "",
                                                      "",
                                                      "",
                                                    ],
                                                  );
                                                  final drawState = await ref
                                                      .watch(
                                                          updateBoardProvider)
                                                      .call(
                                                        params:
                                                            UpdateBoardParams(
                                                          board: drawBoard,
                                                        ),
                                                      );
                                                }
                                              } else if (dataState
                                                  is DataFailed) {
                                                log(dataState.exception
                                                    .toString());
                                              }
                                            }
                                          }
                                        : () {
                                            log("sıra sende değil");
                                          },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                      ),
                                      child: Center(
                                        child: cell == "x"
                                            ? SvgPicture.asset(
                                                ImageEnum.firstPlayer.toSvg,
                                                height:
                                                    context.dynamicHeight(0.1),
                                              )
                                            : cell == "o"
                                                ? SvgPicture.asset(
                                                    ImageEnum
                                                        .secondPlayer.toSvg,
                                                    height: context
                                                        .dynamicHeight(0.1),
                                                  )
                                                : null,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: context.paddingVerticalDefault,
                            child: Column(
                              children: [
                                Text(
                                  board.opponent ?? "Nobody yet :(",
                                  style: context.textTheme.labelMedium,
                                ),
                                Padding(
                                  padding: context.paddingVerticalLow,
                                  child: SvgPicture.asset(
                                      ImageEnum.secondPlayer.toSvg),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return const Center(
              child: Text("Error"),
            );
          },
        );
      },
    );
  }

  bool checkWinner(List<dynamic> board, String currentMove) {
    // Tahtanın boyutunu hesapla (örneğin, 3x3 için 3)
    int gridSize =
        3; // Burayı dinamik yapmak isterseniz board boyutuna göre belirleyin.

    // Yatay Kontrol
    for (int i = 0; i < gridSize; i++) {
      if (board[i * gridSize] == currentMove &&
          board[i * gridSize + 1] == currentMove &&
          board[i * gridSize + 2] == currentMove) {
        return true;
      }
    }

    // Dikey Kontrol
    for (int i = 0; i < gridSize; i++) {
      if (board[i] == currentMove &&
          board[i + gridSize] == currentMove &&
          board[i + 2 * gridSize] == currentMove) {
        return true;
      }
    }

    // Çapraz Kontrol (Sol üstten sağ alta)
    if (board[0] == currentMove &&
        board[gridSize + 1] == currentMove &&
        board[2 * gridSize + 2] == currentMove) {
      return true;
    }

    // Çapraz Kontrol (Sağ üstten sol alta)
    if (board[gridSize - 1] == currentMove &&
        board[gridSize - 1 + gridSize - 1] == currentMove &&
        board[gridSize - 1 + 2 * (gridSize - 1)] == currentMove) {
      return true;
    }

    // Eğer hiçbiri kazanmadıysa, false döndür
    return false;
  }

  bool checkDraw(List<dynamic> board) {
    return board.every((cell) => cell != null && cell.isNotEmpty);
  }
}
