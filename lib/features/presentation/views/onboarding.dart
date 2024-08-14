import 'package:flutter/material.dart';
import 'package:flutter_chant_social_task/config/extensions/context_extension.dart';
import 'package:flutter_chant_social_task/config/items/colors/app_colors.dart';
import 'package:flutter_chant_social_task/config/utility/enum/image_enum.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/routes/route_names.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: context.paddingAllDefault,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: context.paddingVerticalHigh,
                  child: Text(
                    "Tic Tac Toe\nBest Game Ever!",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.whiteColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SvgPicture.asset(
                  ImageEnum.ticTacToe.toSvg,
                ),
                Padding(
                  padding: context.paddingVerticalHigh,
                  child: Text(
                    "Please enter your name\nand fun begins",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.whiteColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: context.paddingVerticalLow,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.pinkColor.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(1, 8),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _nameController,
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
                  padding: context.paddingVerticalDefault,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: context.paddingTopDefault,
                        child: SvgPicture.asset(ImageEnum.arrow.toSvg),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.bottomNavBar);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                                colors: [
                                  AppColors.purpleColor,
                                  AppColors.darkPurpleColor,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            color: Colors.black,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: context.dynamicWidth(0.05),
                            vertical: context.dynamicHeight(0.015),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Start Gaming",
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                              Padding(
                                padding: context.paddingHorizontalLow,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.pinkColor,
                                        AppColors.pinkDarkColor,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: context.paddingAllLow,
                                    child: const Icon(
                                      Icons.arrow_forward_rounded,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
