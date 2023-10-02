import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/helpers/strings.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class CommunityWidgetView extends StatelessWidget {
  const CommunityWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 7.h,
      width: double.infinity,
      //color: Colors.green,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 5.h,
                width: 60,
                // color: Colors.blue,
              ),
              Positioned(
                left: 0,
                child: Container(
                  width: 30,
                  height: 5.h,
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
              Positioned(
                left: 3,
                child: Container(
                  width: 10.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(0),
                    ),
                    color: AppColors.deepPrimary,
                  ),
                ),
              ),
              Positioned(
                left: 8,
                child: Container(
                    width: 10.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(0),
                      ),
                      color: Colors.grey.shade200,
                      // image: DecorationImage(
                      //   image: NetworkImage(
                      //     "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${commFunnel[0].imageString}",
                      //   ),
                      //   scale: 1.0,
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    child: Center(
                      child: customText(
                          text: getAcronym("Redemmer School"),
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          textColor: AppColors.black),
                    )),
              ),
            ],
          ),
          widthSpace(1.3),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customText(
                  text: "RCCG Rejoice Night",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.black),
              heightSpace(0.1),
              Flexible(
                child: customText(
                    text: "24k Members",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.searchTextGrey),
              ),
            ],
          )
        ],
      ),
    );
  }
}
