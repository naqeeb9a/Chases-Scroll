import 'package:chases_scroll/src/models/post_model.dart';
import 'package:chases_scroll/src/repositories/api/post_repository.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_shape.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/shimmer_.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends HookWidget {
  static final PostRepository _postRepository = PostRepository();
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postLoading = useState<bool>(true);
    final postModel = useState<PostModel?>(null);
    getPost() {
      _postRepository.getPost().then((value) {
        postLoading.value = false;
        postModel.value = value;
      });
    }

    useEffect(() {
      getPost();
      return null;
    }, []);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
          backgroundColor: AppColors.white,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: SvgPicture.asset(AppImages.messageIcon),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: SvgPicture.asset(AppImages.notificationBell),
            )
          ],
          title: customText(
              text: "Chasescroll", fontSize: 20, textColor: AppColors.primary)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3FE3E3E3),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ]),
              child: Column(children: [
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ChaseScrollContainer(name: "Sammy Cliffy"),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(AppImages.sendIcon),
                      ),
                      filled: true,
                      fillColor: AppColors.textFormColor,
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.textFormColor),
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Add your thoughts Sam",
                      hintStyle: GoogleFonts.dmSans(
                          textStyle: const TextStyle(
                              color: AppColors.black, fontSize: 12))),
                ),
                heightSpace(2),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.galleryIcon,
                      width: 20,
                      height: 20,
                    ),
                    widthSpace(3),
                    SvgPicture.asset(
                      AppImages.videoIcon,
                      height: 20,
                      width: 20,
                    ),
                    widthSpace(3),
                    customText(
                        text: "Add Photos/Video to your post",
                        fontSize: 11,
                        textColor: AppColors.black)
                  ],
                ),
              ]),
            ),
            heightSpace(2),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    postLoading.value
                        ? shopShimmerWithlength(5)
                        : Column(
                            children: [
                              ...postModel.value!.content!.map((e) => Container(
                                  padding: const EdgeInsets.all(20),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.textFormColor,
                                          width: 1),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(0),
                                      )),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          ChaseScrollContainer(
                                              name:
                                                  "${e.user?.firstName} ${e.user?.lastName}"),
                                          widthSpace(3),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              customText(
                                                  text:
                                                      "${e.user?.firstName} ${e.user?.lastName}",
                                                  fontSize: 12,
                                                  textColor: AppColors.black,
                                                  fontWeight: FontWeight.w500),
                                              customText(
                                                text: "${e.user?.username}",
                                                fontSize: 8,
                                                textColor: AppColors.black,
                                              ),
                                              customText(
                                                text: "56 mins ago",
                                                fontSize: 8,
                                                textColor: AppColors.textGrey,
                                              )
                                            ],
                                          ),
                                          const Spacer(),
                                          SvgPicture.asset(
                                              AppImages.verticalThreeDot)
                                        ],
                                      ),
                                      heightSpace(2),
                                      customText(
                                          text: e.text!,
                                          fontSize: 12,
                                          textColor: AppColors.black),
                                      heightSpace(2),
                                      if (e.mediaRef != null)
                                        Container(
                                          height: 200,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      AppColors.textFormColor,
                                                  width: 1),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20),
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(0),
                                              )),
                                        ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              heightSpace(2),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      AppImages.like),
                                                  widthSpace(1),
                                                  customText(
                                                      text: "${e.likeCount}",
                                                      fontSize: 11,
                                                      textColor:
                                                          AppColors.black)
                                                ],
                                              ),
                                              heightSpace(1),
                                              customText(
                                                  text: "React",
                                                  fontSize: 10,
                                                  textColor: AppColors.textGrey)
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              heightSpace(2),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      AppImages.comment),
                                                  widthSpace(1),
                                                  customText(
                                                      text: "${e.commentCount}",
                                                      fontSize: 11,
                                                      textColor:
                                                          AppColors.black)
                                                ],
                                              ),
                                              heightSpace(1),
                                              customText(
                                                  text: "Comments",
                                                  fontSize: 10,
                                                  textColor: AppColors.textGrey)
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              heightSpace(2),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      AppImages.share),
                                                  widthSpace(1),
                                                  customText(
                                                      text: "${e.shareCount}",
                                                      fontSize: 11,
                                                      textColor:
                                                          AppColors.black)
                                                ],
                                              ),
                                              heightSpace(1),
                                              customText(
                                                  text: "Share",
                                                  fontSize: 10,
                                                  textColor: AppColors.textGrey)
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )))
                            ],
                          )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
