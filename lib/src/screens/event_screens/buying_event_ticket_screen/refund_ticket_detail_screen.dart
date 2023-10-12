import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/helpers/strings.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class RefundTicketDetailScreen extends StatefulWidget {
  const RefundTicketDetailScreen({Key? key}) : super(key: key);

  @override
  State<RefundTicketDetailScreen> createState() =>
      _RefundTicketDetailScreenState();
}

class _RefundTicketDetailScreenState extends State<RefundTicketDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundSummaryScreen,
      body: SafeArea(
        child: SizedBox(
          height: height,
          width: width,
          child: Padding(
            padding: PAD_ALL_15,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customText(
                      text: "Ticket Details",
                      fontSize: 14,
                      textColor: AppColors.black,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: customText(
                        text: "Cancel Ticket",
                        fontSize: 14,
                        textColor: AppColors.red,
                      ),
                    ),
                  ],
                ),
                heightSpace(3),
                Container(
                  height: height / 7,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Container(
                          height: 100,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(0),
                            ),
                            color: Colors.grey.shade200,
                            // image: DecorationImage(
                            //   scale: 1.0,
                            //   fit: BoxFit.cover,
                            //   image: NetworkImage(
                            //     "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/$image!",
                            //   ),
                            // ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: width / 2,
                                      //color: Colors.amber,
                                      child: customText(
                                        text: "Event Name",
                                        fontSize: 14,
                                        textColor: AppColors.black,
                                      ),
                                    ),
                                    customText(
                                      text: "",
                                      fontSize: 14,
                                      textColor: AppColors.primary,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: width / 2,
                                  child: customText(
                                    text: "location Here",
                                    fontSize: 14,
                                    textColor: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                heightSpace(1),
                Container(
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    border:
                        Border.all(color: const Color(0xffD0D4EB), width: 0.3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              containerTitleSub("Place", "location"),
                              heightSpace(2),
                              containerTitleSub("Order ID", "orderId"),
                              heightSpace(2),
                              containerTitleSub("Date", "sDate - eDate"),
                              heightSpace(2),
                              containerTitleSub("Ticket Fee", "fees"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xff2D264B),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: PAD_ALL_15,
                                  child: Center(
                                    child: Icon(
                                      Icons.person_rounded,
                                      color: Colors.grey.shade500,
                                      size: height / 14,
                                    ),
                                  ),
                                ),
                              ),
                              heightSpace(2),
                              containerTitleSub("Name", "user"),
                              heightSpace(2),
                              containerTitleSub("Time", "sTime - eTime"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: PAD_ALL_10,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/hidden-bar.svg",
                          width: width,
                        ),
                        heightSpace(2),
                        customText(
                          text: "Powered By Chasescroll",
                          fontSize: 12,
                          textColor: AppColors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                heightSpace(3),
                ChasescrollButton(
                  buttonText: "Done",
                  onTap: () {
                    context.push(AppRoutes.bottomNav);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget containerTitleSub(String title, String subTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PlaceHolderTitle(title: title, color: AppColors.deepPrimary),
        customText(
          text: subTitle,
          fontSize: 12,
          textColor: AppColors.black,
        ),
      ],
    );
  }
}
