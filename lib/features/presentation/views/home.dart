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

class _HomeState extends State<Home> {
  final TextEditingController _codeController = TextEditingController();

  Box userSettings = Hive.box('userSettings');
  // Color for the picker shown in Card on the screen.
  late Color screenPickerColor;
  // Color for the picker in a dialog using onChanged.
  late Color dialogPickerColor;
  // Color for picker using the color select dialog.
  late Color dialogSelectColor;
  // Define custom colors. The 'guide' color values are from
  // https://material.io/design/color/the-color-system.html#color-theme-creation
  static const Color guidePrimary = Color(0xFF6200EE);
  static const Color guidePrimaryVariant = Color(0xFF3700B3);
  static const Color guideSecondary = Color(0xFF03DAC6);
  static const Color guideSecondaryVariant = Color(0xFF018786);
  static const Color guideError = Color(0xFFB00020);
  static const Color guideErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);

  // Make a custom ColorSwatch to name map from the above custom colors.
  final Map<ColorSwatch<Object>, String> colorsNameMap =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guidePrimaryVariant): 'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideSecondaryVariant): 'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
  };

  @override
  void initState() {
    super.initState();
    screenPickerColor = Colors.blue; // Material blue.
    dialogPickerColor = Colors.red; // Material red.
    dialogSelectColor = const Color(0xFFA239CA); // A purple color.
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  //?TODO: Join game not include in the design
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: context.paddingAllDefault,
            child: Column(
              children: [
                Padding(
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
                ),
                Padding(
                  padding: context.paddingVerticalHigh,
                  child: SvgPicture.asset(ImageEnum.ticTacToe.toSvg),
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
                            controller: _codeController,
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
                            log("Create game");
                            final uid = const Uuid().v4();
                            int testingColorValue = dialogPickerColor.value;
                            String testingColorString =
                                testingColorValue.toString();

                            final currentUser = userSettings.get("name");

                            BoardModel board = BoardModel(
                              name: _codeController.text,
                              color: testingColorString,
                              createdAt: Timestamp.fromDate(DateTime.now()),
                              createdBy: currentUser,
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
                              currentTurn: currentUser,
                            );
                            CreateBoardParams params = CreateBoardParams(
                              boardEntity: board,
                            );
                            final dataState =
                                await ref.read(createBoardProvider).call(
                                      params: params,
                                    );
                            if (dataState is DataSuccess) {
                              _codeController.clear();
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

  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      // Use the dialogPickerColor as start and active color.
      color: dialogPickerColor,
      // Update the dialogPickerColor using the callback.
      onColorChanged: (Color color) =>
          setState(() => dialogPickerColor = color),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
      customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      // New in version 3.0.0 custom transitions support.
      transitionBuilder: (BuildContext context, Animation<double> a1,
          Animation<double> a2, Widget widget) {
        final double curvedValue =
            Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: widget,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
      constraints:
          const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
    );
  }
}
