import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class EventDetailMapLocation extends StatelessWidget {
  final double height;
  final Function()? function;
  final double width;
  const EventDetailMapLocation({
    super.key,
    required this.height,
    required this.width,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 20.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey.shade200,
        ),
        child: Stack(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: Image.asset(
                AppImages.map,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: height,
              width: width,
              color: Colors.black54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customText(
                    text: "Click to see ->  ",
                    fontSize: 14,
                    textColor: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  Container(
                    padding: PAD_ALL_10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: customText(
                      text: "Event Location",
                      fontSize: 12,
                      textColor: AppColors.deepPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
