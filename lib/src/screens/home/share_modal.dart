import 'package:chases_scroll/src/models/user_list_model.dart';
import 'package:chases_scroll/src/repositories/post_repository.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_shape.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ShareScreen extends HookWidget {
  static PostRepository getPostRepository = PostRepository();
  final String postId;
  const ShareScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final userListModel = useState<UserListModel?>(null);
    final isLoading = useState<bool>(true);
    final friends = useState<List<String>>([]);

    getAllUserSuggestions() {
      getPostRepository.getFriends().then((value) {
        isLoading.value = false;
        userListModel.value = value;
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
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
            enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: AppColors.textFormColor),
                borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.all(10),
            hintText: "Gboye Samuel",
            hintStyle: GoogleFonts.dmSans(
                textStyle:
                    const TextStyle(color: AppColors.black, fontSize: 12)),
            prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: null,
                )),
          )),
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
                                      isShared.value = !isShared.value;
                                      friends.value.add(e.userId!);
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
                                      isShared.value = !isShared.value;
                                      friends.value.removeWhere(
                                          (element) => element == e.userId);
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
      )),
    );
  }
}
