import 'package:chases_scroll/src/screens/event_screens/event_main_view.dart';
import 'package:chases_scroll/src/screens/expore_screens/explore_main_view.dart';
import 'package:chases_scroll/src/screens/home/home.dart';
import 'package:chases_scroll/src/screens/profile_view/user_profile_view.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/helpers/extract_first_letter.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/images.dart';

containerWithShape({required String assetName, required String text}) =>
    Container(
      height: 40,
      width: 110,
      decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            topRight: Radius.circular(0),
          )),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.asset(
          assetName,
          color: AppColors.white,
          width: 15,
          height: 15,
        ),
        widthSpace(1),
        customText(text: text, fontSize: 11, textColor: AppColors.white)
      ]),
    );

containerWithShapeProfile({String? assetName, required String text}) =>
    Container(
        height: 40,
        width: 70,
        decoration: BoxDecoration(
            color: AppColors.primary,
            border: Border.all(color: AppColors.white),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(0),
            )),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          assetName == null
              ? containerWithShapeProfile(text: extractFirstLetters(text))
              : SvgPicture.asset(
                  assetName,
                  color: AppColors.white,
                ),
          widthSpace(3),
          customText(text: "You", fontSize: 12, textColor: AppColors.white)
        ]));

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  final List<Widget> _widgets = [
    const HomeScreen(),
    const ExploreMainView(),
    const EventMainView(),
    const UserMainProfileView(),
    const Center(
      child: Text("Option 5"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgets.elementAt(selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: selectedIndex == 0
                  ? containerWithShape(
                      assetName: AppImages.homeIcon, text: "Home")
                  : SvgPicture.asset(AppImages.homeIcon,
                      color: AppColors.black),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: selectedIndex == 1
                  ? containerWithShape(
                      assetName: AppImages.searchIcon, text: "Explore")
                  : SvgPicture.asset(AppImages.searchIcon,
                      color: AppColors.black),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: selectedIndex == 2
                  ? containerWithShape(
                      assetName: AppImages.calendarIcon, text: "Event")
                  : SvgPicture.asset(
                      AppImages.calendarIcon,
                    ),
              label: '',
            ),
            BottomNavigationBarItem(
                icon: selectedIndex == 3
                    ? containerWithShape(
                        assetName: AppImages.userIcon, text: "Community")
                    : SvgPicture.asset(
                        AppImages.userIcon,
                        color: AppColors.black,
                      ),
                label: ""),
            BottomNavigationBarItem(
                icon: selectedIndex == 4
                    ? containerWithShapeProfile(text: "Samuel Clifford")
                    : Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primary),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(0),
                            )),
                        child: Center(
                          child: customText(
                              text: extractFirstLetters("Samuel Cliffy"),
                              fontSize: 12,
                              textColor: AppColors.primary),
                        )),
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
