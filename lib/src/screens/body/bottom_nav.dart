import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/images.dart';
import '../expore_screens/explore_main_view.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;
  final List<Widget> _widgets = [
    const Center(
      child: Text("Option 1"),
    ),
    const ExploreMainView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgets.elementAt(selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: selectedIndex == 0
                  ? SvgPicture.asset(
                      AppImages.homeIcon,
                      color: AppColors.black,
                    )
                  : SvgPicture.asset(AppImages.homeIcon,
                      color: AppColors.black),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: selectedIndex == 1
                  ? SvgPicture.asset(
                      AppImages.searchIcon,
                      color: AppColors.primary,
                    )
                  : SvgPicture.asset(AppImages.searchIcon,
                      color: AppColors.black),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: selectedIndex == 2
                  ? SvgPicture.asset(AppImages.calendarIcon,
                      color: AppColors.primary)
                  : SvgPicture.asset(
                      AppImages.calendarIcon,
                    ),
              label: '',
            ),
            BottomNavigationBarItem(
                icon: selectedIndex == 2
                    ? SvgPicture.asset(
                        AppImages.userIcon,
                        color: AppColors.primary,
                      )
                    : SvgPicture.asset(
                        AppImages.userIcon,
                        color: AppColors.black,
                      ),
                label: ""),
            BottomNavigationBarItem(
                icon: selectedIndex == 3
                    ? SvgPicture.asset(
                        AppImages.userIcon,
                        color: AppColors.primary,
                      )
                    : SvgPicture.asset(AppImages.userIcon),
                label: ""),
          ],
          currentIndex: selectedIndex,
          unselectedItemColor: AppColors.black,
          onTap: onItemTapped,
        ));
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
