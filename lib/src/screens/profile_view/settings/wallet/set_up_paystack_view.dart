import 'dart:developer';

import 'package:chases_scroll/src/repositories/wallet_repository.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/helpers/strings.dart';
import 'package:chases_scroll/src/utils/constants/helpers/validations.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SetupAccountPaystackView extends StatefulWidget {
  const SetupAccountPaystackView({super.key});

  @override
  State<SetupAccountPaystackView> createState() =>
      _SetupAccountPaystackViewState();
}

class _SetupAccountPaystackViewState extends State<SetupAccountPaystackView> {
  final number = TextEditingController();
  bool isloading = false;
  String? bankCode;
  String? selectedBankName;
  //function for seting up paystack account
  final WalletRepository _walletRepository = WalletRepository();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: 22,
          ),
        ),
        title: Text(
          "PayStack Withdrawal Account Setup",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: PAD_ALL_15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                  text: "Select Bank",
                  fontSize: 14,
                  textColor: AppColors.black),
              heightSpace(1),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: 'Choose Bank',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(15, 15, 10, 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: AppColors.primary.withOpacity(0.3),
                          width: 1.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: AppColors.primary.withOpacity(0.3),
                          width: 1.5),
                    ),
                    // focusedBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(
                    //     color: PayColors.navbarUnactive,
                    //   ),
                    // ),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: bankList.map((dynamic bank) {
                    return DropdownMenuItem<String>(
                      value: bank['bank_code'].toString(),
                      child: Text(
                        bank['name'],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // Handle selected value
                    bankCode = value;
                    dynamic selectedBank = bankList
                        .firstWhere((bank) => bank['bank_code'] == value);
                    selectedBankName = selectedBank['name'].toString();
                    print(bankCode);
                    print(selectedBankName);
                  },
                ),
              ),
              AppTextFormField(
                validator: emptyStringValidation,
                textEditingController: number,
                label: "",
                hintText: "Enter Account Number",
              ),
              heightSpace(3),
              ChasescrollButton(
                buttonText: "Register Account",
                onTap: () {
                  onSubmit();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSubmit() async {
    if (number.text.isEmpty) {
      ToastResp.toastMsgError(
          resp: "Account Number Needed, should not be empty");
      return;
    } else {
      log(number.text);
      log(bankCode.toString());

      final result = await _walletRepository.onBoardPayStack(
        accountNumber: number.text,
        code: bankCode.toString(),
      );

      if (result) {
        context.pop();
        ToastResp.toastMsgSuccess(resp: "Set up payStack Successful");
      } else {
        ToastResp.toastMsgError(resp: "Set up payStack not Successful");
      }
    }
  }
}
