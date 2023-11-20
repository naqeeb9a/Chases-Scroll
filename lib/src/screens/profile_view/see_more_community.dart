import 'dart:developer';
import 'dart:io';

import 'package:chases_scroll/src/models/community_model.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/repositories/profile_repository.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SeeMoreUserCommunities extends HookWidget {
  static final EventRepository _eventRepository = EventRepository();

  static final ProfileRepository _profileRepository = ProfileRepository();
  const SeeMoreUserCommunities({super.key});

  @override
  Widget build(BuildContext context) {
    //this is for events -----------------------------------------------
    //-------------------This is for Community -----------------------------------//
    final communityLoading = useState<bool>(true);
    final communityModel = useState<List<CommContent>>([]);
    final allCommunity = useState<List<CommContent>>([]);
    final foundCommunity = useState<List<CommContent>>([]);

    getAllCommunities() {
      _profileRepository.getJoinedCommunity().then((value) {
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

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        title: customText(
          text: "See More Events",
          fontSize: 14,
          textColor: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Platform.isIOS
                ? Icons.arrow_back_ios_new_rounded
                : Icons.arrow_back_rounded,
            size: 20,
            color: Colors.black87,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Expanded(
          child: Container(
            padding: PAD_ALL_15,
            child: Column(
              children: [
                AppTextFormField(
                  //textEditingController: searchController,
                  //label: "",
                  hintText: "Search for Community ...",
                  onChanged: (value) {
                    _runCommunityFilter(value);
                  },
                ),
                heightSpace(1.5),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: foundCommunity.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        CommContent comm = foundCommunity.value[index];
                        log("comunity ID ==> ${comm.joinStatus}");

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 55,
                                    width: 55,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20),
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
                                                  color: Colors.white,
                                                  width: 1),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20),
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
                                                  color: Colors.white,
                                                  width: 1),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20),
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
                                            child: Center(
                                              child: customText(
                                                  text: comm
                                                          .data!.imgSrc!.isEmpty
                                                      ? comm.data!.name == null
                                                          ? ""
                                                          : "initials"
                                                      : "",
                                                  fontSize: 10,
                                                  textColor:
                                                      AppColors.deepPrimary,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  widthSpace(1),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        customText(
                                            text: comm.data!.name == null
                                                ? ""
                                                : comm.data!.name!,
                                            fontSize: 14,
                                            textColor: AppColors.black,
                                            fontWeight: FontWeight.w500),
                                        customText(
                                            text: comm.data!.description
                                                .toString(),
                                            fontSize: 12,
                                            textColor: AppColors.searchTextGrey,
                                            fontWeight: FontWeight.w500,
                                            lines: 3),
                                        heightSpace(1),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                customText(
                                                    text: comm.data!.memberCount
                                                        .toString(),
                                                    fontSize: 10,
                                                    textColor:
                                                        AppColors.deepPrimary,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                widthSpace(1),
                                                customText(
                                                    text: comm.data!
                                                                .memberCount ==
                                                            1
                                                        ? "Member"
                                                        : "Members",
                                                    fontSize: 10,
                                                    textColor: AppColors
                                                        .searchTextGrey,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ],
                                            ),
                                            widthSpace(10),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xffD0D4EB),
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: customText(
                                                    text: comm.data!.isPublic ==
                                                            true
                                                        ? "Public"
                                                        : "Private",
                                                    fontSize: 8,
                                                    textColor: AppColors.red,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
