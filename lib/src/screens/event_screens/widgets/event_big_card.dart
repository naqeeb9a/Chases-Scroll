import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/helpers/strings.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../../widgets/custom_fonts.dart';

class EventBigCard extends StatefulWidget {
  final double? width;

  final String? eventName;
  final String? image;
  final String? date;
  final String? location;
  final double? price;
  final EventContent? eventDetails;
  final Function()? onSaved;
  final bool? isSaved;

  const EventBigCard(
    this.width, {
    super.key,
    this.eventName,
    this.image,
    this.date,
    this.location,
    this.price,
    this.eventDetails,
    this.onSaved,
    this.isSaved,
  });

  @override
  State<EventBigCard> createState() => _EventBigCardState();
}

class _EventBigCardState extends State<EventBigCard> {
  @override
  Widget build(BuildContext context) {
    bool isSaved = false;
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.eventDetailMainView, extra: widget.eventDetails);
      },
      child: Container(
        padding: PAD_ALL_10,
        margin: const EdgeInsets.only(bottom: 10, right: 8),
        width: widget.width,
        decoration: BoxDecoration(
          border: Border.all(width: 0.2, color: Colors.grey.shade200),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(35),
            bottomRight: Radius.circular(35),
            topLeft: Radius.circular(35),
            topRight: Radius.circular(0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 6.0,
              spreadRadius: 0.2,
              offset: const Offset(0.7, 0.7),
            )
          ],
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.3, color: Colors.grey.shade300),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: PAD_ALL_10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              customText(
                                text: widget.date.toString(),
                                fontSize: 11,
                                textColor: AppColors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            heightSpace(0.5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        //color: Colors.cyan,
                        child: customText(
                            text: widget.eventName.toString(),
                            fontSize: 12,
                            textColor: AppColors.black,
                            fontWeight: FontWeight.w700,
                            lines: 1),
                      ),
                    ),
                    widthSpace(1.5),
                    widget.eventDetails!.currency == "USD"
                        ? customText(
                            text: "\$${widget.price}",
                            fontSize: 13,
                            textColor: AppColors.deepPrimary,
                            fontWeight: FontWeight.w500,
                          )
                        : Text(
                            "$naira${widget.price}",
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              color: AppColors.deepPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ],
                ),
                heightSpace(0.8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.place_rounded,
                      size: 15,
                      color: Colors.grey.shade400,
                    ),
                    widthSpace(1),
                    Flexible(
                      child: customText(
                        text: widget.location.toString(),
                        fontSize: 12,
                        textColor: AppColors.searchTextGrey,
                        fontWeight: FontWeight.w400,
                        lines: 1,
                      ),
                    ),
                  ],
                ),
                heightSpace(0.8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: widget.eventDetails!.interestedUsers!.length < 2
                          ? 1
                          : widget.eventDetails!.interestedUsers!.length < 3
                              ? 2
                              : 3,
                      child: SizedBox(
                        // color: Colors.amber,
                        height: 30,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              widget.eventDetails!.interestedUsers!.length < 3
                                  ? widget.eventDetails!.interestedUsers!.length
                                  : 3, // Replace with your actual item count
                          itemBuilder: (context, index) {
                            InterestedUsers indiv =
                                widget.eventDetails!.interestedUsers![index];
                            // Replace this with your actual list item widget
                            return Container(
                              width: 8.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.primary.withOpacity(0.3),
                                image: DecorationImage(
                                  scale: 1.0,
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${indiv.data!.imgMain!.value}"),
                                ),
                              ),
                              child: Visibility(
                                  child: Center(
                                child: customText(
                                  text:
                                      "${indiv.firstName![0]}${indiv.lastName![0]}"
                                          .toUpperCase(),
                                  fontSize: 10,
                                  textColor: AppColors.deepPrimary,
                                ),
                              )),
                            );
                          },
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 30,
                    //   width: 80,
                    //   child: Stack(
                    //     children: [
                    //       Positioned(
                    //         top: 0,
                    //         left: 0,
                    //         child: Container(
                    //           width: 6.w,
                    //           height: 3.h,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(30),
                    //             color: Colors.blue,
                    //           ),
                    //         ),
                    //       ),
                    //       Positioned(
                    //         left: 15,
                    //         child: Container(
                    //           width: 6.w,
                    //           height: 3.h,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(30),
                    //             color: Colors.green,
                    //           ),
                    //         ),
                    //       ),
                    //       Positioned(
                    //         left: 30,
                    //         child: Container(
                    //           width: 6.w,
                    //           height: 3.h,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(30),
                    //             color: Colors.orange,
                    //           ),
                    //         ),
                    //       ),
                    //       Positioned(
                    //         left: 45,
                    //         child: Container(
                    //           width: 6.w,
                    //           height: 3.h,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(30),
                    //             color: AppColors.deepPrimary,
                    //           ),
                    //           child: Center(
                    //             child: customText(
                    //               text: "+${widget.eventDetails!.memberCount}",
                    //               fontSize: 9,
                    //               textColor: AppColors.white,
                    //               fontWeight: FontWeight.w500,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Container(
                      width: 8.w,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.deepPrimary,
                      ),
                      child: Center(
                        child: customText(
                          text: "+${widget.eventDetails!.memberCount}",
                          fontSize: 9,
                          textColor: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      child: customText(
                        text: "Interested",
                        fontSize: 12,
                        textColor: AppColors.deepPrimary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              String text =
                                  "https://chasescroll-new.netlify.app/events/${widget.eventDetails!.id}";

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
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
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
                          GestureDetector(
                            onTap: widget.onSaved,
                            child: Container(
                              child: widget.eventDetails!.isSaved == true
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
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
