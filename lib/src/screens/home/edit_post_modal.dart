import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chases_scroll/src/providers/auth_provider.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class EditPostModal extends HookConsumerWidget {
  static final post = TextEditingController();
  static final ImagePicker picker = ImagePicker();
  static final PostRepository _postRepository = PostRepository();

  final String? videoUrl;
  final String? imageUrl;
  final String? userId;
  final String? postText;

  final String? postId;
  PostRepository postRepository = PostRepository();
  File? video;
  EditPostModal(
      {super.key,
      this.videoUrl,
      this.imageUrl,
      this.postId,
      this.userId,
      this.postText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refresh = ref.watch(refreshHomeScreen);
    final playerController = useState<VideoPlayerController?>(null);
    final chewieController = useState<ChewieController?>(null);
    final videoLink = useState<String?>(null);
    final imageLink = useState<String?>(null);
    final imageToUpload = useState<String?>(null);
    final videoToUpload = useState<String?>(null);
    final isLoading = useState<bool>(false);
    final containerHeight = useState<double?>(null);

    initializePlayer(String videoUrl) {
      playerController.value =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      chewieController.value = ChewieController(
        videoPlayerController: playerController.value!,
        autoInitialize: true,
        autoPlay: true,
        showControls: true,
      );
    }

    String setPostType() {
      if (imageLink.value == null) {
        if (videoLink.value == null) {
          return "NO_IMAGE_POST";
        }
        return "WITH_VIDEO_POST";
      }
      return "WITH_IMAGE";
    }

    uploadVideo() async {
      final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
      isLoading.value = true;
      postRepository.addVideo(File(video!.path), userId!).then((value) {
        log("this is the video value");
        videoLink.value = '${Endpoints.displayImages}/$value';
        log(videoLink.value.toString());
        initializePlayer(videoLink.value!);
        isLoading.value = false;
        videoToUpload.value = value;
      });
    }

    void uploadImages() async {
      final XFile? image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
      isLoading.value = true;
      if (image!.path.isNotEmpty) {
        String imageName = await _postRepository.addImage(
            File((image.path)), userId.toString());

        imageLink.value = '${Endpoints.displayImages}/$imageName';
        isLoading.value = false;
        imageToUpload.value = imageName;
        log("###########");
        log(imageName);
      }
    }

    useEffect(() {
      post.text = postText!;
      if (videoUrl != null) initializePlayer(videoUrl!);
      log("this is the video url $videoUrl");

      return null;
    }, []);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        width: double.infinity,
        height: containerHeight.value,
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
                  text: "Edit Post", fontSize: 14, textColor: AppColors.black),
              widthSpace(5)
            ],
          ),
          heightSpace(3),
          isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : videoUrl != null
                  ? Container(
                      width: double.infinity,
                      height: 250,
                      color: Colors.white,
                      child: Chewie(
                        controller: chewieController.value!,
                      ),
                    )
                  : CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: imageLink.value ?? imageUrl!,
                      height: 300,
                      width: double.infinity,
                      errorWidget: (context, _, __) {
                        return Center(
                          child: customText(
                              text: "No Image available",
                              fontSize: 12,
                              textColor: AppColors.textGrey),
                        );
                      },
                    ),
          heightSpace(3),
          TextFormField(
            onTap: () {
              containerHeight.value = 800;
            },
            controller: post,
            decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      videoUrl == null ? uploadImages() : uploadVideo();
                    },
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
                ),
                suffixIcon: InkWell(
                  onTap: () async {
                    // if (post.text.isEmpty) {
                    //   ToastResp.toastMsgError(resp: "Post can't be empty");
                    //   return;
                    // }
                    bool result = await postRepository.editPost(
                        postId: postId!,
                        postText: post.text,
                        type: setPostType(),
                        mediaRef: imageToUpload.value ?? videoToUpload.value,
                        multipleMediaRef: imageToUpload.value == null
                            ? [videoToUpload.value ?? ""]
                            : [imageToUpload.value ?? ""]);

                    if (result) {
                      ToastResp.toastMsgSuccess(resp: "Successfully Posted");
                      post.clear();
                      ref.read(refreshHomeScreen.notifier).state = !refresh;
                      if (context.mounted) Navigator.pop(context);
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
                hintText: "Add a Caption for your post...",
                hintStyle: GoogleFonts.dmSans(
                    textStyle:
                        const TextStyle(color: AppColors.black, fontSize: 12))),
          ),
        ]),
      ),
    );
  }
}
