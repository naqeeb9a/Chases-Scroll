import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/models/members.dart';
import 'package:chases_scroll/src/repositories/community_repo.dart';
import 'package:chases_scroll/src/repositories/post_repository.dart';
import 'package:chases_scroll/src/screens/community/model/group_model.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_shape.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/helpers/extract_first_letter.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/keys.dart';
import '../../config/locator.dart';
import '../../repositories/endpoints.dart';

class CommunityInfo extends HookWidget {
  static final CommunityRepo communityRepo = CommunityRepo();
  static final ImagePicker picker = ImagePicker();
  final CommunityInfoModel communityInfoModel;
  final PostRepository _postRepository = PostRepository();

  CommunityInfo({super.key, required this.communityInfoModel});

  @override
  Widget build(BuildContext context) {
    final groupMembers = useState<GroupMembers?>(null);
    final initialContent = useState<GroupMembers?>(null);
    final isLoading = useState<bool>(true);
    final memberCount = useState<int>(0);
    final imageValue = useState<File>(File(''));
    final imageString = useState<String>('');
    final keys = locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);
    getGroupMembers() {
      communityRepo.getGroupMembers(communityInfoModel.groupId!).then((value) {
        isLoading.value = false;
        groupMembers.value = value;
        memberCount.value = value.content!.length;
        initialContent.value = value;
      });
    }

    exitGroup() async {
      final userId =
          locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);
      bool result = await communityRepo.leaveGroup(
          userId: userId, groupId: communityInfoModel.groupId!);
      if (result) {
        ToastResp.toastMsgSuccess(
            resp: "You have successfully exited the group");
        if (context.mounted) {
          context.pop();
        }
      }
    }

    exitDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Expanded(
            child: Dialog(
                child: Container(
              width: 342,
              height: 233,
              padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 18),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Exit Community?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                      height: 0.08,
                      letterSpacing: -0.41,
                    ),
                  ),
                  const SizedBox(height: 12),
                  customText(
                      text: " By exiting this Community, you won’t \n",
                      textColor: AppColors.black,
                      fontSize: 12),
                  customText(
                      text: " have access to the event and happenings",
                      textColor: AppColors.black,
                      fontSize: 12),
                  customText(
                      text: "within the ${communityInfoModel.name} Community",
                      textColor: AppColors.black,
                      fontSize: 12),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xB20F1728),
                              fontSize: 14,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: -0.23,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => exitGroup(),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Exit',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF007AFF),
                              fontSize: 14,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: -0.23,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
          );
        },
      );
    }

    void uploadImages() async {
      final XFile? image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (image != null) {
        imageValue.value = File(image.path);
        String imageName =
            await _postRepository.addImage(File((image.path)), keys);

        imageString.value = '${Endpoints.displayImages}/$imageName';
        log(imageName);
      }
    }

    useEffect(() {
      getGroupMembers();
      imageString.value =
          "${Endpoints.displayImages}${communityInfoModel.image}";

      log(imageString.value);
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            imageString.value.isEmpty
                ? Center(
                    child: GestureDetector(
                        onTap: () => uploadImages(),
                        child: SvgPicture.asset(AppImages.communityAdd)))
                : Center(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(0),
                                ),
                                border: Border.all(color: AppColors.primary)),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(0),
                              ),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: imageString.value,
                                height: 100,
                                width: 150,
                                errorWidget: (context, url, error) {
                                  return Center(
                                      child: customText(
                                          text: extractFirstLetters(
                                              "${communityInfoModel.name}"),
                                          fontSize: 25,
                                          textColor: AppColors.primary));
                                },
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                  width: 1.2,
                                  color: Colors.black45,
                                ),
                              ),
                              child: Center(
                                child: GestureDetector(
                                  onTap: uploadImages,
                                  child: const Icon(
                                    Icons.camera_alt_rounded,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
            heightSpace(2),
            customText(
                text: "${communityInfoModel.name}",
                fontSize: 16,
                textColor: AppColors.primary,
                fontWeight: FontWeight.bold),
            customText(
                text: "${memberCount.value} Members",
                fontSize: 12,
                textColor: AppColors.searchTextGrey,
                fontWeight: FontWeight.bold),
            heightSpace(1),
            AppTextFormField(
              prefixIcon: SvgPicture.asset(AppImages.searchIcon),
              hintText: "Search",
              onChanged: (query) {
                if (query.isNotEmpty) {
                  List<Content> filteredUsers = groupMembers.value!.content!
                      .where((user) =>
                          "${user.user?.firstName} ${user.user?.lastName}"
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                      .toList();

                  groupMembers.value = GroupMembers(content: filteredUsers);
                  return;
                }
                groupMembers.value = initialContent.value;
              },
              hasBorder: true,
            ),
            heightSpace(2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => context.push(AppRoutes.createCommunity,
                      extra: communityInfoModel),
                  child: Container(
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
                          SvgPicture.asset(
                            AppImages.edit,
                          ),
                          heightSpace(.5),
                          customText(
                              text: "Edit",
                              fontSize: 10,
                              textColor: AppColors.primary)
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () => exitDialog(),
                  child: Container(
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
                ),
                // Container(
                //     width: 100,
                //     height: 64,
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                //     decoration: ShapeDecoration(
                //       color: const Color(0xFFF0F2F9),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(12),
                //       ),
                //       shadows: const [
                //         BoxShadow(
                //           color: Color(0x19000000),
                //           blurRadius: 3,
                //           offset: Offset(0, 1),
                //           spreadRadius: 1,
                //         )
                //       ],
                //     ),
                //     child: Column(
                //       children: [
                //         SvgPicture.asset(AppImages.settings),
                //         heightSpace(.5),
                //         customText(
                //             text: "Settings",
                //             fontSize: 10,
                //             textColor: AppColors.primary)
                //       ],
                //     ))
              ],
            ),
            heightSpace(2),
            isLoading.value
                ? const CircularProgressIndicator()
                : Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: ListView.builder(
                          itemCount: groupMembers.value?.content?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      ChaseScrollContainer(
                                        name:
                                            "${groupMembers.value?.content?[index].user?.firstName} ${groupMembers.value?.content?[index].user?.lastName}",
                                        imageUrl:
                                            "${groupMembers.value?.content?[index].user?.data?.imgMain?.value}",
                                      ),
                                      widthSpace(3),
                                      customText(
                                          text:
                                              "${groupMembers.value?.content?[index].user?.firstName} ${groupMembers.value?.content?[index].user?.lastName}",
                                          fontSize: 14,
                                          textColor: AppColors.black),
                                      const Spacer(),
                                      groupMembers.value?.content?[index]
                                                  .role ==
                                              "ADMIN"
                                          ? customText(
                                              text: "ADMIN",
                                              fontSize: 12,
                                              textColor: AppColors.primary)
                                          : const SizedBox.shrink()
                                    ],
                                  ),
                                  const Divider(
                                    color: AppColors.grey,
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  )
          ]),
        ),
      ),
    );
  }
}
