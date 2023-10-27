import 'dart:developer';

import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/models/community_model.dart';
import 'package:chases_scroll/src/providers/eventicket_provider.dart';
import 'package:chases_scroll/src/repositories/explore_repository.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GetCommunityFunnelID extends HookConsumerWidget {
  static final ExploreRepository _exploreRepository = ExploreRepository();
  final _router = locator<GoRouter>();
  GetCommunityFunnelID({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    final eventCommFunnelNotifier =
        ref.read(eventCommFunnelDataProvider.notifier);
    //------------------------------------------------------------------------//
    //----------------------This is for community-----------------------------//
    final communityLoading = useState<bool>(true);
    final communityModel = useState<List<CommContent>>([]);
    final allCommunity = useState<List<CommContent>>([]);
    final foundCommunity = useState<List<CommContent>>([]);

    getAllCommunities() {
      _exploreRepository.getAllCommunity().then((value) {
        communityLoading.value = false;
        communityModel.value = value;
        allCommunity.value = value;
        foundCommunity.value = value;
      });
    }

    //for events filtered list
    void _runCommunityFilter(String enteredKeyword) {
      log(enteredKeyword);
      if (enteredKeyword.isEmpty) {
        foundCommunity.value = allCommunity.value;
      } else {
        final found = allCommunity.value
            .where((event) => event.data!.name!
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();

        foundCommunity.value = found;
      }
    }

    useEffect(() {
      getAllCommunities();
      return null;
    }, []);

    return Container(
      padding: PAD_ALL_15,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: const Icon(
                    Icons.close,
                    size: 22,
                    color: Colors.white,
                  ),
                ),
                customText(
                  text: "Add Community to Funnel",
                  fontSize: 16,
                  textColor: AppColors.black,
                ),
                GestureDetector(
                  onTap: () => _router.pop(),
                  child: const Icon(
                    Icons.close,
                    size: 22,
                    color: AppColors.red,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 0, left: 15, right: 15),
            child: AppTextFormField(
              hintText: "Search for Community",
              onChanged: (value) {
                _runCommunityFilter(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: foundCommunity.value.length,
              itemBuilder: (BuildContext context, int index) {
                CommContent comm = foundCommunity.value[index];

                // String n = comm.data!.name.toString();
                // List<String> words = n.split(' ');
                // String initials = words.map((word) => word[0]).join('');
                return Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(0),
                                        ),
                                        color: AppColors.deepPrimary),
                                  ),
                                ),
                                Positioned(
                                  left: 5,
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(0),
                                      ),
                                      color: AppColors.deepPrimary,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 10,
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(0),
                                      ),
                                      color: Colors.grey.shade200,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${comm.data!.imgSrc}"),
                                      ),
                                    ),
                                    // child: Center(
                                    //   child: customText(
                                    //       text: comm.data!.imgSrc!.isEmpty
                                    //           ? initials
                                    //           : "",
                                    //       fontSize: 10,
                                    //       textColor: AppColors.deepPrimary,
                                    //       fontWeight: FontWeight.w500),
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          widthSpace(1),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText(
                                  text: comm.data!.name.toString(),
                                  fontSize: 14,
                                  textColor: AppColors.black,
                                  fontWeight: FontWeight.w500),
                              SizedBox(
                                height: 38,
                                width: width / 2.5,
                                //color: Colors.amber,
                                child: customText(
                                    text: comm.data!.description.toString(),
                                    fontSize: 12,
                                    textColor: AppColors.searchTextGrey,
                                    fontWeight: FontWeight.w500),
                              ),
                              heightSpace(1),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          eventCommFunnelNotifier.updateCommunityFunnelId(
                            commDesc: comm.data!.description,
                            commImage: comm.data!.imgSrc,
                            commName: comm.data!.name,
                            id: comm.id,
                          );
                          _router.pop();
                        },
                        child: Container(
                          padding: PAD_ALL_10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primary,
                          ),
                          child: customText(
                              text: "Add",
                              fontSize: 12,
                              textColor: AppColors.white),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
