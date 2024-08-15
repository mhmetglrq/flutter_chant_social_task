import 'package:flutter/material.dart';
import 'package:flutter_chant_social_task/config/extensions/context_extension.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../config/items/colors/app_colors.dart';
import '../views/boards.dart';
import '../views/home.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List _children = <Widget>[
    const Home(),
    const Boards(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        backgroundColor: AppColors.cardColor,
        duration: const Duration(milliseconds: 200),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        curve: Curves.linear,
        selectedColorOpacity: 1,
        unselectedItemColor: AppColors.unSelectedColor,
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home, color: AppColors.whiteColor),
            title: Text(
              "Home",
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.selectedColor,
              ),
            ),
            selectedColor: AppColors.selectedBackgroundColor.withOpacity(0.6),
          ),
          SalomonBottomBarItem(
            icon:
                const Icon(Icons.gamepad_rounded, color: AppColors.whiteColor),
            title: Text(
              "Boards",
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.selectedColor,
              ),
            ),
            selectedColor: AppColors.selectedBackgroundColor.withOpacity(0.6),
          ),
        ],
      ),
    );
  }
}
