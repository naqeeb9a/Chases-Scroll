import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/screens/profile_view/widgets/icon_row_profile.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SuggestionView extends StatefulWidget {
  final ContentUser? users;
  final Function()? function;
  final Function()? blockfunction;

  const SuggestionView(
      {super.key, this.users, this.function, this.blockfunction});

  @override
  State<SuggestionView> createState() => _SuggestionViewState();
}

class _SuggestionViewState extends State<SuggestionView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 10, 13),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 160,
          decoration: BoxDecoration(
            border: Border.all(width: 0.3, color: Colors.grey.shade300),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
              topLeft: Radius.circular(40),
              topRight: Radius.circular(0),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: PopupMenuButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    position: PopupMenuPosition.under,
                    color: Colors.white,
                    child: Container(
                      child: const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.more_horiz_outlined,
                            size: 30,
                          )),
                    ),
                    itemBuilder: (ctx) => [
                      buildPopupMenuItem2(
                        'Block User',
                        AppColors.black,
                        function: widget.blockfunction,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.push(AppRoutes.otherUsersProfile,
                        extra: widget.users!.userId);
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Container(
                          height: 6.h,
                          width: 15.w,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(0),
                            ),
                            border: Border.all(color: AppColors.primary),
                            color: Colors.grey.shade100,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget
                                  .users!.data!.imgMain!.value
                                  .toString()),
                            ),
                          ),
                          child: Center(
                            child: customText(
                                text: widget.users!.data!.imgMain!.value == null
                                    ? widget.users!.firstName!.isEmpty
                                        ? ""
                                        : "${widget.users!.firstName![0]}${widget.users!.lastName![0]}"
                                            .toUpperCase()
                                    : "",
                                fontSize: 14,
                                textColor: AppColors.deepPrimary,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      customText(
                          text: "${widget.users!.firstName}",
                          fontSize: 12,
                          textColor: AppColors.primary,
                          fontWeight: FontWeight.w500),
                      heightSpace(0.3),
                      customText(
                          text: "Shared Affilations",
                          fontSize: 12,
                          textColor: AppColors.textGrey,
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 9.0, right: 15, left: 15),
                  child: ChasescrollButtonChanges(
                    hasIcon: false,
                    iconWidget: SvgPicture.asset(AppImages.appleIcon),
                    buttonText: widget.users!.joinStatus == "CONNECTED"
                        ? "Disconnect"
                        : widget.users!.joinStatus == "NOT_CONNECTED"
                            ? "Connect"
                            : widget.users!.joinStatus == "FRIEND_REQUEST_SENT"
                                ? "Pending"
                                : "",
                    hasBorder: true,
                    borderColor: widget.users!.joinStatus == "NOT_CONNECTED"
                        ? AppColors.primary
                        : AppColors.white,
                    textColor: widget.users!.joinStatus == "FRIEND_REQUEST_SENT"
                        ? AppColors.btnOrange
                        : AppColors.primary,
                    height: 4.h,
                    color: widget.users!.joinStatus == "FRIEND_REQUEST_SENT"
                        ? AppColors.btnOrange.withOpacity(0.3)
                        : widget.users!.joinStatus == "CONNECTED"
                            ? AppColors.red
                            : AppColors.white,
                    width: 28.w,
                    onTap: widget.function,
                  ),
                ),
                // connectToFriendRequestFunction(
                //         content.userId ?? "", content.username ?? "");
              ],
            ),
          ),
        ),
      ),
    );
  }
}
