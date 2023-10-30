import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/screens/community/request_community.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'find_community.dart';
import 'my_community.dart';

class Community extends StatelessWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () => context.push(AppRoutes.createCommunity),
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset(
                  AppImages.community,
                  color: AppColors.primary,
                ),
              ),
            )
          ],
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: customText(
              text: "Community", fontSize: 15, textColor: AppColors.black),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Container(
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    AppTextFormField(
                      prefixIcon: SvgPicture.asset(AppImages.search),
                      hintText: "Search for Communities",
                      hasBorder: true,
                    ),
                    TabBar(
                        indicator: const BoxDecoration(),
                        unselectedLabelColor: AppColors.textGrey,
                        labelColor: AppColors.primary,
                        labelStyle: GoogleFonts.dmSans(
                          textStyle: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                        tabs: const [
                          Tab(
                            text: "My Community",
                          ),
                          Tab(
                            text: "Find Community",
                          ),
                          Tab(
                            text: "Requests",
                          )
                        ]),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            heightSpace(2),
            const Expanded(
              child: TabBarView(children: [
                MyCommunity(),
                FindCommunity(),
                RequestCommunity()
              ]),
            )
          ]),
        ),
      ),
    );
  }
}
