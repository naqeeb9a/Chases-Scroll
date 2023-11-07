import 'dart:io';

import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TermsAndConditionScreenView extends StatefulWidget {
  const TermsAndConditionScreenView({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionScreenView> createState() =>
      _TermsAndConditionScreenViewState();
}

class _TermsAndConditionScreenViewState
    extends State<TermsAndConditionScreenView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: customText(
          text: "Terms and Conditions",
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
                children: [
                  customText(
                    text:
                        """These terms and condition (“Terms”, “Agreement “) are an  cras cras sagittis duis. Ullamcorper vel quis habitasse purus. Malesuada sed porta mi.

Accounts and membership: if you create an account on website, you are responsible Lorem ipsum dolor sit amet consectetur. Facilisi amet eget neque mattis eu lconvallis. 
                  
User content: We do not own any data, information or material (“Content”). Vestibulum amet pulvinar nunc placerat tellus. Lorem ipsum dolor sit amet consectetur. 
                  
Objectionable Content: Chasescroll Llc maintains zero tolerance policy regarding Tincidunt aliquam blandit pulvinar mauris elit. Fringilla et auctor purus odio nunc 
                  
Billing and payments: You shall pay all fees or charges to your account in Non et nunc mollis suscipit urna nisi aliquam massa nullam. Fringilla et auctor purus odio nunc 
                  
Accuracy of information: Occasionally there may be information on the website that..commodo lacus. Varius diam placerat est volutpat ullamcorper sit. 
                  
Uptime  guarantee: We offer a service uptime guarantee of 99% of available time Sagittis morbi velit diam consequat. Feugiat sit malesuada nunc posuere
                  
Backups: We are not responsible  for content residing on the Website Sagittis morbi velit diam consequat. Feugiat sit malesuada nunc posuere
                  
Prohibited uses: In addition to other terms as set forth in the Agreement, you Sagittis morbi velit diam consequat. Feugiat sit malesuada nunc posuere
                  
Intellectual property rights: This Agreement does not transfer to you any intellectual Sagittis morbi velit diam consequat. Feugiat sit malesuada nunc posuere
                  
Disclaimer of warranty: You agree that your use of our Website or Services is solely  cras cras sagittis duis. Ullamcorper vel quis habitasse purus. Malesuada sed porta
                  
                  
                  """,
                    fontSize: 14,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w500,
                    lines: 150,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
