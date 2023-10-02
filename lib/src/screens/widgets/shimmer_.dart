import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:shimmer/shimmer.dart';

Widget boxShimmer() {
  return Shimmer.fromColors(
      baseColor: AppColors.grey,
      highlightColor: AppColors.lightGrey,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(10)),
      ));
}

Widget boxShimmerWithSize(double height) {
  return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 233, 233, 233),
      highlightColor: const Color.fromARGB(255, 255, 251, 251),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(10)),
      ));
}

//-------------------------- Search Users Shimmer --------------------------------//
Widget eventExploreShimmer() {
  return Shimmer.fromColors(
    baseColor: const Color.fromARGB(255, 233, 233, 233),
    highlightColor: const Color.fromARGB(255, 255, 251, 251),
    child: Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(0),
                  ))),
          widthSpace(1.3),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 70.w,
                height: 1.5.h,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 251, 251),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
              ),
              heightSpace(0.9),
              Container(
                width: 50.w,
                height: 1.5.h,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 251, 251),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

eventExploreShimmerWithlength({int? count}) {
  final List<Widget> widget =
      List.generate(count!, (index) => searchUsersShimmer());
  return Column(
    children: widget,
  );
}

Widget listShimmer() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Shimmer.fromColors(
      baseColor: AppColors.grey,
      highlightColor: AppColors.lightGrey,
      child: Row(
        children: [
          Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.white)),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 15,
                  color: AppColors.white,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  height: 20,
                  color: AppColors.white,
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget listTileShimmer(int count) {
  final List<Widget> widget = List.generate(count, (index) => listShimmer());
  return Column(
    children: widget,
  );
}

//-------------------------- Search Users Shimmer --------------------------------//
Widget searchUsersShimmer() {
  return Shimmer.fromColors(
    baseColor: const Color.fromARGB(255, 233, 233, 233),
    highlightColor: const Color.fromARGB(255, 255, 251, 251),
    child: Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(0),
                  ))),
          widthSpace(1.3),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 70.w,
                height: 1.5.h,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 251, 251),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
              ),
              heightSpace(0.9),
              Container(
                width: 50.w,
                height: 1.5.h,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 251, 251),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

searchUsersShimmerWithlength({int? count}) {
  final List<Widget> widget =
      List.generate(count!, (index) => searchUsersShimmer());
  return Column(
    children: widget,
  );
}

Widget shopShimmer() {
  return Padding(
    padding: const EdgeInsets.only(left: 8, right: 8, bottom: 40, top: 10),
    child: Shimmer.fromColors(
      baseColor: AppColors.grey,
      highlightColor: AppColors.lightGrey,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 50,
                  height: 50,
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
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      height: 18,
                    ),
                    heightSpace(1),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      height: 18,
                    ),
                  ],
                ),
              )
            ],
          ),
          heightSpace(1),
          Container(
            height: 150,
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

shopShimmerWithlength(int count) {
  final List<Widget> widget = List.generate(count, (index) => shopShimmer());
  return Column(
    children: widget,
  );
}

//-------------------------- Suggested users Horizonatal --------------------------------//
Widget suggestedUserHoriShimmer() {
  return Shimmer.fromColors(
    baseColor: const Color.fromARGB(255, 233, 233, 233),
    highlightColor: const Color.fromARGB(255, 255, 251, 251),
    child: Container(
        margin: const EdgeInsets.fromLTRB(5, 20, 15, 10),
        width: double.infinity,
        height: 7.h,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 251, 251),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
        ),
        child: Container()),
  );
}

//-------------------------- Suggested users --------------------------------//
Widget suggestedUserShimmer() {
  return Shimmer.fromColors(
    baseColor: const Color.fromARGB(255, 233, 233, 233),
    highlightColor: const Color.fromARGB(255, 255, 251, 251),
    child: Container(
        margin: const EdgeInsets.fromLTRB(5, 20, 15, 10),
        width: 36.w,
        height: 20.h,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 251, 251),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
            topLeft: Radius.circular(40),
            topRight: Radius.circular(0),
          ),
        ),
        child: Container()),
  );
}

//-------------------------- Top Event --------------------------------//
Widget topEventShimmer(double height, double width) {
  return Shimmer.fromColors(
    baseColor: const Color.fromARGB(255, 233, 233, 233),
    highlightColor: const Color.fromARGB(255, 255, 251, 251),
    child: SingleChildScrollView(
      child: Row(
        children: [
          Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 251, 251),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(0),
                ),
              ),
              child: Container()),
        ],
      ),
    ),
  );
}

topEventShimmerWithlength({int? count, double? height, double? width}) {
  final List<Widget> widget =
      List.generate(count!, (index) => topEventShimmer(height!, width!));
  return SingleChildScrollView(
    child: Row(
      children: widget,
    ),
  );
}

usersHoriShimmerWithlength({int? count}) {
  final List<Widget> widget =
      List.generate(count!, (index) => suggestedUserHoriShimmer());
  return Column(
    children: widget,
  );
}

usersShimmerWithlength({int? count, double? height, double? width}) {
  final List<Widget> widget =
      List.generate(count!, (index) => suggestedUserShimmer());
  return Row(
    children: widget,
  );
}
