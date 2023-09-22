import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuggestionView extends StatefulWidget {
  const SuggestionView({super.key});

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
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: Container(
                    height: 70,
                    width: 70,
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
                      //   image: NetworkImage(content.data!.imgMain == null
                      //       ? ""
                      //       : "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${content.data!.imgMain!.value.toString()}"),
                      // ),
                    ),
                  ),
                ),
                customText(
                    text: "Dami GGod",
                    fontSize: 12,
                    textColor: AppColors.primary,
                    fontWeight: FontWeight.w500),
                heightSpace(1),
                customText(
                    text: "Shared Affilations",
                    fontSize: 12,
                    textColor: AppColors.lightGrey,
                    fontWeight: FontWeight.w400),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, right: 15, left: 15),
                  child: ChasescrollButton(
                    hasIcon: false,
                    iconWidget: SvgPicture.asset(AppImages.appleIcon),
                    buttonText: "Connect",
                    hasBorder: false,
                    borderColor: AppColors.grey,
                    textColor: AppColors.white,
                    height: 40,
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

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    this.title,
    this.buttonColor,
    this.TextColor,
  });

  final String? title;
  final Color? buttonColor;
  final Color? TextColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // connectToFriendRequestFunction(
        //   content.userId ?? "",
        //   content.username ?? "",
        //   context,
        // );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.deepPrimary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          child: customText(
              text: "Connect",
              fontSize: 11,
              textColor: AppColors.white,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
