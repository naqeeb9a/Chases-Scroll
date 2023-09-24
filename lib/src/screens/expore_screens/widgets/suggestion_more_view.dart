import 'package:chases_scroll/src/repositories/explore_repository.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/event_model.dart';
import '../../widgets/app_bar.dart';

class SuggestionFriendMore extends HookWidget {
  static final ExploreRepository _exploreRepository = ExploreRepository();
  const SuggestionFriendMore({super.key});

  @override
  Widget build(BuildContext context) {
    final usersModel = useState<List<Content>>([]);
    final usersLoading = useState<bool>(true);

    getSuggestedUsers() {
      _exploreRepository.getSuggestedUsers().then((value) {
        usersLoading.value = false;
        usersModel.value = value;
      });
    }

    void refreshSuggestedUsers() {
      usersLoading.value = false; // Set loading state back to true
      getSuggestedUsers(); // Trigger the API call again
    }

    useEffect(() {
      getSuggestedUsers();
      return null;
    }, []);
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: appBar(
        title: "Suggestions",
        appBarActionWidget: SvgPicture.asset(
          AppImages.suggestionGrid,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: PAD_ALL_GENERAL,
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: usersModel.value.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      Content? content = usersModel.value[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: PAD_ALL_10,
                        color: AppColors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(40),
                                      bottomRight: Radius.circular(40),
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(0),
                                    ),
                                    color: Colors.grey.shade300,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${content.data!.imgMain!.value.toString()}"),
                                    ),
                                  ),
                                  child: Center(
                                    child: customText(
                                        text: content.data!.imgMain!
                                                    .objectPublic ==
                                                false
                                            ? content.firstName!.isEmpty
                                                ? ""
                                                : "${content.firstName![0]}${content.lastName![0]}"
                                            : "",
                                        fontSize: 12,
                                        textColor: AppColors.deepPrimary,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                widthSpace(2),
                                SizedBox(
                                  width: 40.w,
                                  //color: Colors.amber,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      customText(
                                          text:
                                              "${content.firstName} ${content.lastName}",
                                          fontSize: 12,
                                          textColor: AppColors.black,
                                          fontWeight: FontWeight.w700),
                                      customText(
                                          text: "Shared Affilations",
                                          fontSize: 11,
                                          textColor: AppColors.searchTextGrey,
                                          fontWeight: FontWeight.w400),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                ChasescrollButton(
                                  hasIcon: false,
                                  iconWidget:
                                      SvgPicture.asset(AppImages.appleIcon),
                                  buttonText: content.joinStatus == "CONNECTED"
                                      ? "Connected"
                                      : content.joinStatus == "NOT_CONNECTED"
                                          ? "Connect"
                                          : content.joinStatus ==
                                                  "FRIEND_REQUEST_SENT"
                                              ? "Pending"
                                              : "",
                                  hasBorder: false,
                                  borderColor: AppColors.grey,
                                  textColor: AppColors.white,
                                  color: AppColors.deepPrimary,
                                  height: 30,
                                  width: 90,
                                  onTap: () async {
                                    final result = await _exploreRepository
                                        .connectWithFriend(
                                            friendID: content.userId);
                                    if (result['updated'] == true) {
                                      // Trigger a refresh of the events data
                                      refreshSuggestedUsers();
                                      ToastResp.toastMsgSuccess(
                                          resp: result['message']);

                                      //refreshEventProvider(context.read);
                                    } else {
                                      ToastResp.toastMsgError(
                                          resp: result['message']);
                                    }
                                  },
                                ),
                                widthSpace(1.8),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.red.withOpacity(0.1)),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.cancel_outlined,
                                        size: 20,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
    );
  }
}
