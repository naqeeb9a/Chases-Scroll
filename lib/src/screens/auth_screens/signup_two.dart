import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/repositories/auth_repository.dart';
import 'package:chases_scroll/src/screens/auth_screens/data.dart';
import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/helpers/validations.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

returnBackendDate(date) =>
    "${date!.day.toString().padLeft(2, '0')}/${date!.month.toString().padLeft(2, '0')}/${date!.year}";

returnDateFormat(date) =>
    "${date!.day.toString().padLeft(2, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.year}";

class SignupTwoScreen extends StatefulWidget {
  final SignupOneModel signupData;
  const SignupTwoScreen({super.key, required this.signupData});

  @override
  State<SignupTwoScreen> createState() => _SignupTwoScreenState();
}

class _SignupTwoScreenState extends State<SignupTwoScreen> {
  static final _formKey = GlobalKey<FormState>();
  static final emailController = TextEditingController();
  static final phoneNumber = TextEditingController();

  final AuthRepository _authRepository = AuthRepository();
  DateTime? date;
  int todayDate = DateTime.now().year;
  int? dateSelected;
  bool ageValid = false;
  bool agreeTerms = false;
  void agreeTermsBox() {
    setState(() {
      agreeTerms = !agreeTerms;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                heightSpace(5),
                Center(child: Image.asset(AppImages.logo)),
                heightSpace(2),
                customText(
                    text: "Sign Up", fontSize: 20, textColor: AppColors.black),
                heightSpace(2),
                IntlPhoneField(
                  disableLengthCheck: false,
                  controller: phoneNumber,
                  decoration: InputDecoration(
                    enabledBorder: AppColors.normalBorder,
                    counter: const SizedBox.shrink(),
                    labelText: 'Phone Number',
                    hintStyle: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: AppColors.black.withOpacity(.5),
                            fontWeight: FontWeight.w500,
                            fontSize: 12.dp)),
                    disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    contentPadding: const EdgeInsets.only(left: 10),
                    errorStyle: const TextStyle(fontSize: 12),
                  ),
                  initialCountryCode: 'NG',
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                ),
                AppTextFormField(
                  validator: emailValidation,
                  textEditingController: emailController,
                  hintText: "Email Address",
                ),
                heightSpace(2),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xffE0E0E0),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: date == null
                            ? customText(
                                text: "Select date of birth",
                                fontSize: 12,
                                textColor: AppColors.black.withOpacity(.5))
                            : customText(
                                text: returnDateFormat(date),
                                fontSize: 12,
                                textColor: AppColors.black),
                      ),
                      IconButton(
                        onPressed: () async {
                          DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: date ?? DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );

                          //if cancel return null..
                          if (newDate == null) {
                            return;
                          }

                          // if ok the newDate initailize...
                          setState(() {
                            date = newDate;
                            dateSelected = newDate.year;
                          });

                          if ((todayDate - dateSelected!) >= 18) {
                            setState(() {
                              ageValid = true;
                            });
                          } else {
                            setState(() {
                              ageValid = false;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.date_range_outlined,
                          color: AppColors.primary,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                heightSpace(2),
                date != null
                    ? ageValid
                        ? Row(
                            children: [
                              const Icon(
                                Icons.check_circle_outline_rounded,
                                color: AppColors.primary,
                                size: 10,
                              ),
                              heightSpace(2),
                              customText(
                                  text: "Age is Valid",
                                  fontSize: 12,
                                  textColor: AppColors.primary),
                            ],
                          )
                        : Row(
                            children: [
                              const Icon(
                                Icons.highlight_remove_rounded,
                                color: Colors.red,
                                size: 12,
                              ),
                              widthSpace(2),
                              customText(
                                  text: "Age is not Valid",
                                  fontSize: 12,
                                  textColor: AppColors.red),
                            ],
                          )
                    : const SizedBox(),
                heightSpace(2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => agreeTermsBox(),
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            width: 1.3,
                            color: agreeTerms
                                ? AppColors.primary
                                : AppColors.primary.withOpacity(0.4),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check,
                            size: 15,
                            color: agreeTerms
                                ? AppColors.primary
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    widthSpace(2),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: RichText(
                          softWrap: true,
                          text: TextSpan(
                            text: 'I have read and agree to our, ',
                            style: GoogleFonts.dmSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' Terms of service',
                                style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         const TermsAndConditionScreenView(),
                                    //   ),
                                    // );
                                  },
                              ),
                              TextSpan(
                                text: ' and',
                                style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              TextSpan(
                                text: ' Privacy policy',
                                style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         const PrivacyPolicyScreenView(),
                                    //   ),
                                    // );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                heightSpace(3),
                ChasescrollButton(
                  buttonText: "Signup",
                  onTap: submitForm,
                ),
                heightSpace(2),
                Row(
                  children: [
                    customText(
                        text: "Already have an account?",
                        fontSize: 12,
                        textColor: AppColors.black),
                    widthSpace(1),
                    InkWell(
                      onTap: () => context.push(AppRoutes.emailScreen),
                      child: customText(
                          text: "Log In",
                          fontSize: 12,
                          textColor: AppColors.primary),
                    )
                  ],
                )
              ],
            ),
          ),
        )));
  }

  submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (!ageValid) {
        ToastResp.toastMsgError(resp: "Enter a valid age");
        return;
      }
      if (!agreeTerms) {
        ToastResp.toastMsgError(
            resp: "You must agree to the terms and conditions");
        return;
      }
      bool result = await _authRepository.signup(
          username: widget.signupData.username,
          password: widget.signupData.password,
          email: emailController.text,
          lastName: widget.signupData.lastName,
          dob: returnBackendDate(date),
          phone: phoneNumber.text,
          firstName: widget.signupData.firstname);

      if (result) {
        bool result = await _authRepository.sendEmail(emailController.text, 1);
        if (result) {
          if (context.mounted) {
            context.push(AppRoutes.pincode, extra: true);
          }
        }
      }
    }
  }
}
