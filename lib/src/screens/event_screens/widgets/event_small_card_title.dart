import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/images.dart';
import '../../widgets/custom_fonts.dart';

class EventSmallTitleCard extends StatefulWidget {
  const EventSmallTitleCard({
    super.key,
  });

  @override
  State<EventSmallTitleCard> createState() => _EventSmallTitleCardState();
}

class _EventSmallTitleCardState extends State<EventSmallTitleCard> {
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
                          Flexible(
                            child: customText(
                                text: "Event Name Here  Name Here",
                                fontSize: 14,
                                textColor: AppColors.black,
                                fontWeight: FontWeight.w500,
                                lines: 1),
                          ),
                          widthSpace(1),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.place_rounded,
                            size: 15,
                            color: AppColors.deepPrimary,
                          ),
                          widthSpace(1),
                          Flexible(
                            child: customText(
                              text:
                                  "Event location here location here location here",
                              fontSize: 12,
                              textColor: AppColors.deepPrimary,
                              fontWeight: FontWeight.w500,
                              lines: 1,
                            ),
                          ),
                        ],
                      ),
                      heightSpace(0.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customText(
                                    text: "Category: ",
                                    fontSize: 11,
                                    textColor: AppColors.searchTextGrey,
                                    fontWeight: FontWeight.w500),
                                Expanded(
                                  child: customText(
                                      text: "Event category Now Location",
                                      fontSize: 11,
                                      textColor: AppColors.deepPrimary,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          widthSpace(1.3),
                          Container(
                            padding: PAD_ALL_8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: AppColors.backgroundGrey),
                            child: customText(
                                text: "Organiser",
                                fontSize: 11,
                                textColor: AppColors.deepPrimary,
                                fontWeight: FontWeight.w700),
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
