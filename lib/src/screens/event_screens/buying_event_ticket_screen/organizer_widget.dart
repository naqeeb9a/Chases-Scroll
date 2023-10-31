import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/repositories/explore_repository.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrganizerContainerWidget extends StatefulWidget {
  final double height;

  final double width;
  final String orgId;
  final String orgFName;
  final String orgLName;
  final String orgImage;
  final bool isCreator;
  const OrganizerContainerWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.orgId,
    required this.orgFName,
    required this.orgLName,
    required this.orgImage,
    required this.isCreator,
  }) : super(key: key);

  @override
  State<OrganizerContainerWidget> createState() =>
      _OrganizerContainerWidgetState();
}

class _OrganizerContainerWidgetState extends State<OrganizerContainerWidget> {
  bool follow = false;

  bool isLoading = false;

  List<String> fndID = [];
  late String? fullName =
      "${widget.orgFName.toUpperCase()} ${widget.orgLName.toUpperCase()}";
  final ExploreRepository _exploreRepository = ExploreRepository();

  final EventRepository _eventRepository = EventRepository();

  @override
  Widget build(BuildContext context) {
    log(widget.isCreator.toString());

    return Container(
      height: widget.height / 12,
      width: widget.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
          topLeft: Radius.circular(24),
          topRight: Radius.circular(0),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => UserConnectProfilePageScreenView(
                //       userID: widget.orgId,
                //     ),
                //   ),
                // );
              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 45,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(0),
                        ),
                        color: Colors.grey.shade300,
                      ),
                      child: widget.orgImage.isEmpty
                          ? Center(
                              child: customText(
                                text:
                                    "${widget.orgFName[0].toUpperCase()} ${widget.orgLName[0].toUpperCase()}",
                                fontSize: 14,
                                textColor: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(24),
                                bottomRight: Radius.circular(24),
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(0),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${widget.orgImage.toString()}",
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                          text: "Organizer",
                          fontSize: 10,
                          textColor: const Color(0xff6B6B6B),
                          fontWeight: FontWeight.w500,
                        ),
                        customText(
                          text:
                              "${widget.orgFName.toUpperCase()} ${widget.orgLName.toUpperCase()}",
                          fontSize: 12,
                          textColor: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(height: 3),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: widget.isCreator ? false : true,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // String? name = value.name;

                      follow
                          ? connectFriend(widget.orgId)
                          : disconnectFriend(widget.orgId);
                    },
                    child: SvgPicture.asset(
                      AppImages.addOrganizer,
                      color: follow ? Colors.green : AppColors.primary,
                    ),
                  ),
                  widthSpace(2.5),
                  GestureDetector(
                    onTap: () {
                      if (widget.orgId.isNotEmpty) {
                        fndID.add(widget.orgId.toString());
                      }
                    },
                    child: isLoading
                        ? const SizedBox(
                            height: 13,
                            width: 13,
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          )
                        : SvgPicture.asset(
                            AppImages.messageOrganizer,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  connectFriend(String friendID) async {
    final result =
        await _exploreRepository.connectWithFriend(friendID: friendID);
    if (result['updated'] == true) {
      ToastResp.toastMsgSuccess(resp: result['message']);
      log(result.toString());
      followValue();
    } else {
      ToastResp.toastMsgError(resp: result['message']);
    }
  }

  disconnectFriend(String friendID) async {
    final result =
        await _exploreRepository.disconnectWithFriend(friendID: friendID);
    if (result['updated'] == true) {
      ToastResp.toastMsgSuccess(resp: result['message']);
      followValue();
      log(friendID.toString());
      log(result.toString());
    } else {
      log(friendID.toString());
      log(result.toString());
      ToastResp.toastMsgError(resp: result['message']);
    }
  }

  void followValue() {
    setState(() {
      follow = !follow;
    });
  }
}
