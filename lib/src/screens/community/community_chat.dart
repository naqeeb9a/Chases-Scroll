import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chases_scroll/src/models/commdata.dart';
import 'package:chases_scroll/src/models/post_model.dart';
import 'package:chases_scroll/src/providers/auth_provider.dart';
import 'package:chases_scroll/src/repositories/community_repo.dart';
import 'package:chases_scroll/src/repositories/post_repository.dart';
import 'package:chases_scroll/src/screens/community/model/group_model.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_shape.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/shimmer_.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/extensions/index_of_map.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:chases_scroll/src/utils/permissions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/keys.dart';
import '../../config/locator.dart';
import '../../config/router/routes.dart';
import '../../repositories/endpoints.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/helpers/change_millepoch.dart';

class CommunityChat extends HookConsumerWidget {
  static final post = TextEditingController();

  static final CommunityRepo _communityRepo = CommunityRepo();

  static final textPost = TextEditingController();
  static final ImagePicker picker = ImagePicker();
  static final PostRepository _postRepository = PostRepository();

  static final ScrollController _scrollController = ScrollController();
  final CommunityData communityData;
  const CommunityChat({super.key, required this.communityData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);
    final imageList = useState<List<File>>([]);
    final postModel = useState<PostModel?>(null);
    final isLoading = useState<bool>(true);
    final imageToUpload = useState<List<String>>([]);
    final locationValue = useState<String>("");
    final addImageLoader = useState<bool>(false);
    final fileLoader = useState<bool>(false);
    final pickFile = useState<File>(File(""));
    final refreshPage = useState<bool>(false);

    final postType = useState<String>('NO_IMAGE_POST');
    final userData = ref.watch(userProvider);
    Timer? timer;

    getLocation() async {
      Map<String, dynamic> location = await getCurrentPosition();

      log("this is the location");

      var text = "==Location${jsonEncode(location)}";

      log(text);
      if (context.mounted) {
        Navigator.pop(context);
      }
      post.text = text;
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

    callGroupChat() {
      _communityRepo.getGroupChat(communityData.groupId).then((value) {
        postModel.value = value;
      });
    }

    exitGroup(String groupId) async {
      bool result =
          await _communityRepo.leaveGroup(userId: userId, groupId: groupId);
      if (result) {
        ToastResp.toastMsgSuccess(
            resp: "You have successfully exited the group");
        if (context.mounted) {
          context.pop();
        }
      }
    }

    // void startTimer() {
    //   timer = Timer.periodic(const Duration(seconds: 10), (timer) {
    //     // callGroupChat();
    //   });
    // }

    likePost(String id) async {
      await _postRepository.likePost(id);
      callGroupChat();
    }

    getGroupChat() {
      _communityRepo.getGroupChat(communityData.groupId).then((value) {
        isLoading.value = false;
        postModel.value = value;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });
      });
    }

    void uploadFile() async {
      imageToUpload.value.clear();
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null && result.files.isNotEmpty) {
        pickFile.value = File(result.files.single.path!);
        fileLoader.value = true;
        String imageName =
            await _postRepository.addDocument(pickFile.value, userId);

        imageToUpload.value.add(imageName);
        fileLoader.value = false;
      }
    }

    void uploadImages(int camera) async {
      final XFile? image;
      if (camera == 0) {
        image = await picker.pickImage(
            source: ImageSource.camera, imageQuality: 70);
      } else if (camera == 1) {
        image = await picker.pickImage(
            source: ImageSource.gallery, imageQuality: 70);
      } else {
        log("it came here");
        image = await picker.pickVideo(
          source: ImageSource.gallery,
        );
      }
      if (imageList.value.length < 4) {
        addImageLoader.value = true;
        imageList.value = [...imageList.value, File(image!.path)];
        String imageName =
            await _postRepository.addImage(File((image.path)), userId);

        log("###########");
        log(imageName);
        imageToUpload.value = [...imageToUpload.value, imageName];
        addImageLoader.value = false;
      }
    }

    addComment(String postId, String comment) {
      _postRepository.addComment(postId, comment);
      ToastResp.toastMsgSuccess(
          resp: "Your comment has been added successfully");
       callGroupChat();
    }

    addSubComment(String postId, String comment) {
      _postRepository.addSubComment(postId, comment);
       callGroupChat();
    }

    createPost() async {
      if (imageToUpload.value.isNotEmpty) {
        postType.value = 'WITH_IMAGE';
      }
      if (pickFile.value.path.isNotEmpty) {
        postType.value = 'WITH_FILE';
      }
      _communityRepo.createPost(
          post.text,
          communityData.groupId!,
          communityData.groupId!,
          imageToUpload.value.isEmpty ? '' : imageToUpload.value[0],
          imageToUpload.value,
          postType.value);

      post.clear();
      imageToUpload.value.clear();
      imageList.value.clear();

      imageList.value = [...imageList.value];
      pickFile.value = File("");
      postType.value = 'NO_IMAGE_POST';
      refreshPage.value = !refreshPage.value;
    }

    useEffect(() {
      post.clear();
      getGroupChat();
      // startTimer();
      return null;
    }, [refreshPage.value]);

    imageDialogContainer(String imageUrl) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Expanded(
            child: Dialog(
                child: Container(
                    width: 342,
                    height: 233,
                    // padding:
                    //     const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: imageUrl,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ))),
          );
        },
      );
    }

    uploadDocuments() {
      showModalBottomSheet(
        builder: (context) {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: double.infinity,
              height: 230,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        uploadImages(0);
                        Navigator.pop(context);
                      },
                      child: Row(children: [
                        SvgPicture.asset(AppImages.camera,
                            color: AppColors.primary),
                        widthSpace(2),
                        customText(
                            text: "Camera",
                            fontSize: 12,
                            textColor: AppColors.black)
                      ]),
                    ),
                    const Divider(color: AppColors.grey),
                    InkWell(
                      onTap: () {
                        uploadImages(1);
                        Navigator.pop(context);
                      },
                      child: Row(children: [
                        SvgPicture.asset(AppImages.imageIcon,
                            color: AppColors.primary, width: 20, height: 20),
                        widthSpace(2),
                        customText(
                            text: "Photo",
                            fontSize: 12,
                            textColor: AppColors.black)
                      ]),
                    ),
                    const Divider(color: AppColors.grey),
                    InkWell(
                      onTap: () {
                        uploadImages(2);
                        Navigator.pop(context);
                      },
                      child: Row(children: [
                        SvgPicture.asset(AppImages.imageIcon,
                            color: AppColors.primary, width: 20, height: 20),
                        widthSpace(2),
                        customText(
                            text: "Video Libary",
                            fontSize: 12,
                            textColor: AppColors.black)
                      ]),
                    ),
                    const Divider(color: AppColors.grey),
                    InkWell(
                      onTap: () {
                        uploadFile();
                        Navigator.pop(context);
                      },
                      child: Row(children: [
                        SvgPicture.asset(AppImages.document,
                            color: AppColors.primary, width: 20, height: 20),
                        widthSpace(2),
                        customText(
                            text: "Document",
                            fontSize: 12,
                            textColor: AppColors.black)
                      ]),
                    ),
                    const Divider(color: AppColors.grey),
                    InkWell(
                      onTap: () {
                        getLocation();
                      },
                      child: Row(children: [
                        SvgPicture.asset(AppImages.location,
                            color: AppColors.primary, width: 20, height: 20),
                        widthSpace(3),
                        customText(
                            text: "Location",
                            fontSize: 12,
                            textColor: AppColors.black)
                      ]),
                    ),
                  ],
                ),
              ));
        },
        context: context,
      );
    }

    List<PopupMenuItem> listOfPopups(String groupId) {
      return [
        PopupMenuItem(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  context.push(AppRoutes.communityInfo,
                      extra: CommunityInfoModel(
                          isPublic: communityData.isPublic,
                          description: communityData.description,
                          groupId: communityData.groupId,
                          name: communityData.name,
                          image: communityData.imageUrl));
                },
                child: customText(
                    text: "Community Info",
                    fontSize: 12,
                    textColor: AppColors.black)),
          ),
        ),
        // PopupMenuItem(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        //     child: GestureDetector(
        //         onTap: () {
        //           Navigator.pop(context);
        //         },
        //         child: customText(
        //             text: "Mute Notification",
        //             fontSize: 12,
        //             textColor: AppColors.black)),
        //   ),
        // ),
        // PopupMenuItem(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        //     child: GestureDetector(
        //         onTap: () {
        //           Navigator.pop(context);
        //           exitGroup(groupId);
        //         },
        //         child: customText(
        //             text: "Exit community",
        //             fontSize: 12,
        //             textColor: AppColors.red)),
        //   ),
        // ),
        PopupMenuItem(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  context.push(AppRoutes.reportCommunity,
                      extra: communityData.groupId);
                },
                child: customText(
                    text: "Report Community",
                    fontSize: 12,
                    textColor: AppColors.red)),
          ),
        ),
        PopupMenuItem(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: customText(
                    text: "Cancel", fontSize: 12, textColor: AppColors.red)),
          ),
        ),
      ];
    }

    void commentModal(int index, List<Commentcontent>? content) {
      PostModel postModel = PostModel();
      final subComment = TextEditingController();
      bool isLoading = true;
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            getComment() {
              _communityRepo.getGroupChat(communityData.groupId).then((value) {
                if (context.mounted) {
                  setState(() {
                    isLoading = false;
                    postModel = value;
                  });
                }
              });
            }

            getComment();

            return Consumer(builder: (context, WidgetRef ref, _) {
              return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  height: 700,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        AppImages.chatBackground,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SingleChildScrollView(
                      controller: _scrollController,
                      child: isLoading
                          ? const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 200, vertical: 50),
                              child: CircularProgressIndicator(),
                            )
                          : Column(children: [
                              ...(postModel.content?[index].comments?.content??[])
                                  .mapIndexed((element, index) {
                                final hasTapped =
                                    ref.watch(hasTappedComment(index));

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 300,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 1),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(15),
                                          ),
                                          color: AppColors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ChaseScrollContainer(
                                                    name:
                                                        "${element.user?.firstName} ${element.user?.lastName}",
                                                    imageUrl:
                                                        '${Endpoints.displayImages}/${element.user?.data?.imgMain?.value}',
                                                  ),
                                                  widthSpace(2),
                                                  Flexible(
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          customText(
                                                              text:
                                                                  "${element.user?.username}",
                                                              fontSize: 8,
                                                              textColor: AppColors
                                                                  .primary,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          heightSpace(.5),
                                                          customText(
                                                            text:
                                                                "${element.comment}",
                                                            fontSize: 10,
                                                            textColor:
                                                                AppColors.black,
                                                          ),
                                                        ]),
                                                  )
                                                ]),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: customText(
                                                  text: formatEpoch(element
                                                      .timeInMilliseconds!),
                                                  fontSize: 9,
                                                  textColor:
                                                      AppColors.textGrey),
                                            )
                                          ],
                                        ),
                                      ),
                                      heightSpace(1),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 220,
                                            height: 50,
                                            child: TextFormField(
                                              maxLines: null,
                                              style:
                                                  const TextStyle(fontSize: 10),
                                              controller: subComment,
                                              decoration: InputDecoration(
                                                suffixIcon: InkWell(
                                                  onTap: () {
                                                    if (subComment
                                                        .text.isEmpty) {
                                                      ToastResp.toastMsgSuccess(
                                                          resp:
                                                              "Comment can't be empty");
                                                      return;
                                                    }
                                                    addSubComment(element.id!,
                                                        subComment.text);
                                                    getComment();
                                                    setState(() {});
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 17),
                                                    child: customText(
                                                        text: "Post",
                                                        fontSize: 10,
                                                        textColor:
                                                            AppColors.primary),
                                                  ),
                                                ),
                                                prefixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ChaseScrollContainer(
                                                    name:
                                                        "${userData?.firstName} ${userData?.lastName}",
                                                    imageUrl:
                                                        '${Endpoints.displayImages}/${userData?.data?.imgMain?.value}',
                                                  ),
                                                ),
                                                hintText: "Add your comment...",
                                                filled: true,
                                                fillColor: AppColors.white,
                                                focusedBorder:
                                                    AppColors.normalBorder,
                                                hintStyle: GoogleFonts.dmSans(
                                                    textStyle: const TextStyle(
                                                        color: AppColors.black,
                                                        fontSize: 10)),
                                                enabledBorder:
                                                    const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: AppColors
                                                                .textFormColor),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          topRight:
                                                              Radius.circular(
                                                                  20),
                                                        )),
                                                contentPadding:
                                                    const EdgeInsets.all(10),
                                              ),
                                            ),
                                          ),
                                          widthSpace(1),
                                          GestureDetector(
                                              onTap: () {
                                                print("what is goin on");
                                                log("this has been clicked");
                                              },
                                              child: customText(
                                                  text:
                                                      "${element.likeCount} likes",
                                                  fontSize: 8,
                                                  textColor:
                                                      AppColors.primary)),
                                          widthSpace(1),
                                          GestureDetector(
                                            onTap: () {
                                              ref
                                                  .read(hasTappedComment(index)
                                                      .notifier)
                                                  .state = !hasTapped;
                                              print("Reply is clicked");
                                            },
                                            child: customText(
                                                text:
                                                    "${element.subComments!.content?.length} replies",
                                                fontSize: 8,
                                                textColor: AppColors.primary),
                                          )
                                        ],
                                      ),
                                      heightSpace(1),
                                      if (hasTapped &&
                                          element
                                              .subComments!.content!.isNotEmpty)
                                        Container(
                                            width: 270,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(15),
                                              ),
                                              color: AppColors.white,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ...element.subComments!.content!
                                                    .mapIndexed((e, i) {
                                                  return Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                ChaseScrollContainer(
                                                              name:
                                                                  "${element.user?.firstName} ${element.user?.lastName}",
                                                              imageUrl:
                                                                  '${Endpoints.displayImages}/${element.user?.data?.imgMain?.value}',
                                                            ),
                                                          ),
                                                          widthSpace(2),
                                                          Flexible(
                                                            child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  customText(
                                                                      text:
                                                                          " -   ${element.user?.firstName} ${element.user?.lastName}",
                                                                      fontSize:
                                                                          8,
                                                                      textColor:
                                                                          AppColors
                                                                              .red),
                                                                  customText(
                                                                      text:
                                                                          "${element.comment}",
                                                                      fontSize:
                                                                          10,
                                                                      textColor:
                                                                          AppColors
                                                                              .black),
                                                                  customText(
                                                                      text: formatEpoch(
                                                                          element
                                                                              .timeInMilliseconds!),
                                                                      fontSize:
                                                                          9,
                                                                      textColor:
                                                                          AppColors
                                                                              .textGrey),
                                                                ]),
                                                          )
                                                        ],
                                                      ),
                                                      const Divider(
                                                          color: AppColors
                                                              .backgroundGrey)
                                                    ],
                                                  );
                                                })
                                              ],
                                            ))
                                    ],
                                  ),
                                );
                            
                              })
                            ])));
            });
          });
        },
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Column(
          children: [
            heightSpace(4),
            Row(children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios),
              ),
              GestureDetector(
                onTap: () => context.push(AppRoutes.communityInfo,
                    extra: CommunityInfoModel(
                        description: communityData.description,
                        groupId: communityData.groupId,
                        name: communityData.name,
                        image: communityData.imageUrl)),
                child: SizedBox(
                  height: 30,
                  width: 50,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        child: Container(
                          width: 30,
                          height: 30,
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
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(0),
                            ),
                            color: const Color(0xFF9DA8FB),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 8,
                        child: ChaseScrollContainer(
                          name: "${communityData.name}",
                          imageUrl:
                              '${Endpoints.displayImages}${communityData.imageUrl}',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              widthSpace(1),
              GestureDetector(
                onTap: () => context.push(AppRoutes.communityInfo,
                    extra: CommunityInfoModel(
                        description: communityData.description,
                        groupId: communityData.groupId,
                        name: communityData.name,
                        image: communityData.imageUrl)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText(
                        text: "${communityData.name}",
                        fontSize: 14,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.bold),
                    customText(
                        text: "${communityData.description}",
                        fontSize: 10,
                        textColor: AppColors.textGrey),
                  ],
                ),
              ),
              const Spacer(),
              PopupMenuButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  position: PopupMenuPosition.under,
                  itemBuilder: ((context) {
                    return listOfPopups(communityData.groupId!);
                  }),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: SvgPicture.asset(AppImages.infoCircle),
                  )),
            ]),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xffE5E5E5),
          image: DecorationImage(
            image: AssetImage(
              AppImages.chatBackground,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  Expanded(
                    child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: [
                            heightSpace(2),
                            ...postModel.value!.content!
                                .mapIndexed((element, index) {
                              log(userId);
                              final comment = TextEditingController();
                              Placemark? address;
                              if (element.text?.contains("==Location") ??
                                  false) {
                                var text =
                                    element.text?.replaceAll("==Location", "");
                                var data = jsonDecode(text!);
                                address = Placemark.fromMap(data);
                              }
                              final likedCount =
                                  useState<int>(element.likeCount!);

                              final hasLiked = useState<bool>(
                                  element.likeStatus == "LIKED" ? true : false);

                              final hasClickedOnComment = useState<bool>(false);

                              return Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: element.user!.userId ==
                                                json.decode(json.encode(userId))
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: (() {
                                          if (address != null) {
                                            return InkWell(
                                              onTap: () {
                                                _communityRepo.launchMapOnAddress(
                                                    "${address!.street!} ${address.subLocality!} ${address.locality!}, ${address.administrativeArea!} ${address.country!}");
                                              },
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      const Radius.circular(12),
                                                  bottomRight: element
                                                              .user!.userId ==
                                                          userId
                                                      ? const Radius.circular(0)
                                                      : const Radius.circular(
                                                          12),
                                                  topLeft: element
                                                              .user!.userId ==
                                                          userId
                                                      ? const Radius.circular(
                                                          12)
                                                      : const Radius.circular(
                                                          0),
                                                  topRight:
                                                      const Radius.circular(12),
                                                ),
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.all(9),
                                                    height: 120,
                                                    width: 270,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: AppColors.primary,
                                                    ),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          customText(
                                                              text:
                                                                  "${element.user?.username}",
                                                              fontSize: 8,
                                                              textColor:
                                                                  AppColors
                                                                      .white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          Container(
                                                            height: 60,
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            decoration: const BoxDecoration(
                                                                image: DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image: AssetImage(
                                                                        AppImages
                                                                            .mapPic))),
                                                          ),
                                                          customText(
                                                              text:
                                                                  "${element.text}",
                                                              fontSize: 10,
                                                              textColor:
                                                                  AppColors
                                                                      .white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ])),
                                              ),
                                            );
                                          }
                                          return SizedBox(
                                            width: 320,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ChaseScrollContainer(
                                                      name:
                                                          "${element.user?.firstName} ${element.user?.lastName}",
                                                      imageUrl:
                                                          '${Endpoints.displayImages}/${element.user?.data?.imgMain?.value}',
                                                    ),
                                                    widthSpace(2),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          width: 250,
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            20),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            0),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            20),
                                                                  )),
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                customText(
                                                                    text:
                                                                        "${element.user?.username}",
                                                                    fontSize: 8,
                                                                    textColor:
                                                                        AppColors
                                                                            .primary,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                heightSpace(1),
                                                                if (element
                                                                        .type ==
                                                                    "WITH_FILE")
                                                                  InkWell(
                                                                    onTap: () {
                                                                      _communityRepo
                                                                          .launchLink(
                                                                              "${Endpoints.displayImages}${element.mediaRef}");
                                                                    },
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Flexible(
                                                                          child: customText(
                                                                              text: element.mediaRef.toString(),
                                                                              fontSize: 10,
                                                                              textColor: AppColors.black),
                                                                        ),
                                                                        SvgPicture.asset(
                                                                            AppImages.downloadIcon)
                                                                      ],
                                                                    ),
                                                                  ),
                                                                if (element
                                                                        .type ==
                                                                    "WITH_IMAGE")
                                                                  SizedBox(
                                                                    height: 200,
                                                                    width: double
                                                                        .infinity,
                                                                    child: element
                                                                            .multipleMediaRef!
                                                                            .isEmpty
                                                                        ? InkWell(
                                                                            onTap: () =>
                                                                                imageDialogContainer("${Endpoints.displayImages}${element.mediaRef}"),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.only(
                                                                                bottomLeft: const Radius.circular(12),
                                                                                bottomRight: element.user!.userId == userId ? const Radius.circular(0) : const Radius.circular(12),
                                                                                topLeft: element.user!.userId == userId ? const Radius.circular(12) : const Radius.circular(0),
                                                                                topRight: const Radius.circular(12),
                                                                              ),
                                                                              child: CachedNetworkImage(
                                                                                fit: BoxFit.cover,
                                                                                imageUrl: "${Endpoints.displayImages}${element.mediaRef}",
                                                                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : PageView
                                                                            .builder(
                                                                            itemCount:
                                                                                element.multipleMediaRef?.length ?? 0,
                                                                            onPageChanged:
                                                                                (int pageIndex) {},
                                                                            itemBuilder:
                                                                                (context, index) {
                                                                              String images = element.multipleMediaRef![index];

                                                                              if (element.multipleMediaRef!.isEmpty) {
                                                                                images = element.mediaRef!;
                                                                              }

                                                                              log(element.multipleMediaRef!.isEmpty.toString());
                                                                              return ClipRRect(
                                                                                borderRadius: BorderRadius.only(
                                                                                  bottomLeft: const Radius.circular(12),
                                                                                  bottomRight: element.user!.userId == userId ? const Radius.circular(0) : const Radius.circular(12),
                                                                                  topLeft: element.user!.userId == userId ? const Radius.circular(12) : const Radius.circular(0),
                                                                                  topRight: const Radius.circular(12),
                                                                                ),
                                                                                child: Stack(
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      height: 200,
                                                                                      width: 150,
                                                                                      child: CachedNetworkImage(
                                                                                        fit: BoxFit.cover,
                                                                                        imageUrl: "${Endpoints.displayImages}$images}",
                                                                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                                                                      ),
                                                                                    ),
                                                                                    BackdropFilter(
                                                                                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                                                                      child: Container(
                                                                                        color: Colors.transparent,
                                                                                      ),
                                                                                    ),
                                                                                    Center(
                                                                                        child: InteractiveViewer(
                                                                                      boundaryMargin: const EdgeInsets.all(20.0),
                                                                                      minScale: 0.1,
                                                                                      maxScale: 5.0,
                                                                                      child: CachedNetworkImage(
                                                                                        fit: BoxFit.contain,
                                                                                        imageUrl: "${Endpoints.displayImages}$images}",
                                                                                        placeholder: (context, url) => const SizedBox(
                                                                                          height: 20,
                                                                                          width: 20,
                                                                                          child: CircularProgressIndicator(color: AppColors.primary),
                                                                                        ),
                                                                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                                                                      ),
                                                                                    )),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                  ),
                                                                customText(
                                                                  text:
                                                                      "${element.text}",
                                                                  fontSize: 11,
                                                                  textColor:
                                                                      AppColors
                                                                          .black,
                                                                )
                                                              ]),
                                                        ),
                                                        heightSpace(1),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 200,
                                                              height: 45,
                                                              child:
                                                                  TextFormField(
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        10.0),
                                                                controller:
                                                                    comment,
                                                                decoration:
                                                                    InputDecoration(
                                                                  suffixIcon:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      if (comment
                                                                          .text
                                                                          .isEmpty) {
                                                                        ToastResp.toastMsgSuccess(
                                                                            resp:
                                                                                "Comment can't be empty");
                                                                        return;
                                                                      }
                                                                      addComment(
                                                                          element
                                                                              .id!,
                                                                          comment
                                                                              .text);
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              17),
                                                                      child: customText(
                                                                          text:
                                                                              "Post",
                                                                          fontSize:
                                                                              9,
                                                                          textColor:
                                                                              AppColors.primary),
                                                                    ),
                                                                  ),
                                                                  prefixIcon:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                    child:
                                                                        ChaseScrollContainer(
                                                                      name:
                                                                          "${userData?.firstName} ${userData?.lastName}",
                                                                      imageUrl:
                                                                          '${Endpoints.displayImages}/${userData?.data?.imgMain?.value}',
                                                                    ),
                                                                  ),
                                                                  hintText:
                                                                      "Add your comment...",
                                                                  filled: true,
                                                                  fillColor:
                                                                      AppColors
                                                                          .white,
                                                                  focusedBorder:
                                                                      AppColors
                                                                          .normalBorder,
                                                                  hintStyle: GoogleFonts.dmSans(
                                                                      textStyle: const TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize:
                                                                              10)),
                                                                  enabledBorder:
                                                                      const UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: AppColors.textFormColor),
                                                                          borderRadius: BorderRadius.only(
                                                                            bottomLeft:
                                                                                Radius.circular(20),
                                                                            bottomRight:
                                                                                Radius.circular(0),
                                                                            topLeft:
                                                                                Radius.circular(20),
                                                                            topRight:
                                                                                Radius.circular(20),
                                                                          )),
                                                                  contentPadding:
                                                                      const EdgeInsets
                                                                          .all(10),
                                                                ),
                                                              ),
                                                            ),
                                                            widthSpace(1),
                                                            InkWell(
                                                              onTap: () {
                                                                log(hasLiked
                                                                    .value
                                                                    .toString());

                                                                if (hasLiked
                                                                    .value) {
                                                                  likedCount
                                                                          .value =
                                                                      likedCount
                                                                              .value -
                                                                          1;
                                                                  log(likedCount
                                                                      .value
                                                                      .toString());
                                                                  likePost(
                                                                      element
                                                                          .id!);
                                                                  hasLiked.value =
                                                                      !hasLiked
                                                                          .value;
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
                                                                likePost(element
                                                                    .id!);
                                                              },
                                                              child: Stack(
                                                                children: [
                                                                  hasLiked.value
                                                                      ? SvgPicture.asset(
                                                                          AppImages
                                                                              .favouriteFilled,
                                                                          color: AppColors
                                                                              .red,
                                                                          width:
                                                                              25,
                                                                          height:
                                                                              25)
                                                                      : SvgPicture
                                                                          .asset(
                                                                          width:
                                                                              25,
                                                                          height:
                                                                              25,
                                                                          AppImages
                                                                              .like,
                                                                        ),
                                                                  Positioned(
                                                                    right: 0,
                                                                    child:
                                                                        Container(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              2),
                                                                      color: AppColors
                                                                          .white,
                                                                      child: Center(
                                                                          child: customText(
                                                                              text: '${likedCount.value}',
                                                                              fontSize: 8,
                                                                              textColor: AppColors.black)),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            widthSpace(1),
                                                            InkWell(
                                                              onTap: () {
                                                                if (element
                                                                        .commentCount! >
                                                                    0) {
                                                                  commentModal(
                                                                      index,
                                                                      element
                                                                          .comments!
                                                                          .content);
                                                                }
                                                              },
                                                              child: Stack(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    AppImages
                                                                        .addComment,
                                                                    width: 25,
                                                                    height: 25,
                                                                  ),
                                                                  Positioned(
                                                                    right: 0,
                                                                    child:
                                                                        Container(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              2),
                                                                      color: AppColors
                                                                          .white,
                                                                      child: Center(
                                                                          child: customText(
                                                                              text: '${element.commentCount}',
                                                                              fontSize: 8,
                                                                              textColor: AppColors.black)),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                heightSpace(1),
                                                const Divider(
                                                  color: AppColors.grey,
                                                )
                                              ],
                                            ),
                                          );
                                        }())),
                                    heightSpace(1),
                                  ],
                                ),
                              );
                            })
                          ],
                        )),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          if (imageToUpload.value.isNotEmpty &&
                              pickFile.value.path.isEmpty)
                            SizedBox(
                              height: 73,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: imageToUpload.value
                                    .mapIndexed((e, i) => imageContainer(e, i))
                                    .toList(),
                              ),
                            ),
                          if (addImageLoader.value)
                            SizedBox(
                                width: 76, height: 53, child: boxShimmer()),
                        ],
                      ),
                      if (pickFile.value.path.isNotEmpty)
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: Colors.white,
                            ),
                            width: double.infinity,
                            height: 80,
                            child: fileLoader.value
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Column(children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          customText(
                                              text: "Selected Document",
                                              fontSize: 9,
                                              textColor: AppColors.primary),
                                          InkWell(
                                            onTap: () {
                                              pickFile.value = File("");
                                              imageToUpload.value.clear();
                                            },
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.close_rounded,
                                                  color: Colors.red,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          )
                                        ]),
                                    heightSpace(1),
                                    customText(
                                        text: pickFile.value.path,
                                        fontSize: 10,
                                        textColor: AppColors.black)
                                  ])),
                      heightSpace(1),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: uploadDocuments,
                              child: SvgPicture.asset(AppImages.addDocument)),
                          Expanded(
                              child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, left: 5.0),
                            child: TextFormField(
                              controller: post,
                              decoration: InputDecoration(
                                hintText: "Add Post here",
                                suffixIcon: InkWell(
                                  onTap: createPost,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(AppImages.sendIcon),
                                  ),
                                ),
                                filled: true,
                                fillColor: AppColors.white,
                                focusedBorder: AppColors.normalBorder,
                                hintStyle: GoogleFonts.dmSans(
                                    textStyle: const TextStyle(
                                        color: AppColors.black, fontSize: 12)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: AppColors.textFormColor),
                                    borderRadius: BorderRadius.circular(10)),
                                contentPadding: const EdgeInsets.all(10),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ],
                  )
                ]),
              ),
      ),
    );
  }
}
