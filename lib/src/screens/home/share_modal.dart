import 'dart:developer';

import 'package:chases_scroll/src/models/user_list_model.dart';
import 'package:chases_scroll/src/repositories/post_repository.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_shape.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/keys.dart';
import '../../config/locator.dart';

class ShareScreen extends HookWidget {
  static PostRepository getPostRepository = PostRepository();
  final String postId;
  const ShareScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final userListModel = useState<UserListModel?>(null);
    final initialConent = useState<UserListModel?>(null);
    final isLoading = useState<bool>(true);
    final friends = useState<List<String>>([]);

    getAllUserSuggestions() {
      final userId =
          locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);
      getPostRepository.getFriends(userId).then((value) {
        isLoading.value = false;
        userListModel.value = value;
        initialConent.value = value;
      });
    }

    sharePost() {
      getPostRepository.sharePost(postId, friends.value);
    }

    useEffect(() {
      getAllUserSuggestions();
      return null;
    }, []);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      width: double.infinity,
      height: 600,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: const Icon(
                    Icons.close,
                    size: 22,
                    color: Colors.black87,
                  ),
                ),
                customText(
                    text: "Select Friend",
                    fontSize: 14,
                    textColor: AppColors.black),
                GestureDetector(
                  onTap: () {
                    if (friends.value.isEmpty) {
                      ToastResp.toastMsgError(resp: "Select friends to share");
                      return;
                    }
                    sharePost();
                  },
                  child: customText(
                      text: "Done", fontSize: 14, textColor: AppColors.primary),
                )
              ],
            ),
            heightSpace(2),
            TextFormField(
              decoration: InputDecoration(
                focusedBorder: AppColors.normalBorder,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppColors.textFormColor),
                    borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.all(10),
                hintText: "Gboye Samuel",
                hintStyle: GoogleFonts.dmSans(
                    textStyle:
                        const TextStyle(color: AppColors.black, fontSize: 12)),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(AppImages.search),
                ),
              ),
              onChanged: (query) {
                // Filter the user list based on the query

                if (query.isNotEmpty) {
                  List<Content> filteredUsers = userListModel.value!.content!
                      .where((user) => "${user.firstName} ${user.lastName}"
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();

                  // Update the displayed list
                  userListModel.value = UserListModel(content: filteredUsers);
                  return;
                }
                userListModel.value = initialConent.value;
              },
            ),
            heightSpace(2),
            isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      ...userListModel.value!.content!.map((e) {
                        final isShared = useState<bool>(false);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ChaseScrollContainer(
                                  name: "${e.firstName} ${e.lastName}"),
                              widthSpace(5),
                              Column(
                                children: [
                                  customText(
                                      text: "${e.firstName} ${e.lastName}",
                                      fontSize: 12,
                                      textColor: AppColors.black)
                                ],
                              ),
                              const Spacer(),
                              isShared.value
                                  ? GestureDetector(
                                      onTap: () {
                                        isShared.value = false;
                                        friends.value.removeWhere(
                                            (element) => element == e.userId);

                                        log(friends.value.toString());
                                      },
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.primary,
                                            border: Border.all(
                                                color: AppColors.primary)),
                                        child: const Center(
                                            child: Icon(
                                          Icons.check,
                                          size: 20,
                                          weight: 10,
                                          color: AppColors.white,
                                        )),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        isShared.value = true;
                                        friends.value.add(e.userId!);
                                        log(friends.value.toString());
                                      },
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.white,
                                            border: Border.all(
                                                color: AppColors.primary)),
                                        child: const Center(
                                            child: Icon(
                                          Icons.check,
                                          size: 20,
                                          weight: 10,
                                          color: AppColors.primary,
                                        )),
                                      ),
                                    )
                            ],
                          ),
                        );
                      })
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
