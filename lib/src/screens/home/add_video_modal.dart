import 'dart:developer';
import 'dart:io';

import 'package:chases_scroll/src/providers/auth_provider.dart';
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
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

class AddVideoModal extends HookConsumerWidget {
  static final post = TextEditingController();
  final File? video;
  final String? uri;

  final String? userId;
  PostRepository postRepository = PostRepository();
  AddVideoModal({super.key, this.video, this.uri, this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refresh = ref.watch(refreshHomeScreen);
    final playerController = useState<VideoPlayerController?>(null);
    final chewieController = useState<ChewieController?>(null);
    final containerHeight = useState<double?>(null);
    final videoString = useState<String>("");

    initializePlayer() {
      playerController.value = uri == null
          ? VideoPlayerController.file(video!)
          : VideoPlayerController.networkUrl(Uri.parse(uri!));
      chewieController.value = ChewieController(
        videoPlayerController: playerController.value!,
        autoInitialize: true,
        autoPlay: false,
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

    return Container(
      padding: uri == null ? const EdgeInsets.all(20) : EdgeInsets.zero,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      width: double.infinity,
      height: uri == null ? containerHeight.value : 320,
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
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
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
              topLeft: Radius.circular(50),
              topRight: Radius.circular(0),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 270,
              child: Chewie(
                controller: chewieController.value!,
              ),
            ),
          ),
          heightSpace(2),
          if (uri == null)
            TextFormField(
              onTap: () {
                containerHeight.value = 800;
              },
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
                      // if (post.text.isEmpty) {
                      //   ToastResp.toastMsgError(resp: "Post can't be empty");
                      //   return;
                      // }
                      bool result = await postRepository.createPost(
                          post.text,
                          userId!,
                          videoString.value,
                          [videoString.value],
                          "WITH_VIDEO_POST");

                      if (result) {
                        ToastResp.toastMsgSuccess(resp: "Successfully Posted");
                        ref.read(refreshHomeScreen.notifier).state = !refresh;
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
