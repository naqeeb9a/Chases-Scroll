import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/models/post_model.dart';
import 'package:chases_scroll/src/models/user_model.dart';
import 'package:chases_scroll/src/providers/auth_provider.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:chases_scroll/src/repositories/post_repository.dart';
import 'package:chases_scroll/src/repositories/user_repository.dart';
import 'package:chases_scroll/src/screens/home/add_video_modal.dart';
import 'package:chases_scroll/src/screens/home/edit_post_modal.dart';
import 'package:chases_scroll/src/screens/home/share_modal.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_shape.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/picture_container.dart';
import 'package:chases_scroll/src/screens/widgets/shimmer_.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/extensions/index_of_map.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/locator.dart';
import '../../utils/constants/helpers/change_millepoch.dart';

class HomeScreen extends HookConsumerWidget {
  static final PostRepository _postRepository = PostRepository();

  static final UserRepository _userRepository = UserRepository();
  static final postText = TextEditingController();
  static final ImagePicker picker = ImagePicker();
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refresh = ref.watch(refreshHomeScreen);
    final pageLoading = useState<bool>(true);
    final postLoading = useState<bool>(true);
    final postModel = useState<PostModel?>(null);
    final userModel = useState<UserModel?>(null);
    final imageList = useState<List<File>>([]);
    final videoFile = useState<File>(File(''));
    final imageToUpload = useState<List<String>>([]);
    final addImageLoader = useState<bool>(false);

    getUserProfile() {
      final storage = locator<LocalStorageService>();
      _userRepository.getUserProfile().then((value) {
        pageLoading.value = false;
        userModel.value = value;
        ref.read(userProvider.notifier).state = value;
        log("###########");
        log(value.userId.toString());
        storage.saveDataToDisk(AppKeys.userId, value.userId);
      });
    }

    getPost() {
      _postRepository.getPost().then((value) {
        postLoading.value = false;
        postModel.value = value;
      });
    }

    likePost(String id) async {
      bool result = await _postRepository.likePost(id);
      if (result) {
        ref.read(refreshHomeScreen.notifier).state = !refresh;
      }
    }

    imageContainer(String imageString, int index) => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: "${Endpoints.displayImages}$imageString",
                  fit: BoxFit.cover,
                  width: 76,
                  height: 53,
                ),
              ),
            ),
            Positioned(
              top: 4,
              left: 70,
              child: GestureDetector(
                onTap: () {
                  imageList.value.removeAt(index);
                  imageToUpload.value.removeAt(index);
                  imageList.value = [...imageList.value];
                },
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: const BoxDecoration(
                      color: AppColors.black, shape: BoxShape.circle),
                  child: Center(
                      child: customText(
                          text: "x", fontSize: 9, textColor: AppColors.white)),
                ),
              ),
            )
          ],
        );

    void uploadImages() async {
      final XFile? image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (imageList.value.length < 4) {
        imageList.value = [...imageList.value, File(image!.path)];
        addImageLoader.value = true;
        String imageName = await _postRepository.addImage(
            File((image.path)), userModel.value!.userId.toString());

        log("###########");
        log(imageName);
        imageToUpload.value = [...imageToUpload.value, imageName];
        addImageLoader.value = false;
      }
    }

    showModalForVideo() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Colors.white,
          builder: (context) {
            return AddVideoModal(
              video: videoFile.value,
              userId: userModel.value!.userId!,
            );
          });
    }

    showModalForShareScreen(String postId) {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: Colors.white,
          builder: (context) {
            return ShareScreen(
              postId: postId,
            );
          });
    }

    Future uploadVideo() async {
      final video = await picker.pickVideo(
          source: ImageSource.gallery,
          maxDuration: const Duration(seconds: 30));
      if (video != null) {
        videoFile.value = File(video.path);

        log(videoFile.value.path);
        showModalForVideo();
      }
    }

    useEffect(() {
      getPost();
      getUserProfile();
      return null;
    }, [refresh]);
    Future<dynamic> deletePost(BuildContext context, postID) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  customText(
                      text: "Delete Post",
                      fontSize: 14,
                      textColor: AppColors.black),
                  heightSpace(3),
                  customText(
                      text: "Are you sure you want to Delete\nthis post",
                      textAlignment: TextAlign.center,
                      fontSize: 14,
                      textColor: AppColors.black),
                  heightSpace(3),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: customText(
                              text: "Cancel",
                              fontSize: 14,
                              textColor: AppColors.black),
                        ),
                        InkWell(
                          onTap: () async {
                            Navigator.of(context).pop();
                            bool result =
                                await _postRepository.deletePost(postID);
                            if (result) {
                              ToastResp.toastMsgError(resp: "Post Deleted");
                              getPost();
                            }
                          },
                          child: customText(
                            text: "Done",
                            fontSize: 14,
                            textColor: AppColors.red,
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          );
        },
      );
    }

    List<PopupMenuItem> listOfPopups(
        {String? postId,
        String? sourceId,
        String? imageUrl,
        required String post,
        String? shareId,
        String? videoUrl}) {
      return [
        if (userModel.value!.userId == sourceId)
          PopupMenuItem(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    deletePost(context, postId);
                  },
                  child: customText(
                      text: "Delete", fontSize: 12, textColor: AppColors.red)),
            ),
          ),
        if (userModel.value!.userId == sourceId)
          PopupMenuItem(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        backgroundColor: Colors.white,
                        builder: (context) {
                          return EditPostModal(
                            userId: userModel.value!.userId,
                            imageUrl: imageUrl,
                            postText: post,
                            postId: postId,
                            videoUrl: videoUrl,
                          );
                        });
                  },
                  child: customText(
                      text: "Edit Post",
                      fontSize: 12,
                      textColor: AppColors.black)),
            ),
          ),
        PopupMenuItem(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GestureDetector(
                onTap: () {
                  context.push(AppRoutes.reportPostUser, extra: postId!);
                },
                child: customText(
                    text: "Report Content",
                    fontSize: 12,
                    textColor: AppColors.black)),
          ),
        ),
        PopupMenuItem(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GestureDetector(
                onTap: () {
                  context.push(
                    AppRoutes.reportPostUser,
                    extra: userModel.value!.userId.toString(),
                  );
                },
                child: customText(
                    text: "Report User",
                    fontSize: 12,
                    textColor: AppColors.black)),
          ),
        ),
        PopupMenuItem(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  showModalForShareScreen(shareId ?? "");
                },
                child: customText(
                    text: "Share Post",
                    fontSize: 12,
                    textColor: AppColors.black)),
          ),
        ),
        PopupMenuItem(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: customText(
                    text: "Cancel", fontSize: 12, textColor: AppColors.red)),
          ),
        )
      ];
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          backgroundColor: AppColors.white,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          actions: [
            InkWell(
              onTap: () => context.push(AppRoutes.chatScreen),
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: SvgPicture.asset(AppImages.messageIcon),
              ),
            ),
            InkWell(
              onTap: () => context.push(AppRoutes.notification),
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: SvgPicture.asset(AppImages.notificationBell),
              ),
            )
          ],
          title: customText(
              text: "Chasescroll", fontSize: 20, textColor: AppColors.primary)),
      body: pageLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: postText,
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ChaseScrollContainer(
                                    name:
                                        "${userModel.value?.firstName} ${userModel.value?.lastName}",
                                    imageUrl:
                                        '${Endpoints.displayImages}/${userModel.value?.data?.imgMain?.value}',
                                  ),
                                ),
                                suffixIcon: InkWell(
                                  onTap: () async {
                                    // if (postText.text.isEmpty) {
                                    //   ToastResp.toastMsgError(
                                    //       resp: "Post can't be empty");
                                    //   return;
                                    // }
                                    bool result =
                                        await _postRepository.createPost(
                                            postText.text,
                                            userModel.value!.userId.toString(),
                                            imageToUpload.value.isEmpty
                                                ? null
                                                : imageToUpload.value.first,
                                            imageToUpload.value.isEmpty
                                                ? []
                                                : imageToUpload.value,
                                            imageToUpload.value.isEmpty
                                                ? null
                                                : "WITH_IMAGE");

                                    if (result) {
                                      ToastResp.toastMsgSuccess(
                                          resp: "Successfully Posted");
                                      postText.clear();

                                      imageToUpload.value = [];
                                      ref
                                          .read(refreshHomeScreen.notifier)
                                          .state = !refresh;
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(AppImages.sendIcon),
                                  ),
                                ),
                                filled: true,
                                fillColor: AppColors.textFormColor,
                                focusedBorder: AppColors.normalBorder,
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: AppColors.textFormColor),
                                    borderRadius: BorderRadius.circular(10)),
                                contentPadding: const EdgeInsets.all(10),
                                hintText:
                                    "Add your thoughts ${userModel.value?.firstName}",
                                hintStyle: GoogleFonts.dmSans(
                                    textStyle: const TextStyle(
                                        color: AppColors.black, fontSize: 12))),
                          ),
                          heightSpace(2),
                          Row(
                            children: [
                              if (imageToUpload.value.isNotEmpty)
                                SizedBox(
                                  height: 73,
                                  child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: imageToUpload.value
                                        .mapIndexed(
                                            (e, i) => imageContainer(e, i))
                                        .toList(),
                                  ),
                                ),
                              if (addImageLoader.value)
                                SizedBox(
                                    width: 76, height: 53, child: boxShimmer()),
                            ],
                          ),
                          heightSpace(1),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => uploadImages(),
                                child: SvgPicture.asset(
                                  AppImages.galleryIcon,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              widthSpace(3),
                              InkWell(
                                onTap: () {
                                  uploadVideo();
                                },
                                child: SvgPicture.asset(
                                  AppImages.videoIcon,
                                  height: 20,
                                  width: 20,
                                ),
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
                                    ...postModel.value!.content!.map((e) {
                                      final likedCount = useState<int>(0);

                                      final hasLiked = useState<bool>(false);

                                      likedCount.value = e.likeCount!;
                                      hasLiked.value = e.likeStatus == "LIKED"
                                          ? true
                                          : false;

                                      return Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          padding: const EdgeInsets.all(20),
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
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      context.push(
                                                        AppRoutes
                                                            .otherUsersProfile,
                                                        extra: e.user?.userId,
                                                      );
                                                    },
                                                    child: ChaseScrollContainer(
                                                      name:
                                                          "${e.user?.firstName} ${e.user?.lastName}",
                                                      imageUrl:
                                                          "${Endpoints.displayImages}${e.user?.data?.imgMain?.value}",
                                                    ),
                                                  ),
                                                  widthSpace(3),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      customText(
                                                          text:
                                                              "${e.user?.firstName} ${e.user?.lastName}",
                                                          fontSize: 12,
                                                          textColor:
                                                              AppColors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      customText(
                                                        text:
                                                            "${e.user?.username}",
                                                        fontSize: 8,
                                                        textColor:
                                                            AppColors.black,
                                                      ),
                                                      customText(
                                                        text: timeAgoFromEpoch(e
                                                            .timeInMilliseconds!),
                                                        fontSize: 8,
                                                        textColor:
                                                            AppColors.textGrey,
                                                      )
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  PopupMenuButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                    position:
                                                        PopupMenuPosition.under,
                                                    color: AppColors.white,
                                                    child: const Icon(
                                                      Icons.more_horiz,
                                                      size: 35,
                                                      color: Colors.black,
                                                    ),
                                                    itemBuilder: (context) {
                                                      return listOfPopups(
                                                          sourceId: e.sourceId,
                                                          postId: e.id!,
                                                          imageUrl:
                                                              '${Endpoints.displayImages}/${e.mediaRef}',
                                                          post: e.text!,
                                                          shareId:
                                                              e.shareID ?? "",
                                                          videoUrl: e.type ==
                                                                  "WITH_VIDEO_POST"
                                                              ? '${Endpoints.displayImages}/${e.mediaRef}'
                                                              : null);
                                                    },
                                                  )
                                                ],
                                              ),
                                              heightSpace(2),
                                              customText(
                                                  text: e.text!,
                                                  fontSize: 12,
                                                  textColor: AppColors.black),
                                              heightSpace(2),
                                              (() {
                                                log('${Endpoints.displayImages}/${e.mediaRef}');
                                                if (e.mediaRef != null) {
                                                  if (e.type ==
                                                      "WITH_VIDEO_POST") {
                                                    return AddVideoModal(
                                                        uri:
                                                            '${Endpoints.displayImages}/${e.mediaRef}');
                                                  }
                                                  return SizedBox(
                                                    height: 200,
                                                    child: e.multipleMediaRef!
                                                                .length >
                                                            1
                                                        ? PageView.builder(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount: e
                                                                .multipleMediaRef
                                                                ?.length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              log('${Endpoints.displayImages}/${e.multipleMediaRef![index]}');
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: PictureContainer(
                                                                    image: e.multipleMediaRef![
                                                                        index]),
                                                              );
                                                            })
                                                        : PictureContainer(
                                                            image: e.mediaRef!),
                                                  );
                                                }
                                                return const SizedBox.shrink();
                                              }()),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      heightSpace(2),
                                                      Row(
                                                        children: [
                                                          InkWell(
                                                              onTap: () {
                                                                if (hasLiked
                                                                    .value) {
                                                                  likedCount
                                                                          .value =
                                                                      likedCount
                                                                              .value -
                                                                          1;
                                                                  hasLiked.value =
                                                                      !hasLiked
                                                                          .value;
                                                                  likePost(
                                                                      e.id!);

                                                                  return;
                                                                }
                                                                if (likedCount
                                                                        .value <
                                                                    2) {
                                                                  likedCount
                                                                          .value =
                                                                      likedCount
                                                                              .value +
                                                                          1;
                                                                }
                                                                log(likedCount
                                                                    .value
                                                                    .toString());
                                                                hasLiked.value =
                                                                    !hasLiked
                                                                        .value;
                                                                likePost(e.id!);
                                                              },
                                                              child: hasLiked
                                                                      .value
                                                                  ? SvgPicture
                                                                      .asset(
                                                                      AppImages
                                                                          .favouriteFilled,
                                                                      color: AppColors
                                                                          .red,
                                                                    )
                                                                  : SvgPicture
                                                                      .asset(
                                                                      AppImages
                                                                          .like,
                                                                    )),
                                                          widthSpace(1),
                                                          customText(
                                                              text:
                                                                  "${likedCount.value}",
                                                              fontSize: 11,
                                                              textColor:
                                                                  AppColors
                                                                      .black)
                                                        ],
                                                      ),
                                                      heightSpace(1),
                                                      customText(
                                                          text: "React",
                                                          fontSize: 10,
                                                          textColor: AppColors
                                                              .textGrey)
                                                    ],
                                                  ),
                                                  InkWell(
                                                    onTap: () => context.push(
                                                        AppRoutes.comment,
                                                        extra: {
                                                          "userModel":
                                                              userModel.value,
                                                          "postId": e.id,
                                                          "imageUrl":
                                                              '${Endpoints.displayImages}${userModel.value?.data?.images}'
                                                        }),
                                                    child: Column(
                                                      children: [
                                                        heightSpace(2),
                                                        Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                                AppImages
                                                                    .comment),
                                                            widthSpace(1),
                                                            customText(
                                                                text:
                                                                    "${e.commentCount}",
                                                                fontSize: 11,
                                                                textColor:
                                                                    AppColors
                                                                        .black)
                                                          ],
                                                        ),
                                                        heightSpace(1),
                                                        customText(
                                                            text: "Comments",
                                                            fontSize: 10,
                                                            textColor: AppColors
                                                                .textGrey)
                                                      ],
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () =>
                                                        showModalForShareScreen(
                                                            e.id!),
                                                    child: Column(
                                                      children: [
                                                        heightSpace(2),
                                                        Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                                AppImages
                                                                    .share),
                                                            widthSpace(1),
                                                            customText(
                                                                text:
                                                                    "${e.shareCount}",
                                                                fontSize: 11,
                                                                textColor:
                                                                    AppColors
                                                                        .black)
                                                          ],
                                                        ),
                                                        heightSpace(1),
                                                        customText(
                                                            text: "Share",
                                                            fontSize: 10,
                                                            textColor: AppColors
                                                                .textGrey)
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ));
                                    })
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
