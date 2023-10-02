import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/images.dart';
import '../../widgets/custom_fonts.dart';

class EventSmallCard extends HookWidget {
  const EventSmallCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: PAD_ALL_10,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  //       "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${widget.image}"),
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
                                text: "Event Name Here",
                                fontSize: 14,
                                textColor: AppColors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          customText(
                              text: "\$2000.0",
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
                              text: "11:03 AM January 3, 2023",
                              fontSize: 12,
                              textColor: AppColors.searchTextGrey,
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                      heightSpace(0.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      text: "Location Right Now",
                                      fontSize: 11,
                                      textColor: AppColors.primary,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  child: SvgPicture.asset(
                                    AppImages.bookmark,
                                    height: 2.3.h,
                                    width: 2.3.w,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
