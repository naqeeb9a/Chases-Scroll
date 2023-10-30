import 'dart:convert';
import 'dart:developer';

import 'package:chases_scroll/src/models/group_model.dart';
import 'package:chases_scroll/src/repositories/community_repo.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_shape.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/extensions/index_of_map.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../config/keys.dart';
import '../../config/locator.dart';

class FindCommunity extends HookWidget {
  static final CommunityRepo _communityRepo = CommunityRepo();
  const FindCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    final communityModel = useState<GroupModel?>(null);
    final isLoading = useState<bool>(true);
    getCommunity() {
      final keys =
          locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);
      log(keys.toString());

      _communityRepo.findCommunity().then((value) {
        isLoading.value = false;
        communityModel.value = value;
      });
    }

    joinCommunity(String groupId) {
      log(groupId.toString());
      final keys =
          locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);
      log(keys.toString());
      _communityRepo
          .joinCommunity(groupId: groupId, userId: json.decode(keys))
          .then((value) {
        if (value) {
          ToastResp.toastMsgSuccess(resp: "Request sent successfully");
          getCommunity();
        }
      });
    }

    useEffect(() {
      getCommunity();
      return null;
    }, []);
    return ListView(
      children: [
        isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  if (communityModel.value!.content!.isEmpty)
                    Center(
                        child: customText(
                            text: "No Community created",
                            textColor: AppColors.black,
                            fontSize: 14)),
                  ...communityModel.value!.content!.mapIndexed((e, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ChaseScrollContainer(
                            name:
                                "${e.creator?.firstName} ${e.creator?.lastName}",
                            imageUrl: '${e.data?.imgSrc}',
                          ),
                          widthSpace(5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText(
                                  text: "${e.data?.name}",
                                  fontSize: 14,
                                  textColor: AppColors.black,
                                  fontWeight: FontWeight.bold),
                              customText(
                                  text: "${e.data?.description}",
                                  fontSize: 12,
                                  textColor: AppColors.textGrey),
                              heightSpace(1),
                              Row(
                                children: [
                                  customText(
                                      text: "${e.data!.memberCount} Members",
                                      fontSize: 12,
                                      textColor: AppColors.textGrey),
                                  widthSpace(5),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: ShapeDecoration(
                                      color: const Color(0x26D0D4EB),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 0.20,
                                            color: Color(0xFFFBCDCD)),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          e.data!.isPublic!
                                              ? 'Public'
                                              : 'Private',
                                          style: TextStyle(
                                            color: e.data!.isPublic!
                                                ? AppColors.red
                                                : AppColors.primary,
                                            fontSize: 12,
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                            letterSpacing: -0.23,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          const Spacer(),
                          if (e.joinStatus == "NOT_CONNECTED")
                            InkWell(
                              onTap: () {
                                joinCommunity(e.id!);
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 4),
                                  decoration: ShapeDecoration(
                                    color: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 0.50,
                                          color: AppColors.primary),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Center(
                                    child: customText(
                                        text: "Join",
                                        fontSize: 10,
                                        textColor: AppColors.white),
                                  )),
                            )
                        ],
                      ),
                    );
                  })
                ],
              )
      ],
    );
  }
}
