import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/constants/spacer.dart';

class SearchPeopleWidget extends StatefulWidget {
  final ContentUser user;

  const SearchPeopleWidget({
    super.key,
    required this.user,
  });

  @override
  State<SearchPeopleWidget> createState() => _SearchPeopleWidgetState();
}

class _SearchPeopleWidgetState extends State<SearchPeopleWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.push(AppRoutes.otherUsersProfile, extra: widget.user.userId),
      child: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        margin: const EdgeInsets.only(right: 15, bottom: 5),

        ///color: AppColors.blue,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(0),
                    ),
                    color: Colors.grey.shade100,
                    border: Border.all(color: AppColors.primary, width: 1.5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${widget.user.data!.imgMain!.value}"),
                    ),
                  ),
                  child: Center(
                    child: Visibility(
                      visible: widget.user.data!.imgMain!.objectPublic == false
                          ? true
                          : false,
                      child: customText(
                          text: widget.user.firstName!.isEmpty
                              ? ""
                              : "${widget.user.firstName![0]}${widget.user.lastName![0]}"
                                  .toUpperCase(),
                          fontSize: 14,
                          textColor: AppColors.deepPrimary,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                widthSpace(2),
                Container(
                  //color: Colors.amber,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customText(
                          text:
                              "${widget.user.firstName} ${widget.user.lastName}",
                          fontSize: 12,
                          textColor: AppColors.black,
                          fontWeight: FontWeight.w700),
                      customText(
                          text: widget.user.username!,
                          fontSize: 11,
                          textColor: AppColors.searchTextGrey,
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                )
              ],
            ),
            heightSpace(0.2),
            const Divider(
              thickness: 0.5,
              color: AppColors.iconGrey,
            )
          ],
        ),
      ),
    );
  }
}
