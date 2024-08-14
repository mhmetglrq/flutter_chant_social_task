import 'package:flutter/material.dart';
import 'package:flutter_chant_social_task/config/extensions/context_extension.dart';
import 'package:flutter_chant_social_task/config/utility/enum/image_enum.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/items/colors/app_colors.dart';

class Games extends StatelessWidget {
  const Games({super.key});

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
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: context.paddingVerticalLow,
                      child: Card(
                        color: AppColors.cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SvgPicture.asset(ImageEnum.buttonBg.toSvg),
                                const Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                            Padding(
                              padding: context.paddingAllLow,
                              child: ListTile(
                                minLeadingWidth: context.dynamicWidth(0.1),
                                contentPadding: context.paddingAllLow,
                                leading: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.scaffoldBackgroundColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.cardColor
                                            .withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  height: context.dynamicHeight(0.12),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: SvgPicture.asset(
                                      ImageEnum.ticTacToe.toSvg,
                                      // height: context.dynamicHeight(0.08),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  "Game $index",
                                  style: context.textTheme.labelMedium,
                                ),
                                trailing: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "1 / 2",
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                        color: AppColors.yellowColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
