import 'package:chases_scroll/src/models/user_model.dart';
import 'package:chases_scroll/src/repositories/user_repository.dart';
import 'package:chases_scroll/src/screens/profile_view/settings/wallet/escrow_view.dart';
import 'package:chases_scroll/src/screens/profile_view/settings/wallet/wallet-view.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class WalletSettingScreenView extends HookWidget {
  static final UserRepository _userRepository = UserRepository();

  const WalletSettingScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final currentPageIndex = useState<int>(0);

    final userModel = useState<UserModel?>(null);
    final pageLoading = useState<bool>(true);

    getUserProfile() {
      _userRepository.getUserProfile().then((value) {
        pageLoading.value = false;
        userModel.value = value;
      });
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: PAD_ALL_15,
          child: Column(
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 3.h,
                        backgroundColor: Colors.grey.shade300,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          child: customText(
                              text: "JK",
                              fontSize: 12,
                              textColor: AppColors.black),
                          // child: user.data!.imgMain == null ||
                          //         user.data!.imgMain == 'string' ||
                          //         user.data!.imgMain == 'String'
                          //     ? Center(
                          //         child: font17Tx700(
                          //           "${user.firstName![0].toString()}${user.lastName![0].toString()}"
                          //               .toUpperCase(),
                          //           mainColor(),
                          //         ),
                          //       )
                          //     : CachedNetworkImage(
                          //         fit: BoxFit.fitWidth,
                          //         height: height,
                          //         width: width,
                          //         imageUrl:
                          //             "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${user.data!.imgMain!.value.toString()}",
                          //       ),
                        ),
                      ),
                      widthSpace(3),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                              text: "Hello",
                              fontSize: 12,
                              textColor: AppColors.black),
                          customText(
                              text: "Hilda Baci",
                              fontSize: 16,
                              textColor: AppColors.black),
                        ],
                      ),
                    ],
                  ),
                  //SvgPicture.asset(AppImages.accountSetting)
                ],
              ),
              heightSpace(2),
              Expanded(
                child: PageView(
                  onPageChanged: (index) {
                    currentPageIndex.value = index;
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: [
                    WalletView(
                      pageController: pageController,
                      pageIndex: currentPageIndex.value,
                    ),
                    EscrowView(
                      pageController: pageController,
                      pageIndex: currentPageIndex.value,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
