import 'dart:convert';
import 'dart:developer';

import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/models/group_model.dart';
import 'package:chases_scroll/src/repositories/community_repo.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_shape.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/extensions/index_of_map.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RequestCommunity extends HookWidget {
  static final CommunityRepo _communityRepo = CommunityRepo();
  const RequestCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    final communityModel = useState<GroupModel?>(null);
    final isLoading = useState<bool>(true);
    getCommunity() {
      final keys =
          locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);
      log(keys.toString());

      _communityRepo
          .requestGroup(userId: json.decode(json.encode(keys)))
          .then((value) {
        isLoading.value = false;
        communityModel.value = value;
      });
    }

    useEffect(() {
      getCommunity();
      return null;
    }, []);
    return ListView(
      children: [
        heightSpace(3),
        isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  if (communityModel.value!.content!.isEmpty)
                    Center(
                        child: customText(
                            text: "No Community request",
                            textColor: AppColors.black,
                            fontSize: 14)),
                  ...communityModel.value!.content!
                      .mapIndexed((element, index) {
                    return Row(
                      children: [
                        const ChaseScrollContainer(name: "Sammy Cliffy"),
                        widthSpace(5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText(
                                text: "Haven Party Light",
                                fontSize: 14,
                                textColor: AppColors.black,
                                fontWeight: FontWeight.bold),
                            customText(
                                text: "John is requesting to join",
                                fontSize: 12,
                                textColor: AppColors.textGrey),
                            heightSpace(1),
                            Row(
                              children: [
                                customText(
                                    text: "23k Members",
                                    fontSize: 10,
                                    textColor: AppColors.textGrey),
                                widthSpace(5),
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                decoration: ShapeDecoration(
                                  color: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 0.50, color: AppColors.primary),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Center(
                                  child: customText(
                                      text: "Accept",
                                      fontSize: 10,
                                      textColor: AppColors.white),
                                )),
                            widthSpace(3),
                            SvgPicture.asset(AppImages.closeCircle)
                          ],
                        )
                      ],
                    );
                  })
                ],
              ),
      ],
    );
  }
}
