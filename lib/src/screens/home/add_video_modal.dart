import 'dart:io';

import 'package:chases_scroll/src/repositories/post_repository.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class AddVideoModal extends HookWidget {
  final File video;
  final postText = TextEditingController();
  PostRepository postRepository = PostRepository();
  AddVideoModal({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    final playerController = useState<VideoPlayerController?>(null);
    final chewieController = useState<ChewieController?>(null);

    initializePlayer() {
      playerController.value = VideoPlayerController.file(video);
      chewieController.value = ChewieController(
        videoPlayerController: playerController.value!,
        autoInitialize: true,
        autoPlay: true,
        showControls: true,
      );
    }

    uploadImage() {
      // postRepository.
    }

    useEffect(() {
      initializePlayer();
      return null;
    }, []);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      width: double.infinity,
      height: 600,
      child: Column(children: [
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
                text: "Create New Post",
                fontSize: 14,
                textColor: AppColors.black),
            widthSpace(5)
          ],
        ),
        heightSpace(2),
        Container(
          width: double.infinity,
          height: 250,
          color: Colors.white,
          child: Chewie(
            controller: chewieController.value!,
          ),
        ),
        heightSpace(2),
        TextFormField(
          controller: postText,
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.2, color: Colors.black45),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      size: 15,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              suffixIcon: InkWell(
                onTap: () async {
                  if (postText.text.isEmpty) {
                    ToastResp.toastMsgError(resp: "Post can't be empty");
                    return;
                  }
                  // bool result = await _postRepository.createPost(
                  //     postText.text,
                  //     userModel.value!.userId.toString(),
                  //     imageToUpload.value.isEmpty
                  //         ? null
                  //         : imageToUpload.value.first,
                  //     imageToUpload.value.isEmpty ? [] : imageToUpload.value,
                  //     imageToUpload.value.isEmpty ? null : "WITH_IMAGE");

                  // if (result) {
                  //   ToastResp.toastMsgSuccess(resp: "Successfully Posted");
                  //   postText.clear();
                  //   getPost();
                  // }
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
                  borderSide: const BorderSide(color: AppColors.textFormColor),
                  borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.all(10),
              hintText: "Video Post Caption...",
              hintStyle: GoogleFonts.dmSans(
                  textStyle:
                      const TextStyle(color: AppColors.black, fontSize: 12))),
        ),
      ]),
    );
  }
}
