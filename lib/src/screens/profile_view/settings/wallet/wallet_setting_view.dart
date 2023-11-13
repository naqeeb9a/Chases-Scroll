import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/repositories/user_repository.dart';
import 'package:chases_scroll/src/screens/profile_view/settings/wallet/escrow_view.dart';
import 'package:chases_scroll/src/screens/profile_view/settings/wallet/wallet-view.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class WalletSettingScreenView extends HookWidget {
  static final UserRepository _userRepository = UserRepository();

  const WalletSettingScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final currentPageIndex = useState<int>(0);

    String userName =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.username);
    String fullName =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.fullName);

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
                      widthSpace(3),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                              text: "Hello",
                              fontSize: 12,
                              textColor: AppColors.black.withOpacity(0.6)),
                          customText(
                              text: fullName,
                              fontSize: 16,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.w700),
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
