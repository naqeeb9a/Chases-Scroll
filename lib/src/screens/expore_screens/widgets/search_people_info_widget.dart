import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/spacer.dart';
import '../../widgets/custom_fonts.dart';

class SearchPeopleWidget extends StatelessWidget {
  final String? fullName;

  final String? username;
  final String? image;
  const SearchPeopleWidget({
    super.key,
    this.fullName,
    this.username,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    //to add initails when there is no image on people profile
    // String n = fullName.toString();
    // List<String> words = n.split(' ');
    // String initials = words.map((word) => word[0]).join('');
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      margin: const EdgeInsets.only(right: 15, bottom: 5),

      ///color: AppColors.blue,
      child: Row(
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
              border: Border.all(color: AppColors.primary),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/$image"),
              ),
            ),
            child: Center(
              child: customText(
                  text: image == null ? username![0].toUpperCase() : "",
                  fontSize: 14,
                  textColor: AppColors.deepPrimary,
                  fontWeight: FontWeight.w500),
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
                    text: fullName!,
                    fontSize: 12,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w700),
                customText(
                    text: username!,
                    fontSize: 11,
                    textColor: AppColors.searchTextGrey,
                    fontWeight: FontWeight.w400),
              ],
            ),
          )
        ],
      ),
    );
  }
}
