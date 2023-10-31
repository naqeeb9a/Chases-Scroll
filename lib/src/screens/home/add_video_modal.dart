import 'dart:developer';
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
  static final post = TextEditingController();
  final File? video;
  final String? uri;

  final String? userId;
  PostRepository postRepository = PostRepository();
  AddVideoModal({super.key, this.video, this.uri, this.userId});

  @override
  Widget build(BuildContext context) {
    final playerController = useState<VideoPlayerController?>(null);
    final chewieController = useState<ChewieController?>(null);
    final videoString = useState<String>("");

    initializePlayer() {
      playerController.value = uri == null
          ? VideoPlayerController.file(video!)
          : VideoPlayerController.networkUrl(Uri.parse(uri!));
      chewieController.value = ChewieController(
        videoPlayerController: playerController.value!,
        autoInitialize: true,
        autoPlay: true,
        showControls: true,
      );
    }

    uploadVideo() {
      postRepository.addVideo(video!, userId!).then((value) {
        log("this is the video value");
        videoString.value = value;
        log(videoString.value);
      });
    }

    useEffect(() {
      initializePlayer();
      if (uri == null) uploadVideo();
      return null;
    }, []);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        width: double.infinity,
        height: uri == null ? 600 : 320,
        child: Column(children: [
          if (uri == null)
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
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
                topLeft: Radius.circular(50),
                topRight: Radius.circular(0),
              ),
            ),
            height: 270,
            child: Chewie(
              controller: chewieController.value!,
            ),
          ),
          heightSpace(2),
          if (uri == null)
            TextFormField(
              controller: post,
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
                      if (post.text.isEmpty) {
                        ToastResp.toastMsgError(resp: "Post can't be empty");
                        return;
                      }
                      bool result = await postRepository.createPost(
                          post.text,
                          userId!,
                          videoString.value,
                          [videoString.value],
                          "WITH_VIDEO_POST");

                      if (result) {
                        ToastResp.toastMsgSuccess(resp: "Successfully Posted");
                        post.clear();
                        if (context.mounted) Navigator.of(context).pop();
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
                      borderSide:
                          const BorderSide(color: AppColors.textFormColor),
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.all(10),
                  hintText: "Video Post Caption...",
                  hintStyle: GoogleFonts.dmSans(
                      textStyle: const TextStyle(
                          color: AppColors.black, fontSize: 12))),
            ),
        ]),
      ),
    );
  }
}
