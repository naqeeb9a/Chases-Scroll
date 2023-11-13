import 'dart:developer';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:chases_scroll/src/repositories/profile_repository.dart';
import 'package:chases_scroll/src/screens/profile_view/widgets/icon_row_profile.dart';
import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BarChartData {
  final String ticketType;
  final int value;

  BarChartData({required this.ticketType, required this.value});
}

class OrganizerAnalyticsScreenView extends StatefulHookWidget {
  final String eventId;
  final String location;
  final String date;
  final String eventName;
  final String currency;
  const OrganizerAnalyticsScreenView(
      {Key? key,
      required this.location,
      required this.date,
      required this.eventId,
      required this.eventName,
      required this.currency})
      : super(key: key);

  @override
  State<OrganizerAnalyticsScreenView> createState() =>
      _OrganizerAnalyticsScreenViewState();
}

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool? animate;

  const SimpleBarChart(this.seriesList, {super.key, this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      behaviors: [charts.SeriesLegend()],
    );
  }
}

class TicketData {
  final String ticketType;
  final int qtyPendingSold;
  final int qtyActiveSold;
  final int qtyRefunded;
  final int totalPendingSales;
  final int totalActiveSales;
  final int totalRefund;

  TicketData({
    required this.ticketType,
    required this.qtyPendingSold,
    required this.qtyActiveSold,
    required this.qtyRefunded,
    required this.totalPendingSales,
    required this.totalActiveSales,
    required this.totalRefund,
  });

  @override
  String toString() {
    return 'TicketData { ticketType: $ticketType, qtyPendingSold: $qtyPendingSold, '
        'qtyActiveSold: $qtyActiveSold, qtyRefunded: $qtyRefunded, '
        'totalPendingSales: $totalPendingSales, totalActiveSales: $totalActiveSales, '
        'totalRefund: $totalRefund }';
  }
}

class _OrganizerAnalyticsScreenViewState
    extends State<OrganizerAnalyticsScreenView> {
  final search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    log(widget.eventId);

    ProfileRepository profileRepository = ProfileRepository();

    final dashboardLoading = useState<bool>(true);
    final dashboardModel = useState<dynamic>({});

    getUsersConnectionRequests() {
      profileRepository.getEventAnalytic(eventId: widget.eventId).then((value) {
        dashboardLoading.value = false;
        dashboardModel.value = value;
      }).catchError((error) {
        // Handle the error here
        dashboardLoading.value = false;
        print('Error fetching event analytics: $error');
      });
    }

    // // Create a list of unique ticket types
    // final uniqueTicketTypes = dashboardModel.value['tickets']
    //     .map((ticketStat) => ticketStat['ticketType'])
    //     .where((type) => type != null) // Filter out null values
    //     .cast<String>() // Cast the list to List<String>
    //     .toSet()
    //     .toList();

    // List<BarChartData> data = [];
    // if (dashboardModel.value['tickets'] != null) {
    //   // Cast the list to List<Map<String, dynamic>>
    //   List<Map<String, dynamic>> ticketStats =
    //       List<Map<String, dynamic>>.from(dashboardModel.value['tickets']);

    //   // Use the casted list to create BarChartData objects
    //   data = ticketStats.map((ticketStat) {
    //     return BarChartData(
    //       ticketType: ticketStat['ticketType'] ?? "",
    //       value: ticketStat['qtyActiveSold'] ?? 0,
    //     );
    //   }).toList();
    // }

    // final series = [
    //   charts.Series(
    //     id: 'Ticket Sales',
    //     data: data,
    //     domainFn: (BarChartData sales, _) => sales.ticketType,
    //     measureFn: (BarChartData sales, _) => sales.value,
    //     colorFn: (BarChartData sales, _) =>
    //         _getColor(sales.ticketType, uniqueTicketTypes),
    //     labelAccessorFn: (BarChartData sales, _) => '${sales.value}',
    //   ),
    // ];

    useEffect(() {
      getUsersConnectionRequests();

      return null;
    }, []);
    return Scaffold(
      appBar: appBar(title: "Event Dashboard"),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: PAD_ALL_15,
          child: Column(
            children: [
              heightSpace(3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PopupMenuButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    position: PopupMenuPosition.under,
                    color: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            customText(
                                text: "Refund",
                                fontSize: 12,
                                textColor: AppColors.white),
                            // const Icon(
                            //   Icons.menu,
                            //   color: Colors.white,
                            //   size: 22,
                            // ),
                          ],
                        ),
                      ),
                    ),
                    itemBuilder: (ctx) => [],
                  ),
                  SizedBox(
                    height: 30,
                    width: 100,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(0),
                              ),
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(0),
                              ),
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 40,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(0),
                              ),
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 60,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(0),
                              ),
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    position: PopupMenuPosition.under,
                    color: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            customText(
                                text: "Refund",
                                fontSize: 12,
                                textColor: AppColors.white),
                            // const Icon(
                            //   Icons.menu,
                            //   color: Colors.white,
                            //   size: 22,
                            // ),
                          ],
                        ),
                      ),
                    ),
                    itemBuilder: (ctx) => [
                      buildPopupMenuItem('Refund User', AppColors.black,
                          function: () {
                        //context.push(AppRoutes.settings);
                      }),
                      buildPopupMenuItem(
                        'Refund All',
                        AppColors.black,
                        // function: () => context.push(AppRoutes.editProfile),
                      ),
                    ],
                  ),
                ],
              ),
              heightSpace(2),
              const Divider(),
              dashboardLoading.value
                  ? const Expanded(
                      child: Center(
                      child: CircularProgressIndicator(),
                    ))
                  : Expanded(
                      child: Container(
                        child: Padding(
                          padding: SCREEN_PAD_ATTENDEES,
                          child: Column(
                            children: [
                              Container(
                                height: height / 4,
                                width: width,
                                decoration: BoxDecoration(
                                  color: const Color(0xffD0F2D9),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Padding(
                                  padding: PAD_ALL_20,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundColor:
                                                const Color(0xff101828)
                                                    .withOpacity(0.7),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                AppImages.profileEvent,
                                                height: 22,
                                                width: 22,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          widthSpace(2),
                                          customText(
                                            text: widget.eventName,
                                            fontSize: 14,
                                            textColor: const Color(0xff101828),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                customText(
                                                  text: "Created",
                                                  fontSize: 14,
                                                  textColor:
                                                      const Color(0xff101828),
                                                ),
                                                heightSpace(2),
                                                customText(
                                                  text: dashboardModel.value![
                                                          "totalNumberOfAvailableTickets"]
                                                      .toString(),
                                                  fontSize: 14,
                                                  textColor:
                                                      const Color(0xff101828),
                                                ),
                                              ],
                                            ),
                                          ),
                                          spaceContainerAttendeeHeight(60),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                customText(
                                                  text: "Sold",
                                                  fontSize: 14,
                                                  textColor:
                                                      const Color(0xff101828),
                                                ),
                                                heightSpace(2),
                                                Text(
                                                  widget.currency == "USD"
                                                      ? "\$${dashboardModel.value['totalActiveSales'].toString()}"
                                                      : "₦${dashboardModel.value["totalActiveSales"].toString()}",
                                                  style: GoogleFonts.montserrat(
                                                    color: Colors.black87,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          spaceContainerAttendeeHeight(60),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                customText(
                                                  text: "Cancelled",
                                                  fontSize: 14,
                                                  textColor:
                                                      const Color(0xff101828),
                                                ),
                                                heightSpace(2),
                                                Text(
                                                  widget.currency == "USD"
                                                      ? "\$${dashboardModel.value['qtyRefunded'].toString()}"
                                                      : "₦${dashboardModel.value["qtyRefunded"].toString()}",
                                                  style: GoogleFonts.montserrat(
                                                    color: Colors.black87,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          spaceContainerAttendeeHeight(60),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                customText(
                                                  text: "Pending",
                                                  fontSize: 14,
                                                  textColor:
                                                      const Color(0xff101828),
                                                ),
                                                heightSpace(2),
                                                customText(
                                                  text: dashboardModel.value[
                                                          'totalPendingSales']
                                                      .toString(),
                                                  fontSize: 16,
                                                  textColor:
                                                      const Color(0xff101828),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              heightSpace(2),
                              const Divider(),
                              heightSpace(2),
                              // Expanded(
                              //   child: Container(
                              //     child: SimpleBarChart(series, animate: true),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Padding spaceContainerAttendeeHeight(double height) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Container(
        height: height,
        width: 0.5,
        color: Colors.black87,
      ),
    );
  }

  charts.Color _getColor(String label, List<String> uniqueTicketTypes) {
    final colorPalette =
        charts.MaterialPalette.getOrderedPalettes(uniqueTicketTypes.length);
    final index = uniqueTicketTypes.indexOf(label);
    return colorPalette[index].shadeDefault;
  }
}
