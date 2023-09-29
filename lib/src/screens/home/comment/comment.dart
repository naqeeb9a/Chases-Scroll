import 'package:chases_scroll/src/models/comments_model.dart';
import 'package:chases_scroll/src/repositories/post_repository.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_shape.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Comment extends HookWidget {
  final commentText = TextEditingController();
  final Map<dynamic, dynamic> commentData;
  final PostRepository postRepository = PostRepository();

  Comment({Key? key, required this.commentData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading = useState<bool>(true);
    final commentModel = useState<CommentModel?>(null);
    getAllComments() {
      postRepository.getComment(commentData['postId']).then((value) {
        isLoading.value = false;
        commentModel.value = value;
      });
    }

    useEffect(() {
      getAllComments();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
          title: customText(
              text: "Comments", fontSize: 15, textColor: AppColors.black)),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            heightSpace(3),
            Row(
              children: [
                ChaseScrollContainer(
                    name:
                        "${commentData['userModel']?.firstName} ${commentData['userModel']?.lastName}"),
                widthSpace(3),
                Expanded(
                  child: TextFormField(
                    controller: commentText,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () async {
                            if (commentText.text.isEmpty) {
                              ToastResp.toastMsgError(
                                  resp: "Post can't be empty");
                              return;
                            }
                            bool result = await postRepository.addComment(
                                commentData['postId'], commentText.text);

                            if (result) {
                              ToastResp.toastMsgSuccess(
                                  resp: "Successfully Posted");
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset(AppImages.sentOutline),
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
                        hintText: "Add your comment here",
                        hintStyle: GoogleFonts.dmSans(
                            textStyle: const TextStyle(
                                color: AppColors.black, fontSize: 12))),
                  ),
                ),
              ],
            ),
            heightSpace(2),
            ...commentModel.value!.content!.map((e) => Row(
                  children: [
                    ChaseScrollContainer(
                        name: "${e.user!.firstName} ${e.user!.lastName} "),
                    widthSpace(3),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                            text: e.user!.username!,
                            fontSize: 12,
                            textColor: AppColors.primary),
                        customText(
                            text: e.comment!,
                            fontSize: 12,
                            textColor: AppColors.textGrey),
                        Row(
                          children: [
                            Row(
                              children: [
                                customText(
                                    text: e.likeCount.toString(),
                                    fontSize: 11,
                                    textColor: AppColors.primary),
                                widthSpace(1),
                                customText(
                                    text: "likes",
                                    fontSize: 11,
                                    textColor: AppColors.primary)
                              ],
                            ),
                            widthSpace(3),
                            Row(
                              children: [
                                customText(
                                    text: e.subComments!.content!.length
                                        .toString(),
                                    fontSize: 11,
                                    textColor: AppColors.primary),
                                widthSpace(1),
                                customText(
                                    text: "Reply",
                                    fontSize: 11,
                                    textColor: AppColors.primary)
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
