import 'package:chases_scroll/src/repositories/community_repo.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommunityInfo extends HookWidget {
  static final CommunityRepo communityRepo = CommunityRepo();

  const CommunityInfo({super.key});

  @override
  Widget build(BuildContext context) {
    // getGroupMembers() {
    //   communityRepo.getGroupMembers(communityId)
    // }
    useEffect(() {
      return null;
    }, []);
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
              AppTextFormField(
                prefixIcon: SvgPicture.asset(AppImages.searchIcon),
                hintText: "Search",
                hasBorder: true,
              ),
              heightSpace(2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 100,
                      height: 64,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF0F2F9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 3,
                            offset: Offset(0, 1),
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(AppImages.notificationBell),
                          heightSpace(.5),
                          customText(
                              text: "Mute",
                              fontSize: 10,
                              textColor: AppColors.primary)
                        ],
                      )),
                  Container(
                      width: 100,
                      height: 64,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF0F2F9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 3,
                            offset: Offset(0, 1),
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(AppImages.exit),
                          heightSpace(.5),
                          customText(
                              text: "Exit",
                              fontSize: 10,
                              textColor: AppColors.primary)
                        ],
                      )),
                  Container(
                      width: 100,
                      height: 64,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF0F2F9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 3,
                            offset: Offset(0, 1),
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(AppImages.exit),
                          heightSpace(.5),
                          customText(
                              text: "Settings",
                              fontSize: 10,
                              textColor: AppColors.primary)
                        ],
                      ))
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
