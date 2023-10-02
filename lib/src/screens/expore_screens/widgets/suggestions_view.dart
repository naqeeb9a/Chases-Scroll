import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuggestionView extends StatefulWidget {
  final Content? users;
  final Function()? function;

  const SuggestionView({super.key, this.users, this.function});

  @override
  State<SuggestionView> createState() => _SuggestionViewState();
}

class _SuggestionViewState extends State<SuggestionView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 10, 13),
      child: GestureDetector(
        onTap: () {
          // prof.getProfileDetials(userID: content.userId);
          // Future.delayed(const Duration(milliseconds: 600), () {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) =>
          //           UserConnectProfilePageScreenView(userID: content.userId),
          //     ),
          //   );
          // });
        },
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
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                        image: NetworkImage(
                            "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${widget.users!.data!.imgMain!.value.toString()}"),
                      ),
                    ),
                    child: Center(
                      child: customText(
                          text: widget.users!.data!.imgMain!.objectPublic ==
                                  false
                              ? widget.users!.firstName!.isEmpty
                                  ? ""
                                  : "${widget.users!.firstName![0]}${widget.users!.lastName![0]}"
                              : "",
                          fontSize: 14,
                          textColor: AppColors.deepPrimary,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                customText(
                    text: "${widget.users!.firstName}",
                    fontSize: 12,
                    textColor: AppColors.primary,
                    fontWeight: FontWeight.w500),
                heightSpace(0.7),
                customText(
                    text: "Shared Affilations",
                    fontSize: 12,
                    textColor: AppColors.lightGrey,
                    fontWeight: FontWeight.w400),
                Padding(
                  padding: const EdgeInsets.only(top: 9.0, right: 15, left: 15),
                  child: ChasescrollButton(
                    hasIcon: false,
                    iconWidget: SvgPicture.asset(AppImages.appleIcon),
                    buttonText: widget.users!.joinStatus == "CONNECTED"
                        ? "Connected"
                        : widget.users!.joinStatus == "NOT_CONNECTED"
                            ? "Connect"
                            : widget.users!.joinStatus == "FRIEND_REQUEST_SENT"
                                ? "Pending"
                                : "",
                    hasBorder: false,
                    borderColor: AppColors.grey,
                    textColor: AppColors.white,
                    height: 4.h,
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
