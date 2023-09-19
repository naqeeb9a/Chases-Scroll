import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/app_bar.dart';

class SuggestionFriendMore extends StatefulWidget {
  const SuggestionFriendMore({super.key});

  @override
  State<SuggestionFriendMore> createState() => _SuggestionFriendMoreState();
}

class _SuggestionFriendMoreState extends State<SuggestionFriendMore> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: appBar(
        title: "Suggestions",
        appBarActionWidget: SvgPicture.asset(
          AppImages.suggestionGrid,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: PAD_ALL_GENERAL,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  height: height,
                  width: width,
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      //res.Content? content = state.content[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 15),
                        padding: PAD_ALL_10,
                        color: AppColors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(40),
                                      bottomRight: Radius.circular(40),
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(0),
                                    ),
                                    color: Colors.grey.shade300,
                                    // image: DecorationImage(
                                    //   fit: BoxFit.cover,
                                    //   image: NetworkImage(content!
                                    //               .data!.imgMain ==
                                    //           null
                                    //       ? ""
                                    //       : "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${content.data!.imgMain!.value.toString()}"),
                                    // ),
                                  ),
                                ),
                                widthSpace(2),
                                Container(
                                  width: width / 2.4,
                                  //color: Colors.amber,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      customText(
                                          text: "Dami GGod",
                                          fontSize: 12,
                                          textColor: AppColors.black,
                                          fontWeight: FontWeight.w700),
                                      customText(
                                          text: "Shared Affilations",
                                          fontSize: 11,
                                          textColor: AppColors.searchTextGrey,
                                          fontWeight: FontWeight.w400),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                ChasescrollButton(
                                  hasIcon: false,
                                  iconWidget:
                                      SvgPicture.asset(AppImages.appleIcon),
                                  buttonText: "Connect",
                                  hasBorder: false,
                                  borderColor: AppColors.grey,
                                  textColor: AppColors.white,
                                  color: AppColors.deepPrimary,
                                  height: 30,
                                  width: 90,
                                ),
                                widthSpace(1.8),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.red.withOpacity(0.1)),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.cancel_outlined,
                                        size: 20,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
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
