import 'package:flutter/material.dart';
import 'package:flutter_chant_social_task/config/extensions/context_extension.dart';
import 'package:flutter_chant_social_task/config/items/colors/app_colors.dart';
import 'package:flutter_chant_social_task/config/utility/enum/image_enum.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _codeController = TextEditingController();
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
                        hintText: "Enter game code",
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
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () {},
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
                              "Game name",
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: context.paddingVerticalLow,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.pinkColor.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: AppColors.pinkColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.dynamicWidth(0.05),
                          vertical: context.dynamicHeight(0.015),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: context.paddingHorizontalLow,
                              child: SvgPicture.asset(
                                ImageEnum.play.toSvg,
                                height: context.dynamicHeight(0.03),
                              ),
                            ),
                            Text(
                              "Join Game",
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
