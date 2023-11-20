import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/repositories/community_repo.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:chases_scroll/src/repositories/post_repository.dart';
import 'package:chases_scroll/src/screens/community/model/group_model.dart';
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
  final CommunityInfoModel? communityInfoModel;
  final PostRepository _postRepository = PostRepository();
  final CommunityRepo communityRepo = CommunityRepo();

  final _formkey = GlobalKey<FormState>();
  CreateCommunity({super.key, this.communityInfoModel});

  @override
  Widget build(BuildContext context) {
    final keys = locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);

    final private = useState<bool>(true);
    final public = useState<bool>(false);
    final imageValue = useState<File>(File(''));
    final imageString = useState<String>('');
    final imageToUpload = useState<String>("");
    final isImageLoading = useState<bool>(false);
    final communityName =
        useState<TextEditingController>(TextEditingController());
    final communityDescription =
        useState<TextEditingController>(TextEditingController());

    createCommunity() async {
      if (_formkey.currentState!.validate()) {
        if (communityInfoModel?.groupId == null) {
          bool result = await communityRepo.createCommunity(
              name: communityName.value.text,
              isPublic: public.value,
              mulitpleMedia: imageToUpload.value,
              description: communityDescription.value.text);
          if (result) {
            ToastResp.toastMsgSuccess(resp: "Created Successfully");
          }
        } else {
          bool result = await communityRepo.editCommunity(
              communityId: communityInfoModel?.groupId,
              name: communityName.value.text,
              isPublic: public.value,
              multipleMedia: imageToUpload.value,
              description: communityDescription.value.text);
          if (result) {
            ToastResp.toastMsgSuccess(resp: "Edited Successfully");
          }
        }
      }
    }

    setEditValues() {
      communityName.value.text = communityInfoModel?.name ?? "";
      communityDescription.value.text = communityInfoModel?.description ?? "";

      if (communityInfoModel?.image != null) {
        imageString.value =
            "${Endpoints.displayImages}${communityInfoModel!.image}";

        log(imageString.value);

        log(imageString.value);
      }
    }

    useEffect(() {
      setEditValues();
      return null;
    }, []);

    void uploadImages() async {
      final XFile? image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (image != null) {
        imageValue.value = File(image.path);
        isImageLoading.value = true;
        String imageName =
            await _postRepository.addImage(File((image.path)), keys);

        imageString.value = '${Endpoints.displayImages}/$imageName';
        imageToUpload.value = imageName;
        isImageLoading.value = false;
        log(imageName);
      }
    }

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: customText(
              text: communityName.value.text.isNotEmpty
                  ? "Edit Community"
                  : "Create Community",
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
              isImageLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : imageString.value.isEmpty
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
                                    border:
                                        Border.all(color: AppColors.primary)),
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
              AppTextFormField(
                validator: stringValidation,
                textEditingController: communityName.value,
                hintText: "Community Name",
              ),
              heightSpace(1.5),
              AppTextFormField(
                validator: stringValidation,
                textEditingController: communityDescription.value,
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
                          text: "Mode Type",
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
                                    onChanged: (value) {
                                      private.value = value;
                                      public.value = !private.value;
                                    }),
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
                                    onChanged: (value) {
                                      public.value = value;
                                      private.value = !public.value;
                                    }),
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
