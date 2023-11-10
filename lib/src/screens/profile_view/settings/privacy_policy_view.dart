import 'dart:io';

import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreenView extends StatefulWidget {
  const PrivacyPolicyScreenView({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreenView> createState() =>
      _PrivacyPolicyScreenViewState();
}

class _PrivacyPolicyScreenViewState extends State<PrivacyPolicyScreenView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: customText(
          text: "Privacy Policy",
          fontSize: 14,
          textColor: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Platform.isAndroid
                ? Icons.arrow_back_rounded
                : Icons.arrow_back_ios_new_rounded,
            size: 25,
            color: Colors.black87,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    text: "Privacy Policy",
                    fontSize: 16,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  heightSpace(1.3),
                  customText(
                    text:
                        "[CHASESCROLL LLC] (“we” or “us” or “our”) respects the privacy of our users (“user” or “you”). This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you visit our web or mobile application (the “Application”). Please read this Privacy Policy carefully. IF YOU DO NOT AGREE WITH THE TERMS OF THIS PRIVACY POLICY, PLEASE DO NOT ACCESS THE APPLICATION. We reserve the right to make changes to this Privacy Policy at any time and for any reason. We will alert you about any changes by updating the “Last updated” date of this Privacy Policy. You are encouraged to periodically review this Privacy Policy to stay informed of updates. You will be deemed to have been made aware of, will be subject to, and will be deemed to have accepted the changes in any revised Privacy Policy by your continued use of the Application after the date such revised Privacy Policy is posted. This Privacy Policy does not apply to the third-party online/mobile store from which you install the Application or make payments, including any in-game virtual items, which may also collect and use data about you. We are not responsible for any of the data collected by any such third party.",
                    fontSize: 12,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w400,
                    lines: 500,
                  ),
                  heightSpace(3),
                  customText(
                    text: "Collection of your information",
                    fontSize: 16,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  heightSpace(1.3),
                  customText(
                    text:
                        "We may collect information about you in a variety of ways. The information we may collect via the Application depends on the content and materials you use, and includes: Personal Data Demographic and other personally identifiable information (such as your name and email address) that you voluntarily give to us when choosing to participate in various activities related to the Application, such as chat, posting messages in comment sections or in our forums, liking posts, sending feedback, purchasing ticket(s) and responding to surveys. If you choose to share data about yourself via your profile, online chat, or other interactive areas of the Application, please be advised that all data you disclose in these areas is public and your data will be accessible to anyone who accesses the Application.",
                    fontSize: 12,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w400,
                    lines: 500,
                  ),
                  heightSpace(2),
                  customText(
                    text:
                        "Derivative Data Information our servers automatically collect when you access the Application, such as your native actions that are integral to the Application, including liking, re-blogging, or replying to a post, as well as other interactions with the Application and other users via server log files. Financial Data Financial information, such as data related to your payment method (e.g. valid credit card number, card brand, expiration date) that we may collect when you purchase, order, return, exchange, or request information about our services from the Application. [We store only very limited, if any, financial information that we collect. Otherwise, all financial information is stored by our payment processor, [Paystack Payments,] [Stripe,] and you are encouraged to review their privacy policy and contact them directly for responses to your questions. Data from Social Networks User information from social networking sites, such as [Apple’s Game Center, Facebook, Google+ Instagram, Pinterest, Twitter], including your name, your social network username, location, gender, birth date, email address, profile picture, and public data for contacts, if you connect your account to such social networks. This information may also include the contact information of anyone you invite to use and/or join the Application. Geo-Location Information We may request access or permission to and track location-based information from your mobile device, either continuously or while you are using the Application, to provide location-based services. If you wish to change our access or permissions, you may do so in your device’s settings.",
                    fontSize: 12,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w400,
                    lines: 500,
                  ),
                  heightSpace(2),
                  customText(
                    text:
                        "Mobile Device Access We may request access or permission to certain features from your mobile device, including your mobile device’s [Bluetooth, calendar, camera, contacts, microphone, reminders, sensors, SMS messages, social media accounts, storage,] and other features. If you wish to change our access or permissions, you may do so in your device’s settings.",
                    fontSize: 12,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w400,
                    lines: 500,
                  ),
                  heightSpace(2),
                  customText(
                    text:
                        "Mobile Device Data Device information such as your mobile device ID number, model, and manufacturer, version of your operating system, phone number, country, location, and any other data you choose to provide.",
                    fontSize: 12,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w400,
                    lines: 500,
                  ),
                  heightSpace(2),
                  customText(
                    text:
                        "Push Notifications We may request to send you push notifications regarding your account or the Application. If you wish to opt-out from receiving these types of communications, you may turn them off in your device’s settings.",
                    fontSize: 12,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w400,
                    lines: 500,
                  ),
                  heightSpace(2),
                  customText(
                    text:
                        "Third-Party Data Information from third parties, such as personal information or network friends, if you connect your account to the third party and grant the Application permission to access this information. Data from Contests, Giveaways, and Surveys Personal and other information you may provide when entering contests or giveaways and/or responding to surveys.",
                    fontSize: 12,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w400,
                    lines: 500,
                  ),
                  heightSpace(3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
