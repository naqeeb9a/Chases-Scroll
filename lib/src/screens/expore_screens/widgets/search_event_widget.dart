import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/dimens.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/constants/spacer.dart';
import '../../widgets/custom_fonts.dart';

class SearchEventWidget extends StatefulWidget {
  final String? eventName;
  final EventContent? event;
  final String? image;
  final String? date;
  final String? location;
  final double? price;
  final bool isSaved;
  final Function()? onSave;
  const SearchEventWidget({
    super.key,
    this.eventName,
    this.image,
    this.date,
    this.location,
    this.onSave,
    this.price,
    required this.isSaved,
    required this.event,
  });

  @override
  State<SearchEventWidget> createState() => _SearchEventWidgetState();
}

class _SearchEventWidgetState extends State<SearchEventWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.eventDetailMainView, extra: widget.event);
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
                        image: DecorationImage(
                          scale: 1.0,
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${widget.image}"),
                        ),
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
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: customText(
                                        text: widget.eventName.toString(),
                                        fontSize: 12,
                                        textColor: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                        lines: 2),
                                  ),
                                ),
                                customText(
                                    text: "\$${widget.price.toString()}",
                                    fontSize: 12,
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
                                    text: widget.date.toString(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            text: widget.location.toString(),
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
                                      onTap: () async {
                                        String text =
                                            "https://chasescroll-new.netlify.app/events/${widget.event!.id}";

                                        await Share.share(
                                          text,
                                          subject:
                                              'Check out this user profile from Chasescroll',
                                          sharePositionOrigin: Rect.fromCenter(
                                            center: const Offset(0, 0),
                                            width: 100,
                                            height: 100,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 0.0),
                                            child: SvgPicture.asset(
                                              AppImages.share,
                                              height: 2.7.h,
                                              width: 2.7.w,
                                              color: AppColors.deepPrimary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    widthSpace(4),
                                    GestureDetector(
                                      onTap: widget.onSave,
                                      child: Container(
                                        child: widget.isSaved == true
                                            ? SvgPicture.asset(
                                                AppImages.bookmarkFilled,
                                                height: 2.3.h,
                                                width: 2.3.w,
                                              )
                                            : SvgPicture.asset(
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
                    heightSpace(5),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
