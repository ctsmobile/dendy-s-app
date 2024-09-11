// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:dendy_app/customWidgets/customAppBar.dart';
import 'package:dendy_app/customWidgets/customLoader.dart';
import 'package:dendy_app/customWidgets/customText.dart';
import 'package:dendy_app/routes.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_builder/timer_builder.dart';

class PendingDetailsScreen extends StatelessWidget {
  const PendingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appThemeColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: MyAppBar(
            title: 'Details',
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                                top: 15.0, left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  elevation: 0,
                                  color: whiteColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: CustomText(
                                                text:
                                                    'Exhaust Hood System Cleaning',
                                                textColor: purpleColor,
                                                maxLines: 1,
                                                textOverflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Utils.height! / 70,
                                        ),
                                        Row(
                                          children: [
                                            Transform.scale(
                                              scale: 0.7,
                                              child: Image.asset(
                                                '${baseImagePath}profilee.png',
                                              ),
                                            ),
                                            SizedBox(
                                              width: Utils.width! / 30,
                                            ),
                                            CustomText(
                                              text: 'Alex',
                                              maxLines: 1,
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Utils.height! / 100,
                                        ),
                                        Row(
                                          children: [
                                            Transform.scale(
                                              scale: 0.7,
                                              child: Image.asset(
                                                '${baseImagePath}calender.png',
                                              ),
                                            ),
                                            SizedBox(
                                              width: Utils.width! / 30,
                                            ),
                                            CustomText(
                                              text: '04-09-2024 | 10:00',
                                              maxLines: 1,
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Utils.height! / 100,
                                        ),
                                        Row(
                                          children: [
                                            Transform.scale(
                                              scale: 0.7,
                                              child: Image.asset(
                                                '${baseImagePath}phone.png',
                                              ),
                                            ),
                                            SizedBox(
                                              width: Utils.width! / 30,
                                            ),
                                            CustomText(
                                              text: '+1 9876543210',
                                              maxLines: 1,
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Utils.height! / 100,
                                        ),
                                        Row(
                                          children: [
                                            Transform.scale(
                                              scale: 0.7,
                                              child: Image.asset(
                                                '${baseImagePath}sent.png',
                                              ),
                                            ),
                                            SizedBox(
                                              width: Utils.width! / 30,
                                            ),
                                            Expanded(
                                              child: CustomText(
                                                text:
                                                    '904 E. California Street. Ontario. CA. 91761.',
                                                maxLines: 1,
                                                textOverflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Utils.height! / 80,
                                ),
                                Card(
                                  elevation: 0,
                                  color: whiteColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Transform.scale(
                                              scale: 0.7,
                                              child: Image.asset(
                                                '${baseImagePath}addProfile.png',
                                              ),
                                            ),
                                            SizedBox(
                                              width: Utils.width! / 30,
                                            ),
                                            Row(
                                              children: [
                                                CustomText(
                                                  text: 'Aman',
                                                  maxLines: 1,
                                                  textOverflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                CustomText(
                                                  text: ' (Team Lead)',
                                                  maxLines: 1,
                                                  textColor: purpleColor,
                                                  textOverflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Utils.height! / 100,
                                        ),
                                        Row(
                                          children: [
                                            Transform.scale(
                                              scale: 0.7,
                                              child: Image.asset(
                                                '${baseImagePath}addProfile.png',
                                              ),
                                            ),
                                            SizedBox(
                                              width: Utils.width! / 30,
                                            ),
                                            CustomText(
                                              text: 'Jerry',
                                              maxLines: 1,
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Utils.height! / 60,
                                ),
                                Card(
                                  elevation: 0,
                                  color: whiteColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: 'Task List',
                                          textColor: purpleColor,
                                        ),
                                        SizedBox(
                                          height: Utils.height! / 30,
                                        ),
                                        ListView.separated(
                                          itemCount: 4,
                                          separatorBuilder: (context, index) {
                                            return SizedBox(
                                              height: 10,
                                            );
                                          },
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                  text: names[index],
                                                  textColor: grayColor,
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Utils.height! / 10,
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
                    onPressed: () {
                      Get.offAllNamed(RouteConstant.uploadImageScreen);
                    },
                    child:
                        // controller.isLoginTap.value
                        //     ? Loader(
                        //         color: whiteColor,
                        //       )
                        //     :
                        Center(
                      child: Text(
                        "Start",
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
    );
  }
}
