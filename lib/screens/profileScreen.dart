// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:dendy_app/customWidgets/customAppBar.dart';
import 'package:dendy_app/customWidgets/customBottomBar.dart';
import 'package:dendy_app/customWidgets/customText.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appThemeColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: MyAppBar(
            title: 'Profile',
            isLeading: false,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Card(
                          elevation: 7,
                          color: appThemeColor,
                          shadowColor: innerShadowColor,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 20, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      '${baseImagePath}profilee2.png',
                                      height: Utils.height! / 20,
                                      width: Utils.width! / 10,
                                    ),
                                    SizedBox(
                                      width: Utils.width! / 20,
                                    ),
                                    CustomText(
                                      text: 'Jenny',
                                      textColor: purpleColor,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      '${baseImagePath}inbox.png',
                                      height: Utils.height! / 20,
                                      width: Utils.width! / 10,
                                    ),
                                    SizedBox(
                                      width: Utils.width! / 20,
                                    ),
                                    CustomText(
                                      text: 'jenny@gmail.com',
                                      textColor: purpleColor,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      '${baseImagePath}call.png',
                                      height: Utils.height! / 20,
                                      width: Utils.width! / 10,
                                    ),
                                    SizedBox(
                                      width: Utils.width! / 20,
                                    ),
                                    CustomText(
                                      text: '+1 9876543210',
                                      textColor: purpleColor,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      '${baseImagePath}sent2.png',
                                      height: Utils.height! / 20,
                                      width: Utils.width! / 10,
                                    ),
                                    SizedBox(
                                      width: Utils.width! / 20,
                                    ),
                                    Expanded(
                                      child: CustomText(
                                        text:
                                            '904 E. California Street. Ontario. CA. 91761.',
                                        textColor: purpleColor,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: Utils.height! / 3,
                                ),
                              ],
                            ),
                          )),
                      Positioned(
                        bottom: -50,
                        child: Container(
                          width: 230,
                          height: 100,
                          margin: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 3,
                          ),
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border(
                                top:
                                    BorderSide(color: appThemeColor, width: 7)),
                            boxShadow: [
                              BoxShadow(
                                  color: innerShadowColor.withOpacity(0.9),
                                  offset: Offset(0, -2)),
                              BoxShadow(
                                  color: innerShadowColor.withOpacity(0.9),
                                  offset: Offset(2, 0)),
                              BoxShadow(
                                  color: innerShadowColor.withOpacity(0.5),
                                  offset: Offset(-2, 0)),
                              BoxShadow(
                                  color: appThemeColor,
                                  spreadRadius: -1.0,
                                  blurRadius: 1.0,
                                  offset: Offset(0, 0)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
              Positioned(
                bottom: 30,
                child: Container(
                  width: 200,
                  // height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: purpleColor),
                  child: CupertinoButton(
                    onPressed: () {},
                    child:
                        // controller.isLoginTap.value
                        //     ? Loader(
                        //         color: whiteColor,
                        //       )
                        //     :
                        Center(
                      child: Text(
                        "Logout",
                        style: GoogleFonts.amaranth(
                          color: appThemeColor,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CommonBottomBar(
        index: 2,
      ),
    );
  }
}
