import 'package:chases_scroll/src/screens/expore_screens/widgets/suggestions_view.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/dimens.dart';
import '../../widgets/chasescroll_button.dart';
import '../../widgets/custom_fonts.dart';

class SearchCommunityWidget extends StatelessWidget {
  const SearchCommunityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => CommunityChatScreenView(
        //         image: comm['data']['imgSrc'] ?? "",
        //         chatName: comm['data']['name'] ?? "",
        //         chatDesc: comm['data']['description'] ?? "",
        //         groupID: comm['id'],
        //         creatorId: comm['creator']['userId']),
        //   ),
        // );
      },
      child: Padding(
        padding: PAD_ALL_15,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(0),
                                  ),
                                  color: AppColors.deepPrimary),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 1),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(0),
                                ),
                                color: AppColors.deepPrimary,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 1),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(0),
                                ),
                                color: Colors.grey.shade200,
                                // image: DecorationImage(
                                //   fit: BoxFit.cover,
                                //   image: NetworkImage(
                                //       "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${comm['data']['imgSrc']}"),
                                // ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    widthSpace(1),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                            text: "A Haven Party Light",
                            fontSize: 14,
                            textColor: AppColors.black,
                            fontWeight: FontWeight.w500),
                        Container(
                          height: 38,
                          width: width / 2.5,
                          //color: Colors.amber,
                          child: customText(
                              text:
                                  "Rorem ipsum  Dolor sit amet, conse Rorem ipsum  Dolor sit amet, conse",
                              fontSize: 12,
                              textColor: AppColors.searchTextGrey,
                              fontWeight: FontWeight.w500),
                        ),
                        heightSpace(1),
                        Row(
                          children: [
                            customText(
                                text: "24k Members",
                                fontSize: 10,
                                textColor: AppColors.searchTextGrey,
                                fontWeight: FontWeight.w500),
                            widthSpace(10),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffD0D4EB),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: customText(
                                    text: "Public",
                                    fontSize: 8,
                                    textColor: AppColors.red,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.deepPrimary,
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10),
                  child: customText(
                      text: "Joined",
                      fontSize: 10,
                      textColor: AppColors.white,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
