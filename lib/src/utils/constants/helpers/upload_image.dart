import 'dart:io';

import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/keys.dart';
import '../../../config/locator.dart';
import '../../../repositories/post_repository.dart';
import '../../../services/storage_service.dart';

Future<String> uploadImages() async {
  final keys = locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);
  File imageValue;
  String imageString = '';
  ImagePicker picker = ImagePicker();
  final PostRepository postRepository = PostRepository();
  final XFile? image =
      await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
  if (image != null) {
    imageValue = File(image.path);
    String imageName = await postRepository.addImage(File((image.path)), keys);

    imageString = '${Endpoints.displayImages}/$imageName';
  }
  return imageString;
}
