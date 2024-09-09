// ignore_for_file: prefer_const_constructors

import 'package:dendy_app/customWidgets/customText.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appThemeColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  '${baseImagePath}small.png',
                  fit: BoxFit.cover,
                  height: Utils.height! / 2.5,
                  width: Utils.width! / 1.5,
                ),
              ),
              SizedBox(
                height: Utils.height! / 40,
              ),
              CustomText(
                text: 'Hood Cleaning Services',
                textColor: purpleColor,
                fontWeight: FontWeight.w400,
                fontSize: 40,
              ),
              SizedBox(
                height: Utils.height! / 50,
              ),
              CustomText(
                text: welcomeText,
                textFontAmiri: true,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 40),
        height: 64,
        width: 64,
        child: FloatingActionButton(
            backgroundColor: purpleColor,
            elevation: 4,
            onPressed: () => debugPrint("Add Button pressed"),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 3, color: purpleColor),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              Icons.arrow_forward_ios,
              color: whiteColor,
              size: 32,
            )),
      ),
    );
  }
}
