import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:chases_scroll/src/repositories/post_repository.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/helpers/validations.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/keys.dart';
import '../../config/locator.dart';

class CreateChat extends HookWidget {
  static final ImagePicker picker = ImagePicker();
  final PostRepository _postRepository = PostRepository();

  CreateChat({super.key});

  @override
  Widget build(BuildContext context) {
    final imageValue = useState<File>(File(''));
    final imageString = useState<String>('');
    final keys = locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);

    void uploadImages() async {
      final XFile? image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (image != null) {
        imageValue.value = File(image.path);
        String imageName =
            await _postRepository.addImage(File((image.path)), keys);

        imageString.value = '${Endpoints.displayImages}/$imageName';
      }
    }

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: customText(
                text: "Create Group Chat",
                fontSize: 14,
                fontWeight: FontWeight.bold,
                textColor: AppColors.black)),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            imageString.value.isEmpty
                ? Center(
                    child: GestureDetector(
                        onTap: () => uploadImages(),
                        child: SvgPicture.asset(AppImages.communityAdd)))
                : SizedBox(
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
            heightSpace(2),
            customText(
                text: "Add Photo",
                fontSize: 14,
                textColor: AppColors.textGrey,
                fontWeight: FontWeight.w700),
            heightSpace(3),
            const AppTextFormField(
              validator: stringValidation,
              // textEditingController: communityName.value,
              hintText: "New Group Name",
            ),
            heightSpace(1.5),
            const AppTextFormField(
              validator: stringValidation,
              // textEditingController: communityDescription.value,
              hintText: "New Group Description",
              maxLength: 50,
            ),
            GestureDetector(
                onTap: () async {},
                child: SizedBox(
                  height: 56,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.3),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 13, 5, 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customText(
                                    text: "Select members",
                                    fontSize: 12,
                                    textColor: AppColors.primary)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Container(
                          height: 15,
                          width: 100,
                          color: Colors.white,
                          child: Center(
                              child: customText(
                                  text: "Add participant",
                                  fontSize: 10,
                                  textColor: AppColors.primary)),
                        ),
                      ),
                    ],
                  ),
                )),
            heightSpace(4),
            const ChasescrollButton(
              buttonText: "Create Group",
            ),
          ]),
        )));
  }
}
