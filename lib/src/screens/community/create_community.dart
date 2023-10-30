import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/repositories/community_repo.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:chases_scroll/src/repositories/post_repository.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/helpers/validations.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/storage_service.dart';

class CreateCommunity extends HookWidget {
  static final ImagePicker picker = ImagePicker();
  final PostRepository _postRepository = PostRepository();
  final CommunityRepo communityRepo = CommunityRepo();
  final communityName = TextEditingController();
  final communityDescription = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  CreateCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    final keys = locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);
    final auto = useState<bool>(true);
    final request = useState<bool>(false);
    final private = useState<bool>(true);
    final public = useState<bool>(false);
    final imageValue = useState<File>(File(''));
    final imageString = useState<String>('');

    createCommunity() async {
      if (_formkey.currentState!.validate()) {
        bool result = await communityRepo.createCommunity(
            name: communityName.text,
            isPublic: public.value,
            mulitpleMedia: imageString.value,
            description: communityDescription.text);

        if (result) {
          ToastResp.toastMsgSuccess(resp: "Created Successfully");
        }
      }
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

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: customText(
              text: "Create Community",
              fontSize: 14,
              textColor: AppColors.black)),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              heightSpace(3),
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
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(0),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: imageString.value,
                              height: 100,
                              width: 150,
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
              AppTextFormField(
                validator: stringValidation,
                textEditingController: communityName,
                hintText: "Community Name",
              ),
              heightSpace(1.5),
              AppTextFormField(
                validator: stringValidation,
                textEditingController: communityDescription,
                hintText: "Community Description",
                maxLength: 50,
              ),
              heightSpace(2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                          text: "Visibility",
                          fontSize: 14,
                          textColor: AppColors.black),
                      heightSpace(1),
                      Container(
                          padding: const EdgeInsets.all(10),
                          width: 160,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF5F5F5),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 0.50,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: Color(0xFFD0D4EB),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Column(children: [
                            Row(
                              children: [
                                customText(
                                    text: "Private",
                                    fontSize: 14,
                                    textColor: AppColors.black),
                                const Spacer(),
                                CupertinoSwitch(
                                    activeColor: AppColors.primary,
                                    value: private.value,
                                    onChanged: (value) =>
                                        private.value = value),
                              ],
                            ),
                            heightSpace(1),
                            Row(
                              children: [
                                customText(
                                    text: "Public",
                                    fontSize: 14,
                                    textColor: AppColors.black),
                                const Spacer(),
                                CupertinoSwitch(
                                    activeColor: AppColors.primary,
                                    value: public.value,
                                    onChanged: (value) => public.value = value),
                              ],
                            )
                          ])),
                    ],
                  )
                ],
              ),
              heightSpace(4),
              ChasescrollButton(
                onTap: createCommunity,
                buttonText: "Submit",
              )
            ],
          ),
        ),
      )),
    );
  }
}
