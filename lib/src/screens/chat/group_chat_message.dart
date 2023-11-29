import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chases_scroll/src/models/chat_detail_model.dart';
import 'package:chases_scroll/src/repositories/chat_repository.dart';
import 'package:chases_scroll/src/repositories/community_repo.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:chases_scroll/src/repositories/post_repository.dart';
import 'package:chases_scroll/src/screens/chat/model.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_shape.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/extensions/index_of_map.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:chases_scroll/src/utils/permissions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/keys.dart';
import '../../config/locator.dart';
import '../../services/storage_service.dart';

class GroupChatMessage extends HookWidget {
  static final post = TextEditingController();
  static final ImagePicker picker = ImagePicker();
  static final PostRepository _postRepository = PostRepository();
  static final ChatRepository _chatRepository = ChatRepository();
  static final CommunityRepo _communityRepo = CommunityRepo();

  final ChatDataModel chatDataModel;
  const GroupChatMessage({Key? key, required this.chatDataModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userId =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);
    final imageList = useState<List<File>>([]);
    final imageString = useState<String>('');
    final chatDetailsModel = useState<ChatDetailsModel?>(null);

    final isLoading = useState<bool>(true);
    final imageToUpload = useState<List<String>>([]);
    final locationValue = useState<String>("");
    final pickFile = useState<File>(File(""));
    void uploadFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null && result.files.isNotEmpty) {
        pickFile.value = File(result.files.single.path!);
        String imageName =
            await _postRepository.addDocument(pickFile.value, userId);

        imageToUpload.value.add(imageName);
      }
    }

    sendChat() {
      _chatRepository.postChat(chatId: chatDataModel.id, message: post.text);
    }

    getChat() {
      _chatRepository.getChatDetails(chatId: chatDataModel.id).then((value) {
        isLoading.value = false;
        chatDetailsModel.value = value;
      });
    }

    useEffect(() {
      getChat();
      return null;
    }, []);

    imageContainer(File imagePath, int index) => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.file(
                  fit: BoxFit.cover,
                  imagePath,
                  width: 76,
                  height: 53,
                ),
              ),
            ),
            Positioned(
              top: 4,
              left: 70,
              child: GestureDetector(
                onTap: () {
                  imageList.value.removeAt(index);
                  imageToUpload.value.removeAt(index);
                  imageList.value = [...imageList.value];
                },
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: const BoxDecoration(
                      color: AppColors.black, shape: BoxShape.circle),
                  child: const Center(
                      child:
                          Icon(Icons.close, color: AppColors.white, size: 10)),
                ),
              ),
            )
          ],
        );
    void uploadImages(int camera) async {
      final XFile? image;
      if (camera == 0) {
        image = await picker.pickImage(
            source: ImageSource.camera, imageQuality: 70);
      } else if (camera == 1) {
        image = await picker.pickImage(
            source: ImageSource.gallery, imageQuality: 70);
      } else {
        log("it came here");
        image = await picker.pickVideo(
          source: ImageSource.gallery,
        );
      }
      if (imageList.value.length < 4) {
        imageList.value = [...imageList.value, File(image!.path)];
        String imageName =
            await _postRepository.addImage(File((image.path)), userId);

        log("###########");
        log(imageName);
        imageToUpload.value.add(imageName);
      }
    }

    getLocation() async {
      Map<String, dynamic> location = await getCurrentPosition();

      log("this is the location");

      var text = "==Location${jsonEncode(location)}";

      log(text);
      if (context.mounted) {
        Navigator.pop(context);
      }
      post.text = text;
    }

    uploadDocuments() {
      showModalBottomSheet(
        builder: (context) {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: double.infinity,
              height: 280,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        uploadImages(0);
                        Navigator.pop(context);
                      },
                      child: Row(children: [
                        SvgPicture.asset(AppImages.camera,
                            color: AppColors.primary),
                        widthSpace(2),
                        customText(
                            text: "Camera",
                            fontSize: 12,
                            textColor: AppColors.black)
                      ]),
                    ),
                    const Divider(color: AppColors.grey),
                    heightSpace(1),
                    InkWell(
                      onTap: () {
                        uploadImages(1);
                        Navigator.pop(context);
                      },
                      child: Row(children: [
                        SvgPicture.asset(AppImages.imageIcon,
                            color: AppColors.primary, width: 20, height: 20),
                        widthSpace(2),
                        customText(
                            text: "Photo",
                            fontSize: 12,
                            textColor: AppColors.black)
                      ]),
                    ),
                    const Divider(color: AppColors.grey),
                    heightSpace(1),
                    InkWell(
                      onTap: () {
                        uploadImages(2);
                        Navigator.pop(context);
                      },
                      child: Row(children: [
                        SvgPicture.asset(AppImages.imageIcon,
                            color: AppColors.primary, width: 20, height: 20),
                        widthSpace(2),
                        customText(
                            text: "Video Libary",
                            fontSize: 12,
                            textColor: AppColors.black)
                      ]),
                    ),
                    const Divider(color: AppColors.grey),
                    heightSpace(1),
                    InkWell(
                      onTap: () {
                        uploadFile();
                        Navigator.pop(context);
                      },
                      child: Row(children: [
                        SvgPicture.asset(AppImages.document,
                            color: AppColors.primary, width: 20, height: 20),
                        widthSpace(2),
                        customText(
                            text: "Document",
                            fontSize: 12,
                            textColor: AppColors.black)
                      ]),
                    ),
                    const Divider(color: AppColors.grey),
                    heightSpace(1),
                    InkWell(
                      onTap: () {
                        getLocation();
                      },
                      child: Row(children: [
                        SvgPicture.asset(AppImages.location,
                            color: AppColors.primary, width: 20, height: 20),
                        widthSpace(3),
                        customText(
                            text: "Location",
                            fontSize: 12,
                            textColor: AppColors.black)
                      ]),
                    ),
                    heightSpace(2),
                    InkWell(
                      onTap: () {
                        // getLocation();
                      },
                      child: Row(children: [
                        // SvgPicture.asset(AppImages.location,
                        //     color: AppColors.primary, width: 20, height: 20),
                        widthSpace(3),
                        customText(
                            text: "Cancel",
                            fontSize: 12,
                            textColor: AppColors.red)
                      ]),
                    ),
                  ],
                ),
              ));
        },
        context: context,
      );
    }

    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.white,
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
                color: Colors.black87,
              ),
            ),
            elevation: 1,
            toolbarHeight: 70,
            title: Row(
              children: [
                ChaseScrollContainer(
                  name: chatDataModel.name ?? "",
                  imageUrl: "${Endpoints.displayImages}${chatDataModel.image}",
                ),
                widthSpace(2),
                customText(
                    text: chatDataModel.name ?? "",
                    fontSize: 14,
                    textColor: AppColors.black),
              ],
            )),
        body: Container(
            decoration: const BoxDecoration(
              color: Color(0xffE5E5E5),
              image: DecorationImage(
                image: AssetImage(
                  AppImages.chatBackground,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(children: [
                    isLoading.value
                        ? const CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                ...chatDetailsModel.value!.content!
                                    .mapIndexed((element, i) {
                                  String id = element.lastModifiedBy!.userId!;
                                  Placemark? address;
                                  if (element.message?.contains("==Location") ??
                                      false) {
                                    var text = element.message
                                        ?.replaceAll("==Location", "");
                                    var data = jsonDecode(text!);
                                    address = Placemark.fromMap(data);
                                  }
                                  return Column(
                                    children: [
                                      (() {
                                        if (address != null) {
                                          return InkWell(
                                            onTap: () {
                                              _communityRepo.launchMapOnAddress(
                                                  "${address!.street!} ${address.subLocality!} ${address.locality!}, ${address.administrativeArea!} ${address.country!}");
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    const Radius.circular(12),
                                                bottomRight: element
                                                            .lastModifiedBy!
                                                            .userId ==
                                                        userId
                                                    ? const Radius.circular(0)
                                                    : const Radius.circular(12),
                                                topLeft: element.lastModifiedBy!
                                                            .userId ==
                                                        userId
                                                    ? const Radius.circular(12)
                                                    : const Radius.circular(0),
                                                topRight:
                                                    const Radius.circular(12),
                                              ),
                                              child: Container(
                                                  height: 120,
                                                  width: 270,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: AppColors.primary,
                                                  ),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        customText(
                                                            text:
                                                                "${element.message}",
                                                            fontSize: 10,
                                                            textColor:
                                                                AppColors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ])),
                                            ),
                                          );
                                        }
                                        if (element.mediaType == "PICTURE") {
                                          return Align(
                                            alignment: id == userId
                                                ? Alignment.bottomRight
                                                : Alignment.bottomRight,
                                            child: InkWell(
                                                onTap: () async {
                                                  _communityRepo.launchLink(
                                                      "${Endpoints.displayImages}${element.media}");
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  width: 250,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          const Radius.circular(
                                                              12),
                                                      bottomRight:
                                                          element.lastModifiedBy!
                                                                      .userId ==
                                                                  userId
                                                              ? const Radius
                                                                  .circular(0)
                                                              : const Radius
                                                                  .circular(12),
                                                      topLeft:
                                                          element.lastModifiedBy!
                                                                      .userId ==
                                                                  userId
                                                              ? const Radius
                                                                  .circular(12)
                                                              : const Radius
                                                                  .circular(0),
                                                      topRight:
                                                          const Radius.circular(
                                                              12),
                                                    ),
                                                    color: AppColors.primary,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                          height: 200,
                                                          width:
                                                              double.infinity,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft:
                                                                  const Radius
                                                                      .circular(12),
                                                              bottomRight: element
                                                                          .lastModifiedBy!
                                                                          .userId ==
                                                                      userId
                                                                  ? const Radius
                                                                          .circular(
                                                                      0)
                                                                  : const Radius
                                                                      .circular(12),
                                                              topLeft: element
                                                                          .lastModifiedBy!
                                                                          .userId ==
                                                                      userId
                                                                  ? const Radius
                                                                          .circular(
                                                                      12)
                                                                  : const Radius
                                                                      .circular(0),
                                                              topRight: const Radius
                                                                  .circular(12),
                                                            ),
                                                            child:
                                                                CachedNetworkImage(
                                                              fit: BoxFit.cover,
                                                              imageUrl:
                                                                  "${Endpoints.displayImages}${element.media}",
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Icon(Icons
                                                                      .error),
                                                            ),
                                                          )),
                                                      if (element
                                                          .message!.isNotEmpty)
                                                        Column(
                                                          children: [
                                                            heightSpace(1),
                                                            Flexible(
                                                              child: customText(
                                                                  text:
                                                                      '${element.message}',
                                                                  fontSize: 10,
                                                                  textColor:
                                                                      AppColors
                                                                          .white),
                                                            ),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                )),
                                          );
                                        }
                                        if (element.mediaType == "DOCUMENT" ||
                                            element.mediaType == "WITH_FILE") {
                                          return Align(
                                            alignment: id == userId
                                                ? Alignment.bottomRight
                                                : Alignment.bottomRight,
                                            child: InkWell(
                                                onTap: () async {
                                                  _communityRepo.launchLink(
                                                      "${Endpoints.displayImages}${element.media}");
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  height: 80,
                                                  width: 250,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          const Radius.circular(
                                                              12),
                                                      bottomRight:
                                                          element.lastModifiedBy!
                                                                      .userId ==
                                                                  userId
                                                              ? const Radius
                                                                  .circular(0)
                                                              : const Radius
                                                                  .circular(12),
                                                      topLeft:
                                                          element.lastModifiedBy!
                                                                      .userId ==
                                                                  userId
                                                              ? const Radius
                                                                  .circular(12)
                                                              : const Radius
                                                                  .circular(0),
                                                      topRight:
                                                          const Radius.circular(
                                                              12),
                                                    ),
                                                    color: AppColors.primary,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                AppColors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Flexible(
                                                              child: customText(
                                                                  text: element
                                                                      .media
                                                                      .toString(),
                                                                  fontSize: 10,
                                                                  textColor:
                                                                      AppColors
                                                                          .black),
                                                            ),
                                                            SvgPicture.asset(
                                                                AppImages
                                                                    .downloadIcon)
                                                          ],
                                                        ),
                                                      ),
                                                      if (element
                                                          .message!.isNotEmpty)
                                                        Column(
                                                          children: [
                                                            heightSpace(1),
                                                            Flexible(
                                                              child: customText(
                                                                  text:
                                                                      '${element.message}',
                                                                  fontSize: 10,
                                                                  textColor:
                                                                      AppColors
                                                                          .white),
                                                            ),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                )),
                                          );
                                        }
                                        return Align(
                                          alignment: id == userId
                                              ? Alignment.bottomRight
                                              : Alignment.bottomRight,
                                          child: IntrinsicWidth(
                                            child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration:
                                                    const ShapeDecoration(
                                                  color: Color(0xFF5D70F9),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(12),
                                                      topRight:
                                                          Radius.circular(12),
                                                      bottomLeft:
                                                          Radius.circular(12),
                                                    ),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5,
                                                              bottom: 3),
                                                      child: customText(
                                                          text:
                                                              element.message!,
                                                          fontSize: 12,
                                                          textColor:
                                                              AppColors.white),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: SvgPicture.asset(
                                                          AppImages.check),
                                                    )
                                                  ],
                                                )),
                                          ),
                                        );
                                      }())
                                    ],
                                  );
                                })
                              ],
                            ),
                          )
                  ])),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if (imageList.value.isNotEmpty)
                        SizedBox(
                          height: 73,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: imageList.value
                                .mapIndexed((e, i) => imageContainer(e, i))
                                .toList(),
                          ),
                        ),
                      if (pickFile.value.path.isNotEmpty)
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: Colors.white,
                            ),
                            width: double.infinity,
                            height: 80,
                            child: Column(children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    customText(
                                        text: "Selected Document",
                                        fontSize: 9,
                                        textColor: AppColors.primary),
                                    InkWell(
                                      onTap: () {
                                        pickFile.value = File("");
                                      },
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        child: const Center(
                                          child: Icon(
                                            Icons.close_rounded,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    )
                                  ]),
                              heightSpace(1),
                              customText(
                                  text: pickFile.value.path,
                                  fontSize: 10,
                                  textColor: AppColors.black)
                            ])),
                      heightSpace(1),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: uploadDocuments,
                              child: SvgPicture.asset(AppImages.addDocument)),
                          Expanded(
                              child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, left: 5.0),
                            child: TextFormField(
                              // controller: post,
                              decoration: InputDecoration(
                                hintText: "Add Post here",
                                suffixIcon: InkWell(
                                  // onTap: createPost,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(AppImages.sendIcon),
                                  ),
                                ),
                                filled: true,
                                fillColor: AppColors.white,
                                focusedBorder: AppColors.normalBorder,
                                hintStyle: GoogleFonts.dmSans(
                                    textStyle: const TextStyle(
                                        color: AppColors.black, fontSize: 12)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: AppColors.textFormColor),
                                    borderRadius: BorderRadius.circular(10)),
                                contentPadding: const EdgeInsets.all(10),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
