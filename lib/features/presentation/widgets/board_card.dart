// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_chant_social_task/config/extensions/context_extension.dart';

import '../../../config/items/colors/app_colors.dart';
import '../../../config/utility/enum/image_enum.dart';
import '../../data/models/board_model.dart';

class BoardCard extends StatelessWidget {
  const BoardCard({
    super.key,
    required this.item,
    this.onTap,
  });

  final BoardModel? item;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingVerticalLow,
      child: GestureDetector(
        onTap: onTap,
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
                  Text(
                    "${item?.status}",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: context.dynamicHeight(0.015),
                    ),
                  ),
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
                          color: AppColors.cardColor.withOpacity(0.5),
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
                    "${item?.name}",
                    style: context.textTheme.labelMedium,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        item?.opponent == null ? "1 / 2" : "2 / 2",
                        style: context.textTheme.bodyMedium?.copyWith(
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
      ),
    );
  }
}
