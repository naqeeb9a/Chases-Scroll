import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/dimens.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/constants/spacer.dart';
import '../../widgets/custom_fonts.dart';

class SearchEventWidget extends StatelessWidget {
  const SearchEventWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => TicketDetails(
        //       events: _foundEvents[index],
        //     ),
        //   ),
        // );
      },
      child: Padding(
        padding: PAD_SYM_H10,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0, top: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 105,
                      width: 125,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(0),
                        ),
                        color: Colors.grey.shade200,
                        // image: DecorationImage(
                        //   scale: 1.0,
                        //   fit: BoxFit.fill,
                        //   image: NetworkImage(
                        //       "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/$image"),
                        // ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 5, 0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 150,
                                  //color: Colors.amber,
                                  child: customText(
                                      text: "MOHBAD RIP Concert",
                                      fontSize: 14,
                                      textColor: AppColors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                customText(
                                    text: "\$200",
                                    fontSize: 14,
                                    textColor: AppColors.black,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                            heightSpace(1),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  AppImages.calendarIcon,
                                  height: 15,
                                  width: 15,
                                ),
                                widthSpace(1),
                                customText(
                                    text: "Oct. 20 2023 at 09:00am",
                                    fontSize: 12,
                                    textColor: AppColors.searchTextGrey,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                            heightSpace(1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.location,
                                        height: 15,
                                        width: 15,
                                        color: AppColors.primary,
                                      ),
                                      widthSpace(1),
                                      Expanded(
                                        child: customText(
                                            text: "Eko Hotel & Suites",
                                            fontSize: 11,
                                            textColor: AppColors.primary,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppImages.bookmark,
                                      height: 15,
                                      width: 15,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    heightSpace(5),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
