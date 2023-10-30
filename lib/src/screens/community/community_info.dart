import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';

class CommunityInfo extends StatelessWidget {
  const CommunityInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: customText(
              text: "Community Info",
              fontSize: 14,
              textColor: AppColors.black)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              Center(
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(0),
                    ),
                    color: Colors.white,
                    border: Border.all(
                      color: AppColors.primary,
                      width: 3,
                    ),
                    // image: image == null
                    //     ? DecorationImage(
                    //         image: NetworkImage(
                    //           Constants.downloadImageBaseUrl + widget.image!,
                    //         ),
                    //         fit: BoxFit.cover)
                    //     : DecorationImage(
                    //         image: FileImage(
                    //           File(image!.path).absolute,
                    //         ),
                    //         fit: BoxFit.cover,
                    //       )
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        bottom: 5,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  width: 1.0, color: AppColors.primary),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.camera_alt_rounded,
                                size: 15,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              heightSpace(1),
              customText(
                  text: "Big Wiz",
                  fontSize: 16,
                  textColor: AppColors.primary,
                  fontWeight: FontWeight.bold),
              customText(
                  text: "3 Members, 0 Online",
                  fontSize: 12,
                  textColor: AppColors.searchTextGrey,
                  fontWeight: FontWeight.bold),
              heightSpace(1),
              const AppTextFormField(
                hintText: "Search",
                hasBorder: true,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
