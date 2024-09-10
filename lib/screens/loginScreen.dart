// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dendy_app/controllers/loginScreenController.dart';
import 'package:dendy_app/customWidgets/customLoader.dart';
import 'package:dendy_app/customWidgets/customText.dart';
import 'package:dendy_app/customWidgets/customTextfield.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginScreenController controller = Get.put(LoginScreenController());

    return Scaffold(
      backgroundColor: appThemeColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Utils.height! / 15),
              Center(
                child: Image.asset(
                  '${baseImagePath}loginbg.png',
                  fit: BoxFit.cover,
                  height: Utils.height! / 3,
                  // width: Utils.width! / 1.5,
                ),
              ),
              SizedBox(
                height: Utils.height! / 20,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Welcome to ',
                      style: GoogleFonts.amaranth(
                        color: purpleColor,
                        fontSize: 24.0,
                      ),
                    ),
                    TextSpan(
                      text: 'Hood Cleaning Services!',
                      style: GoogleFonts.amaranth(
                          fontSize: 24.0, color: blackColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Utils.height! / 20,
              ),
              Stack(
                children: [
                  Image.asset(
                    '${baseImagePath}Rectangle.png',
                    fit: BoxFit.cover,
                  ),
                  TextField(
                    style: GoogleFonts.amaranth(
                        color: grayColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20.0, top: 13),
                      hintText: 'Email Address',
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.amaranth(
                          color: grayColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Utils.height! / 40,
              ),
              Stack(
                children: [
                  Image.asset(
                    '${baseImagePath}Rectangle.png',
                    fit: BoxFit.cover,
                    // height: Utils.height! / 3,
                    // width: Utils.width! / 1.5,
                  ),
                  TextField(
                    obscureText: true,
                    style: GoogleFonts.amaranth(
                        color: grayColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: 20.0,
                        top: 20,
                      ),
                      hintText: 'Password',
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.amaranth(
                          color: grayColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Padding(
                            padding:
                                const EdgeInsets.only(top: 12.0, right: 15),
                            child: Icon(
                              controller.passwordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: grayColor,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Utils.height! / 15,
              ),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(46.0),
                    color: purpleColor),
                child: CupertinoButton(
                  onPressed: controller.isLoginTap.value ? null : () {},
                  child: controller.isLoginTap.value
                      ? Loader(
                          color: whiteColor,
                        )
                      : Text(
                          "Login",
                          style: GoogleFonts.amaranth(
                            color: appThemeColor,
                            fontSize: 20.0,
                          ),
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
