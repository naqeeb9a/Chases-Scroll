import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class EventTicketSummaryScreen extends HookWidget {
  const EventTicketSummaryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(title: "Title Detail"),
        body: Consumer(
          builder: (context, ref, child) {
            //final data = ref.read(myDataProvider);
            return Padding(
              padding: PAD_ALL_15,
              child: Column(
                children: [
                  Container(
                    height: 30.h,
                    width: 90.w,
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
                            width: 35.w,
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
                              //   fit: BoxFit.fill,
                              //   image: NetworkImage(
                              //       //TODO: Add video just incase user upload video for event image or video
                              //       "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${widget.image}"),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 50.w),
                                        height: 50,
                                        width: 90.w,
                                        //color: Colors.amber,
                                        child: customText(
                                          text: "data.name!",
                                          fontSize: 16,
                                          textColor: AppColors.black,
                                        ),
                                      ),
                                      customText(
                                        text: "data.location!",
                                        fontSize: 16,
                                        textColor: AppColors.primary,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: 90.w,
                                    child: customText(
                                      text: "location",
                                      fontSize: 16,
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
                ],
              ),
            );
          },
        ));
  }
}
