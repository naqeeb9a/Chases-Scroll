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
                          fontSize: 12,
                          textColor: const Color(0xff6B6B6B),
                          fontWeight: FontWeight.w500,
                        ),
                        customText(
                          text:
                              "${widget.orgFName.toUpperCase()} ${widget.orgLName.toUpperCase()}",
                          fontSize: 14,
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
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => ChatDetailsScreenView(
                      //       chatID: widget.orgId,
                      //       chatName: widget.orgName,
                      //       image: widget.orgImage,
                      //     ),
                      //   ),
                      // );

                      if (widget.orgId.isNotEmpty) {
                        fndID.add(widget.orgId.toString());
                      }

                      // creatGroupChatFunction(
                      //   context,
                      //   name: fullName,
                      //   friendIDs: fndID,
                      //   image: widget.orgImage,
                      //   userid: widget.orgId,
                      // );
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

  connectFriend(String? userId) async {
    final result = await _exploreRepository.connectWithFriend(friendID: userId);
    if (result['updated'] == true) {
      // Trigger a refresh of the events data
      followValue();

      ToastResp.toastMsgSuccess(resp: result['message']);

      //refreshEventProvider(context.read);
    } else {
      ToastResp.toastMsgError(resp: result['message']);
    }
  }

  disconnectFriend(String? userId) async {
    final result = await _eventRepository.deleteFriend(friendID: userId);
    if (result['updated'] == true) {
      // Trigger a refresh of the events data
      followValue();

      ToastResp.toastMsgSuccess(resp: result['message']);

      //refreshEventProvider(context.read);
    } else {
      ToastResp.toastMsgError(resp: result['message']);
    }
  }

  void followValue() {
    setState(() {
      follow = !follow;
    });
  }

//   ChatDatabase chatDatabase = ChatDatabase();
//   //function to create group chat
//   creatGroupChatFunction(
//     context, {
//     String? name,
//     String? image,
//     List<String>? friendIDs,
//     String? userid,
//   }) async {
//     //String? SharedID = friendIDS[0];
//     setState(() {
//       isLoading = true;
//     });
//     String status = await chatDatabase.createSingleChat(
//       name: name,
//       imgString: image,
//       users: friendIDs,
//       userId: userid,
//     );
//     log(userid!);

//     if (status == "success") {
//       Provider.of<ChatProvider>(context, listen: false).getAllChatList();
//       Provider.of<ChatProvider>(context, listen: false)
//           .getAllChatDetails(userid!);
//       Provider.of<ChatProvider>(context, listen: false).getAllMember(userid);

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: font14Tx500(
//             "Organizer has been added to your chat list.",
//             Colors.white,
//           ),
//           backgroundColor: mainColor(),
//         ),
//       );
//       // Future.delayed(const Duration(milliseconds: 300), () {
//       //   Navigator.of(context).push(
//       //     MaterialPageRoute(
//       //       builder: (context) => ChatDetailsScreenView(
//       //         chatName: fullName,
//       //         image: widget.orgImage.toString(),
//       //         chatID: widget.orgId,
//       //       ),
//       //     ),
//       //   );
//       // });

//       setState(() {
//         isLoading = false;
//       });
//     } else if (status == "error") {
//       setState(() {
//         isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Error in Create One-To-One chat")));
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
}
