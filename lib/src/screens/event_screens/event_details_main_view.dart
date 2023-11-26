import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/providers/event_statenotifier.dart';
import 'package:chases_scroll/src/providers/eventicket_provider.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/drop_down_widget_view.dart';
import 'package:chases_scroll/src/screens/event_screens/buying_event_ticket_screen/organizer_widget.dart';
import 'package:chases_scroll/src/screens/event_screens/widgets/event_detail_map_locationCard.dart';
import 'package:chases_scroll/src/screens/event_screens/widgets/event_details_iconText.dart';
import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/helpers/change_millepoch.dart';
import 'package:chases_scroll/src/utils/constants/helpers/luncher.dart';
import 'package:chases_scroll/src/utils/constants/helpers/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/images.dart';
import '../../utils/constants/spacer.dart';

final isOpenProvider =
    AutoDisposeStateNotifierProvider<IsOpendedNotifier, bool>((ref) {
  return IsOpendedNotifier();
});

final isResetBoolStateProvider =
    AutoDisposeStateNotifierProvider<IsEventDetailIsSavedNotifier, bool>((ref) {
  return IsEventDetailIsSavedNotifier();
});

final selectPriceIndexNotifier =
    AutoDisposeStateNotifierProvider<SelectPriceIndexNotifier, int>((ref) {
  return SelectPriceIndexNotifier(20);
});

List<String> wrapTicketTypeList = [
  "Free \$0.0",
  "Regular \$200",
  "Big Mack \$500",
  "Superior \$1000",
];

class EventDetailsMainView extends ConsumerWidget {
  static final EventRepository _eventRepository = EventRepository();

  final EventContent eventDetails;
  const EventDetailsMainView({super.key, required this.eventDetails});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // ref.read(selectPriceIndexNotifier.notifier).resetState();

    final notifier = ref.read(ticketSummaryProvider.notifier);
    final selectedIndex = ref.watch(selectPriceIndexNotifier);
    final boolValue = ref.watch(isOpenProvider);

    bool? isEventSaved = eventDetails.isSaved;
    //value for userID
    String userId =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);
    log(selectedIndex.toString());

    String selectedValue = "";

    dynamic sDate =
        DateTimeUtils.convertMillisecondsToDateTime(eventDetails.startDate!);
    String startDate = DateFormat('MMM d, y').format(sDate);
    dynamic eDate =
        DateTimeUtils.convertMillisecondsToDateTime(eventDetails.endDate!);
    String endDate = DateFormat('MMM d, y').format(eDate);

    DateTime startTime =
        DateTimeUtils.convertMillisecondsToDateTime(eventDetails.startTime!);
    String formattedStartTime = DateFormat('hh:mm a').format(startTime);

    DateTime endTime =
        DateTimeUtils.convertMillisecondsToDateTime(eventDetails.endTime!);
    String formattedEndTime = DateFormat('hh:mm a').format(startTime);

    final controller = ScreenshotController();

    log("event id here==> ${eventDetails.id!}");

    saveEvent(String eventId) async {
      final result = await _eventRepository.saveEvent(
        eventID: eventId,
        userID: userId,
      );
      log(userId);
      if (result['updated'] == true) {
        isEventSaved = result['updated'];
        ToastResp.toastMsgSuccess(resp: result['message']);
      } else {
        ToastResp.toastMsgError(resp: result['message']);
      }
    }

    unSaveEvent(String eventId) async {
      final result = await _eventRepository.unSaveEvent(
        eventID: eventId,
        userID: userId,
      );
      log(userId);
      if (result['updated'] == true) {
        isEventSaved = result['updated'];

        ToastResp.toastMsgSuccess(resp: result['message']);
      } else {
        ToastResp.toastMsgError(resp: result['message']);
      }
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundSummaryScreen,
      appBar: appBar(
        title: "Event Details",
        appBarActionWidget: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () async {
                  final image = await controller.capture();

                  log(image.toString());

                  final directory = await getApplicationDocumentsDirectory();
                  final images = File('${directory.path}/chasescoll.png');
                  images.writeAsBytesSync(image!);

                  String text =
                      "https://chasescroll-new.netlify.app/event/${eventDetails.id}";

                  // ignore: deprecated_member_use
                  await Share.shareFiles(
                    [images.path],
                    text: text,
                  );
                },
                child: Container(
                  child: SvgPicture.asset(
                    AppImages.share,
                    height: 2.7.h,
                    width: 2.7.w,
                    color: Colors.black87,
                  ),
                ),
              ),
              widthSpace(4),
              // GestureDetector(
              //   onTap: () {
              //     eventDetails.isSaved == false
              //         ? saveEvent(eventDetails.id!)
              //         : unSaveEvent(eventDetails.id!);
              //   },
              //   child: Container(
              //     child: isEventSaved == true
              //         ? SvgPicture.asset(
              //             AppImages.bookmarkFilled,
              //             height: 2.4.h,
              //             width: 2.4.w,
              //           )
              //         : SvgPicture.asset(
              //             AppImages.bookmark,
              //             height: 2.4.h,
              //             width: 2.4.w,
              //           ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: PAD_ALL_15,
            child: SizedBox(
              height: height,
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: PAD_ALL_10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Screenshot(
                            controller: controller,
                            child: Container(
                              height: 30.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(24),
                                  bottomRight: Radius.circular(24),
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(0),
                                ),
                                color: Colors.grey.shade200,
                                border: Border.all(
                                    width: 1.2,
                                    color: AppColors.backgroundSummaryScreen),
                                image: DecorationImage(
                                  scale: 1.0,
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${eventDetails.currentPicUrl}"),
                                ),
                              ),
                            ),
                          ),
                          heightSpace(1.2),
                          customText(
                            text: eventDetails.eventName.toString(),
                            fontSize: 14,
                            textColor: AppColors.black,
                            lines: 2,
                          ),
                          heightSpace(1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              eventDetails.currency == "USD"
                                  ? customText(
                                      text: "\$${eventDetails.minPrice}",
                                      fontSize: 13,
                                      textColor: AppColors.deepPrimary,
                                      fontWeight: FontWeight.w500,
                                    )
                                  : Text(
                                      "$naira${eventDetails.minPrice}",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        color: AppColors.deepPrimary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                              const Expanded(
                                flex: 7,
                                child: Row(),
                              ),
                              Expanded(
                                flex: eventDetails.interestedUsers!.length < 2
                                    ? 1
                                    : eventDetails.interestedUsers!.length < 3
                                        ? 2
                                        : 3,
                                child: SizedBox(
                                  //color: Colors.amber,
                                  height: 30,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: eventDetails
                                                .interestedUsers!.length <
                                            2
                                        ? eventDetails.interestedUsers!.length
                                        : 2, // Replace with your actual item count
                                    itemBuilder: (context, index) {
                                      InterestedUsers indiv =
                                          eventDetails.interestedUsers![index];
                                      // Replace this with your actual list item widget
                                      return Container(
                                        width: 8.w,
                                        height: 6.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: AppColors.primary
                                              .withOpacity(0.2),
                                          // image: DecorationImage(
                                          //   scale: 1.0,
                                          //   fit: BoxFit.fill,
                                          //   image: NetworkImage(
                                          //       "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${indiv.data!.imgMain!.value}"),
                                          // ),
                                        ),
                                        child: eventDetails.createdBy!.data !=
                                                null
                                            ? Center(
                                                child: indiv.firstName == null
                                                    ? customText(
                                                        text: "NN",
                                                        fontSize: 14,
                                                        textColor:
                                                            AppColors.white,
                                                        fontWeight:
                                                            FontWeight.w700)
                                                    : customText(
                                                        text:
                                                            "${indiv.firstName![0].toUpperCase()}${indiv.lastName![0].toUpperCase()}",
                                                        fontSize: 10,
                                                        textColor: AppColors
                                                            .deepPrimary,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(24),
                                                  bottomRight:
                                                      Radius.circular(24),
                                                  topLeft: Radius.circular(24),
                                                  topRight: Radius.circular(0),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${indiv.data!.imgMain!.value}",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                        // child: Visibility(
                                        //     child: Center(
                                        //   child: Text(
                                        //       "${indiv.firstName![0]}${indiv.lastName![0]}"
                                        //           .toUpperCase()),
                                        // )),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => context.push(
                                  AppRoutes.eventAttendeesView,
                                  extra: eventDetails,
                                ),
                                child: Container(
                                  width: 8.w,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: AppColors.deepPrimary,
                                  ),
                                  child: Center(
                                    child: customText(
                                      text:
                                          "+${eventDetails.memberCount.toString()}",
                                      fontSize: 10,
                                      textColor: AppColors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          heightSpace(1.6),
                          EventDetailsIconText(
                            iconString: AppImages.calendarAdd,
                            title:
                                "${startDate.toString()} - ${endDate.toString()}",
                            subTitle:
                                "Time-In ${formattedStartTime.toString()}",
                            subTitle2:
                                "Time-Out ${formattedEndTime.toString()}",
                          ),
                          heightSpace(1),
                          eventDetails.location!.link!.isNotEmpty ||
                                  eventDetails.location!.link == null
                              ? EventDetailsIconText(
                                  iconString: AppImages.location,
                                  title: "Online Event",
                                  link: "${eventDetails.location!.link}",
                                  onlinktap: () async {
                                    if (await launch(
                                        "${eventDetails.location!.link}")) {
                                      await canLaunch(
                                          "${eventDetails.location!.link}");
                                    } else {
                                      print('Could not launch');
                                    }
                                  },
                                )
                              : EventDetailsIconText(
                                  iconString: AppImages.location,
                                  title: "${eventDetails.location!.address}",
                                  subTitle:
                                      "${eventDetails.location!.locationDetails}",
                                ),
                          heightSpace(2),
                          const EventDetailsIconText(
                            iconString: AppImages.ticket,
                            title: "Select ticket Type",
                          ),
                          heightSpace(2),
                          DropDownEventType(
                            typeValue: selectedValue.isEmpty
                                ? "Please select ticket option"
                                : selectedValue,
                            typeList: eventDetails.productTypeData!,
                            onChanged: (value) {
                              selectedValue = value!;
                              Map<String, dynamic> selectedTicket =
                                  jsonDecode(value);
                              String ticketType = selectedTicket['ticketType'];

                              double ticketPrice =
                                  selectedTicket['ticketPrice'];

                              ref
                                  .read(isOpenProvider.notifier)
                                  .resetState(true);

                              log(formattedStartTime);

                              notifier.updateTicketSummary(
                                currency: eventDetails.currency,
                                eventId: eventDetails.id,
                                image: eventDetails.currentPicUrl,
                                location: eventDetails.location!.address,
                                name: eventDetails.eventName,
                                numberOfTickets: 0,
                                price: ticketPrice,
                                ticketType: ticketType,
                                time: formattedStartTime,
                              );
                            },
                            onSaved: (value) {},
                          ),
                        ],
                      ),
                    ),
                    heightSpace(2),
                    Visibility(
                      visible: boolValue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OrganizerContainerWidget(
                            height: height,
                            width: width,
                            isCreator: userId == eventDetails.createdBy!.userId
                                ? true
                                : false,
                            orgId: eventDetails.createdBy!.userId ?? "",
                            orgImage: eventDetails.createdBy!.data != null
                                ? eventDetails
                                        .createdBy!.data!.imgMain!.value ??
                                    ""
                                : "",
                            orgFName:
                                eventDetails.createdBy!.firstName.toString(),
                            orgLName:
                                eventDetails.createdBy!.lastName.toString(),
                            joinStatus:
                                eventDetails.createdBy!.joinStatus.toString(),
                          ),
                          heightSpace(2),
                          customText(
                            text: "Event Description",
                            fontSize: 13,
                            textColor: AppColors.deepPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                          heightSpace(1),
                          customText(
                            text: eventDetails.eventDescription.toString(),
                            fontSize: 12,
                            textColor: AppColors.black,
                            fontWeight: FontWeight.w400,
                            lines: 4,
                          ),
                          heightSpace(1.5),
                          EventDetailMapLocation(
                            height: height,
                            width: width,
                            function: () {
                              log(eventDetails.location!.address.toString());
                              if (eventDetails.location!.address == null) {
                                ToastResp.toastMsgError(
                                    resp:
                                        "Route to map cant open because event location is not available");
                              } else {
                                MapUtils.launchMapOnAddress(
                                  eventDetails.location!.address!,
                                );
                              }
                            },
                          ),
                          heightSpace(2),
                          Visibility(
                            visible:
                                eventDetails.isOrganizer == true ? false : true,
                            child: ChasescrollButton(
                              buttonText: "Buy Ticket",
                              onTap: () {
                                ref
                                    .read(selectPriceIndexNotifier.notifier)
                                    .resetState();
                                //log(notifier.state.name.toString());
                                context
                                    .push(AppRoutes.eventTicketSummaryScreen);
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
