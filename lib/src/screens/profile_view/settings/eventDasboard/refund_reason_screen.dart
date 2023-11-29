import 'dart:developer';

import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/screens/bottom_nav.dart';
import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RefundTicketOptionScreenView extends StatefulWidget {
  final String title;

  final int refundNumber;
  final String eventId;
  final String userId;
  const RefundTicketOptionScreenView(
      {Key? key,
      required this.title,
      required this.refundNumber,
      required this.eventId,
      required this.userId})
      : super(key: key);

  @override
  State<RefundTicketOptionScreenView> createState() =>
      _RefundTicketOptionScreenViewState();
}

class _RefundTicketOptionScreenViewState
    extends State<RefundTicketOptionScreenView> {
  EventRepository eventRepository = EventRepository();
  //Radio button value for for refund or cancel ticket
  String _radiorefundValue = '';

  //list for reasons
  List<String> reasonList = [
    "Health concerns",
    "Personal Conflict with date/location",
    "Lack of Interest in the event or speaker",
    "Feeling obverwhelmed or stressed",
    "Financial Constraints",
    "Prior commitments such as work or family obligations.",
    "Need for time off or a break from social activities",
    "Logistics issues such as travel or transportation problems",
    "Distance or geography makes attending logistically difficult",
    "Respect for social distancing measures during the COVID-19 pandemic",
    "Others",
  ];

  //loading indicator
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    log(widget.eventId);
    log(widget.userId);
    return Scaffold(
      appBar: appBar(title: "Reason for refund"),
      body: SafeArea(
        child: Padding(
          padding: PAD_ALL_15,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: PAD_ALL_10,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: SvgPicture.asset(
                                AppImages.question,
                              ),
                            ),
                            Container(
                              child: Image.asset(
                                AppImages.mark,
                                height: 60,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height / 1.75,
                          width: width,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: reasonList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return RadioListTile(
                                dense: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                title: customText(
                                  text: reasonList[index],
                                  fontSize: 14,
                                  textColor: AppColors.black,
                                ),
                                value: reasonList[index],
                                groupValue: _radiorefundValue,
                                onChanged: (value) {
                                  setState(() {
                                    _radiorefundValue = value!;
                                  });
                                  print(_radiorefundValue);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                heightSpace(2),
                ChasescrollButton(
                  buttonText: "Submit",
                  onTap: () async {
                    log(widget.eventId);

                    if (widget.refundNumber == 2) {
                      bool result = await eventRepository.refundAllUser(
                          eventID: widget.eventId);

                      if (result == true) {
                        ToastResp.toastMsgSuccess(
                            resp: "Refund was successful");
                        refundDoneSuccessful(context);
                      } else {
                        ToastResp.toastMsgError(
                            resp: "Refund was not successful");

                        refundUnsuccessful(context);
                      }
                    } else {
                      bool result = await eventRepository.refundUserEventTicket(
                        eventID: widget.eventId,
                        userID: widget.userId,
                        reason: _radiorefundValue,
                      );

                      if (result == true) {
                        ToastResp.toastMsgSuccess(
                            resp: "Refund was successful");
                        refundDoneSuccessful(context);
                      } else {
                        ToastResp.toastMsgError(
                            resp: "Refund was not successful");
                        refundUnsuccessful(context);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void refundAll(BuildContext context) async {
    bool result = await eventRepository.refundAllUser(eventID: widget.eventId);

    result == true
        ? refundDoneSuccessful(context)
        : refundUnsuccessful(context);
  }

  Future<dynamic> refundDoneSuccessful(BuildContext context) {
    return showDialog(
      context: context, // Use the parent context instead
      builder: (BuildContext parentContext) {
        // Use parentContext instead of context
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                customText(
                  text: "Refund Successful",
                  fontSize: 14,
                  textColor: AppColors.black,
                ),
                heightSpace(3),
                InkWell(
                  onTap: () {
                    Navigator.of(parentContext).push(MaterialPageRoute(
                      builder: (context) => const BottomNavBar(),
                    ));
                  },
                  child: customText(
                    text: "Done",
                    fontSize: 14,
                    textColor: AppColors.deepPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //if fails
  Future<dynamic> refundUnsuccessful(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                customText(
                  text: "Refund Not Successful",
                  fontSize: 14,
                  textColor: AppColors.black,
                ),
                heightSpace(3),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: customText(
                    text: "Done",
                    fontSize: 14,
                    textColor: AppColors.deepPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void refundUser(BuildContext context) async {
    bool result = await eventRepository.refundUserEventTicket(
      eventID: widget.eventId,
      userID: widget.userId,
      reason: _radiorefundValue,
    );

    result == true
        ? refundDoneSuccessful(context)
        : refundUnsuccessful(context);
  }
}
