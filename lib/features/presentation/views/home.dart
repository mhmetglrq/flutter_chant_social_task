import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chant_social_task/config/extensions/context_extension.dart';
import 'package:flutter_chant_social_task/config/items/colors/app_colors.dart';
import 'package:flutter_chant_social_task/config/routes/route_names.dart';
import 'package:flutter_chant_social_task/config/utility/enum/image_enum.dart';
import 'package:flutter_chant_social_task/core/resources/data_state.dart';
import 'package:flutter_chant_social_task/features/data/models/board_model.dart';
import 'package:flutter_chant_social_task/features/domain/usecases/home/create_board.dart';
import 'package:flutter_chant_social_task/features/presentation/mixins/home_mixin.dart';
import 'package:flutter_chant_social_task/features/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with HomeMixin {
  @override
  void initState() {
    super.initState();
    screenPickerColor = Colors.blue; // Material blue.
    dialogPickerColor = Colors.red; // Material red.
    dialogSelectColor = const Color(0xFFA239CA); // A purple color.
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: context.paddingAllDefault,
            child: Column(
              children: [
                _titleArea(context),
                Padding(
                  padding: context.paddingVerticalHigh,
                  child: SvgPicture.asset(
                    ImageEnum.ticTacToe.toSvg,
                    height: context.dynamicHeight(0.38),
                  ),
                ),
                Padding(
                  padding: context.paddingVerticalLow,
                  child: Row(
                    children: [
                      Text(
                        "Let's play ⚡",
                        style: context.textTheme.labelMedium?.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: context.paddingVerticalLow,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.cardColor.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: codeController,
                            decoration: InputDecoration(
                              hintText: "Enter game name",
                              hintStyle: context.textTheme.bodySmall?.copyWith(
                                color: AppColors.hintColor,
                              ),
                              fillColor: AppColors.cardColor,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: context.dynamicWidth(0.05),
                                vertical: context.dynamicHeight(0.015),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: context.paddingLeftLow,
                        child: ColorIndicator(
                          borderRadius: 10,
                          color: dialogPickerColor,
                          onSelectFocus: false,
                          onSelect: () async {
                            // Store current color before we open the dialog.
                            final Color colorBeforeDialog = dialogPickerColor;
                            // Wait for the picker to close, if dialog was dismissed,
                            // then restore the color we had before it was opened.
                            if (!(await colorPickerDialog())) {
                              setState(() {
                                dialogPickerColor = colorBeforeDialog;
                              });
                            }
                            log("Color: $dialogPickerColor");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return Padding(
                      padding: context.paddingVerticalLow,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blueColor.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(1, 1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          onPressed: () async {
                            final uid = const Uuid().v4();
                            int testingColorValue = dialogPickerColor.value;
                            String testingColorString =
                                testingColorValue.toString();

                            final currentUser = userSettings.get("name");

                            BoardModel board = BoardModel(
                              name: codeController.text,
                              color: testingColorString,
                              createdAt: Timestamp.fromDate(DateTime.now()),
                              createdBy: (currentUser == "" ||
                                      currentUser == null ||
                                      currentUser.isEmpty)
                                  ? "Unknown Player"
                                  : currentUser,
                              moves: const [
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
                              status: "Waiting",
                              uid: uid,
                              currentTurn: (currentUser == "" ||
                                      currentUser == null ||
                                      currentUser.isEmpty)
                                  ? "Unknown Player"
                                  : currentUser,
                            );
                            CreateBoardParams params = CreateBoardParams(
                              boardEntity: board,
                            );
                            final dataState =
                                await ref.read(createBoardProvider).call(
                                      params: params,
                                    );
                            if (dataState is DataSuccess) {
                              codeController.clear();
                              Navigator.pushNamed(context, RouteNames.board,
                                  arguments: {
                                    "boardUid": uid,
                                  });
                            } else {
                              log(dataState.data.toString());
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: AppColors.blueColor,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.dynamicWidth(0.05),
                              vertical: context.dynamicHeight(0.015),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: context.paddingHorizontalLow,
                                  child: SvgPicture.asset(
                                    ImageEnum.gameConsole.toSvg,
                                    height: context.dynamicHeight(0.03),
                                  ),
                                ),
                                Text(
                                  "Create Game",
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _titleArea(BuildContext context) {
    return Padding(
      padding: context.paddingVerticalLow,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.cardColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.cardColor.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.dynamicWidth(0.05),
            vertical: context.dynamicHeight(0.015),
          ),
          child: Text(
            "Tic Tac Toe",
            style: context.textTheme.titleMedium?.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
