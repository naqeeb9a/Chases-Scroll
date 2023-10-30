import 'dart:convert';
import 'dart:developer';

import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/models/commdata.dart';
import 'package:chases_scroll/src/models/group_model.dart';
import 'package:chases_scroll/src/repositories/community_repo.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_shape.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/extensions/index_of_map.dart';
import 'package:chases_scroll/src/utils/constants/helpers/change_millepoch.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../config/keys.dart';
import '../../config/locator.dart';
import '../../services/storage_service.dart';

class MyCommunity extends HookWidget {
  static final CommunityRepo _communityReop = CommunityRepo();
  const MyCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    final communityModel = useState<GroupModel?>(null);
    final isLoading = useState<bool>(true);
    getCommunity() {
      final keys =
          locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);
      log(keys.toString());

      _communityReop.getGroup(userId: json.decode(keys)).then((value) {
        isLoading.value = false;
        communityModel.value = value;
      });
    }

    useEffect(() {
      getCommunity();
      return null;
    }, []);

    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: const Border(
          left: BorderSide(color: Color(0xFFD0D4EB)),
          top: BorderSide(color: Color(0xFFD0D4EB)),
          right: BorderSide(color: Color(0xFFD0D4EB)),
          bottom: BorderSide(width: 0.50, color: Color(0xFFD0D4EB)),
        ),
      ),
      child: ListView(
        children: [
          isLoading.value
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  children: [
                    if (communityModel.value!.content!.isEmpty)
                      Center(
                          child: customText(
                              text: "You have not joined a community yet",
                              textColor: AppColors.textGrey,
                              fontSize: 14)),
                    ...communityModel.value!.content!
                        .mapIndexed((element, index) {
                      return InkWell(
                        onTap: () => context.push(AppRoutes.communityChat,
                            extra: CommunityData(
                                groupId: element.id,
                                name: element.data?.name,
                                description: element.data?.description,
                                count: element.data?.memberCount)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 30,
                                    width: 50,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(0),
                                              ),
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 3,
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(0),
                                              ),
                                              color: const Color(0xFF9DA8FB),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 8,
                                          child: ChaseScrollContainer(
                                            name:
                                                "${element.creator?.firstName} ${element.creator?.lastName}",
                                            imageUrl: '${element.data?.imgSrc}',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  widthSpace(5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      customText(
                                          text: "${element.data?.name}",
                                          fontSize: 14,
                                          textColor: AppColors.black,
                                          fontWeight: FontWeight.w700),
                                      customText(
                                          text: "${element.data?.description}",
                                          fontSize: 10,
                                          textColor: AppColors.textGrey)
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      customText(
                                          text: formatEpoch(element.createdOn!),
                                          fontSize: 11,
                                          textColor: AppColors.textGrey),
                                      heightSpace(1),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: customText(
                                            text:
                                                "${element.data?.memberCount}",
                                            fontSize: 10,
                                            textColor: AppColors.white),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const Divider(
                                color: AppColors.backgroundGrey,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
        ],
      ),
    );
  }
}
