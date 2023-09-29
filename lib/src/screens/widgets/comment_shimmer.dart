import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:shimmer/shimmer.dart';

commentShimmerWithlength(int count) {
  final List<Widget> widget = List.generate(count, (index) => shopShimmer());
  return Column(
    children: widget,
  );
}

Widget shopShimmer() {
  return Padding(
    padding: const EdgeInsets.only(left: 8, right: 8, bottom: 30, top: 10),
    child: Shimmer.fromColors(
      baseColor: AppColors.grey,
      highlightColor: AppColors.lightGrey,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(0),
                      ))),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      height: 15,
                      width: double.infinity,
                    ),
                    heightSpace(1),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
          heightSpace(1),
          Container(
            height: 18,
            decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(0),
                )),
          )
        ],
      ),
    ),
  );
}
