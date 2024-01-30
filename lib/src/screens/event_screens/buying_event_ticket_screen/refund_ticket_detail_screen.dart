import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/providers/eventicket_provider.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/helpers/strings.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class RefundTicketDetailScreen extends ConsumerWidget {
  const RefundTicketDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final notifier = ref.read(ticketSummaryProvider.notifier);
    final state = notifier.state;

    return Scaffold(
      backgroundColor: AppColors.backgroundSummaryScreen,
      body: SafeArea(
        child: SizedBox(
          height: height,
          width: width,
          child: Padding(
            padding: PAD_ALL_15,
            child: SingleChildScrollView(
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
                      ChasescrollButton(
                        width: 100,
                        height: 40,
                        buttonText: "Cancel Ticket",
                        color: const Color.fromARGB(255, 188, 194, 223),
                        textColor: AppColors.red,
                        onTap: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return AlertDialog(
                          //       //actionsAlignment: MainAxisAlignment.center,
                          //       title: font18Tx700(
                          //         "Do you want to allow\n“Chasescroll” cancel ticket?",
                          //         Colors.black87,
                          //       ),
                          //       content: font14Tx500(
                          //           "Are you sure you want to cancel ticket payment",
                          //           Colors.black87),
                          //       actions: [
                          //         TextButton(
                          //           onPressed: () {
                          //             Navigator.of(context).push(
                          //               MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     const CancelTicketOptionScreenView(),
                          //               ),
                          //             );
                          //           },
                          //           child: const Text('Yes'),
                          //         ),
                          //         TextButton(
                          //           onPressed: () {
                          //             Navigator.pop(context);
                          //           },
                          //           child: const Text('No'),
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // );
                          context.push(AppRoutes.bottomNav);
                        },
                      )
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
                            height: 90,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              color: Colors.grey.shade200,
                              image: DecorationImage(
                                scale: 1.0,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${state.image}",
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 45.w,
                                    child: customText(
                                      text: state.name!.toUpperCase(),
                                      fontSize: 14,
                                      textColor: AppColors.black,
                                      fontWeight: FontWeight.w600,
                                      lines: 2,
                                    ),
                                  ),
                                  customText(
                                    text: state.location ?? "",
                                    fontSize: 14,
                                    textColor: AppColors.primary,
                                    lines: 2,
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
                      border: Border.all(
                          color: const Color(0xffD0D4EB), width: 0.3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                containerTitleSub(
                                    "Place", state.location ?? ""),
                                heightSpace(2),
                                containerTitleSub(
                                    "Order ID", state.location ?? ""),
                                heightSpace(2),
                                containerTitleSub(
                                    "Ticket Type", state.ticketType ?? ""),
                                heightSpace(2),
                                containerTitleSub(
                                    "Ticket Fee", "${state.price}"),
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
                                heightSpace(4),
                                containerTitleSub("Name", state.name ?? ''),
                                heightSpace(2),
                                containerTitleSub("Time", state.time ?? ""),
                              ],
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
                    ),
                    child: Padding(
                      padding: PAD_ALL_10,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppImages.hiddenBar,
                            width: width,
                            height: 100,
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
                  heightSpace(1),
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
