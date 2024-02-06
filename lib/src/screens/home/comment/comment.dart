import 'dart:developer';

import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/models/comments_model.dart';
import 'package:chases_scroll/src/models/post_model.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:chases_scroll/src/repositories/post_repository.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_shape.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/extensions/index_of_map.dart';
import 'package:chases_scroll/src/utils/constants/helpers/change_millepoch.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Comment extends HookWidget {
  static final subComment = TextEditingController();
  final commentText = TextEditingController();
  final Map<dynamic, dynamic> commentData;
  final PostRepository postRepository = PostRepository();

  Comment({Key? key, required this.commentData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading = useState<bool>(true);
    final commentModel = useState<CommentModel?>(null);
    final isReplyClicked = useState<bool>(false);
    final commentId = useState<String>("");
    final subComments = useState<SubComment?>(null);
    final hasClickedReply = useState<bool>(false);
    getAllComments() {
      postRepository.getComment(commentData['postId']).then((value) {
        isLoading.value = false;
        commentModel.value = value;
      });
    }

    addSubComment(String id, TextEditingController controller) {
      postRepository.addSubComment(id, subComment.text).then((value) {
        ToastResp.toastMsgSuccess(resp: "Comment posted successfully");
        getAllComments();
        controller.clear();
      });
    }

    likeComment(String id) async {
      await postRepository.likeComment(id);
    }

    getSubComment(String commentId) {
      postRepository.getSubComment(commentId).then((value) {
        subComments.value = value;
      });
    }

    useEffect(() {
      getAllComments();
      return null;
    }, []);

    return WillPopScope(
      onWillPop: () async {
        context.pushReplacement(AppRoutes.bottomNav);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
            title: customText(
                text: "Comments", fontSize: 15, textColor: AppColors.black)),
        body: isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
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
                                          bool result =
                                              await postRepository.addComment(
                                                  commentData['postId'],
                                                  commentText.text);

                                          if (result) {
                                            ToastResp.toastMsgSuccess(
                                                resp: "Successfully Posted");
                                            commentText.clear();
                                            getAllComments();
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: SvgPicture.asset(
                                              AppImages.sentOutline),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: AppColors.textFormColor,
                                      focusedBorder: AppColors.normalBorder,
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: AppColors.textFormColor),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      contentPadding: const EdgeInsets.all(10),
                                      hintText: "Add your comment here",
                                      hintStyle: GoogleFonts.dmSans(
                                          textStyle: const TextStyle(
                                              color: AppColors.black,
                                              fontSize: 12))),
                                ),
                              ),
                            ],
                          ),
                          heightSpace(2),
                          ...commentModel.value!.content!.map((e) {
                            final likedCount = useState<int>(e.likeCount!);

                            final hasLiked = useState<bool>(
                                e.likeStatus == "LIKED" ? true : false);
                            commentId.value = e.id!;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      ChaseScrollContainer(
                                          imageUrl:
                                              '${Endpoints.displayImages}/${e.user?.data?.imgMain?.value}',
                                          name:
                                              "${e.user!.firstName} ${e.user!.lastName} "),
                                      widthSpace(3),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            customText(
                                                text: e.user!.username!,
                                                fontSize: 12,
                                                textColor: AppColors.primary),
                                            ExpandableText(
                                              e.comment ?? '',
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.textGrey),
                                              expandText: 'see more',
                                              collapseText: 'see less',
                                              maxLines: 2,
                                              linkStyle: const TextStyle(
                                                  color: Colors.blue),
                                              urlStyle: const TextStyle(
                                                  color: Colors.blue),
                                              linkColor: Colors.blue,
                                              onUrlTap: (url) async {
                                                if (!await launchUrl(
                                                    Uri.parse(url))) {
                                                  ToastResp.toastMsgError(
                                                      resp: "Couldn't launch");
                                                }
                                              },
                                            ),
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    customText(
                                                      text: timeAgoFromEpoch(e
                                                          .timeInMilliseconds!),
                                                      fontSize: 10,
                                                      textColor:
                                                          AppColors.textGrey,
                                                    ),
                                                    widthSpace(3),
                                                    customText(
                                                        text: e.likeCount
                                                            .toString(),
                                                        fontSize: 11,
                                                        textColor:
                                                            AppColors.primary),
                                                    widthSpace(1),
                                                    customText(
                                                        text: "likes",
                                                        fontSize: 10,
                                                        textColor:
                                                            AppColors.primary)
                                                  ],
                                                ),
                                                widthSpace(3),
                                                Row(
                                                  children: [
                                                    customText(
                                                        text: e.subComments!
                                                            .content!.length
                                                            .toString(),
                                                        fontSize: 10,
                                                        textColor:
                                                            AppColors.primary),
                                                    widthSpace(1),
                                                    InkWell(
                                                      onTap: () =>
                                                          isReplyClicked.value =
                                                              !isReplyClicked
                                                                  .value,
                                                      child: customText(
                                                          text: "Reply",
                                                          fontSize: 10,
                                                          textColor: AppColors
                                                              .primary),
                                                    ),
                                                    widthSpace(3),
                                                    if (e.subComments!.content!
                                                        .isNotEmpty)
                                                      InkWell(
                                                        onTap: () {
                                                          hasClickedReply
                                                                  .value =
                                                              !hasClickedReply
                                                                  .value;
                                                          if (hasClickedReply
                                                              .value) {
                                                            getSubComment(
                                                                e.id!);
                                                            return;
                                                          }
                                                          subComments.value =
                                                              null;
                                                        },
                                                        child: customText(
                                                            text: hasClickedReply
                                                                    .value
                                                                ? "Hide Replies"
                                                                : "Show Replies",
                                                            fontSize: 10,
                                                            textColor: AppColors
                                                                .primary),
                                                      )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          log(hasLiked.value.toString());
                                          if (hasLiked.value) {
                                            likedCount.value =
                                                likedCount.value - 1;
                                            log(likedCount.value.toString());
                                            likeComment(e.id!);
                                            hasLiked.value = !hasLiked.value;
                                            return;
                                          }
                                          if (likedCount.value < 2) {
                                            likedCount.value =
                                                likedCount.value + 1;
                                          }
                                          log(likedCount.value.toString());
                                          hasLiked.value = !hasLiked.value;
                                          likeComment(e.id!);
                                        },
                                        child: hasLiked.value
                                            ? SvgPicture.asset(
                                                AppImages.favouriteFilled,
                                                color: AppColors.red,
                                              )
                                            : SvgPicture.asset(
                                                AppImages.like,
                                              ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                      color: AppColors.backgroundGrey),
                                  if (subComments.value != null)
                                    ...subComments.value!.content!
                                        .mapIndexed((element, index) {
                                      final likedCount =
                                          useState<int>(element.likeCount!);

                                      final hasLiked = useState<bool>(
                                          element.likeStatus == "LIKED"
                                              ? true
                                              : false);
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, top: 8),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                ChaseScrollContainer(
                                                    imageUrl:
                                                        '${Endpoints.displayImages}/${element.user?.data?.imgMain?.value}',
                                                    name:
                                                        "${element.user!.firstName} ${element.user!.lastName} "),
                                                widthSpace(3),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    customText(
                                                        text: element
                                                            .user!.username!,
                                                        fontSize: 12,
                                                        textColor:
                                                            AppColors.primary),
                                                    customText(
                                                        text: element.comment!,
                                                        fontSize: 11,
                                                        textColor:
                                                            AppColors.textGrey),
                                                    Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            customText(
                                                              text: timeAgoFromEpoch(
                                                                  element
                                                                      .timeInMilliseconds!),
                                                              fontSize: 10,
                                                              textColor:
                                                                  AppColors
                                                                      .textGrey,
                                                            ),
                                                            widthSpace(3),
                                                            customText(
                                                                text: likedCount
                                                                    .value
                                                                    .toString(),
                                                                fontSize: 11,
                                                                textColor:
                                                                    AppColors
                                                                        .primary),
                                                            widthSpace(1),
                                                            customText(
                                                                text: "like",
                                                                fontSize: 10,
                                                                textColor:
                                                                    AppColors
                                                                        .primary)
                                                          ],
                                                        ),
                                                        widthSpace(3),
                                                        // Row(
                                                        //   children: [
                                                        //     customText(
                                                        //         text: e
                                                        //             .subComments!
                                                        //             .content!
                                                        //             .length
                                                        //             .toString(),
                                                        //         fontSize: 10,
                                                        //         textColor:
                                                        //             AppColors
                                                        //                 .primary),
                                                        //     widthSpace(1),
                                                        //     InkWell(
                                                        //       onTap: () =>
                                                        //           isReplyClicked
                                                        //                   .value =
                                                        //               !isReplyClicked
                                                        //                   .value,
                                                        //       child: customText(
                                                        //           text: "Reply",
                                                        //           fontSize: 10,
                                                        //           textColor:
                                                        //               AppColors
                                                        //                   .primary),
                                                        //     ),
                                                        //     widthSpace(3),
                                                        //     InkWell(
                                                        //       onTap: () =>
                                                        //           getSubComment(
                                                        //               e.id!),
                                                        //       child: customText(
                                                        //           text:
                                                        //               "Show Replies",
                                                        //           fontSize: 10,
                                                        //           textColor:
                                                        //               AppColors
                                                        //                   .primary),
                                                        //     )
                                                        //   ],
                                                        // )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                const Spacer(),
                                                InkWell(
                                                    onTap: () {
                                                      log(hasLiked.value
                                                          .toString());

                                                      if (hasLiked.value) {
                                                        likedCount.value =
                                                            likedCount.value -
                                                                1;
                                                        log(likedCount.value
                                                            .toString());
                                                        likeComment(e.id!);
                                                        hasLiked.value =
                                                            !hasLiked.value;
                                                        return;
                                                      }
                                                      if (likedCount.value <
                                                          2) {
                                                        likedCount.value =
                                                            likedCount.value +
                                                                1;
                                                      }
                                                      log(likedCount.value
                                                          .toString());
                                                      hasLiked.value =
                                                          !hasLiked.value;
                                                      likeComment(e.id!);
                                                    },
                                                    child: hasLiked.value
                                                        ? SvgPicture.asset(
                                                            AppImages
                                                                .favouriteFilled,
                                                            color:
                                                                AppColors.red,
                                                          )
                                                        : SvgPicture.asset(
                                                            AppImages.like,
                                                          ))
                                              ],
                                            ),
                                            const Divider(
                                                color:
                                                    AppColors.backgroundGrey),
                                          ],
                                        ),
                                      );
                                    })
                                ],
                              ),
                            );
                          })
                        ],
                      ),
                    )),
                  ),
                  if (isReplyClicked.value)
                    Padding(
                        padding: const EdgeInsets.only(
                          bottom: 15.0,
                          left: 5.0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              height: 50,
                              child: TextFormField(
                                  controller: subComment,
                                  decoration: InputDecoration(
                                    hintText: "Add sub comment here..",
                                    hintStyle: GoogleFonts.dmSans(
                                        textStyle: const TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12)),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        if (subComment.text.isEmpty) {
                                          ToastResp.toastMsgError(
                                              resp: "Add a valid comment");
                                          return;
                                        }
                                        addSubComment(
                                            commentId.value, subComment);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                            AppImages.sendIcon),
                                      ),
                                    ),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ChaseScrollContainer(
                                          imageUrl:
                                              "${commentData['imageUrl']}",
                                          name:
                                              "${commentData['userModel']?.firstName} ${commentData['userModel']?.lastName}"),
                                    ),
                                    filled: true,
                                    fillColor: AppColors.textFormColor,
                                    focusedBorder: AppColors.normalBorder,
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: AppColors.textFormColor),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    contentPadding: const EdgeInsets.all(10),
                                  ))),
                        )),
                  heightSpace(2),
                ],
              ),
      ),
    );
  }
}
