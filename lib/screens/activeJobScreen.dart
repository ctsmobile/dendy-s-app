// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:dendy_app/controllers/activeJobController.dart';
import 'package:dendy_app/customWidgets/customAppBar.dart';
import 'package:dendy_app/customWidgets/customBottomBar.dart';
import 'package:dendy_app/customWidgets/customLoader.dart';
import 'package:dendy_app/customWidgets/customText.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_builder/timer_builder.dart';

import '../routes.dart';

class ActiveJobScreen extends StatelessWidget {
  const ActiveJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ActiveJobController controller = Get.put(ActiveJobController());

    return Obx(() => Scaffold(
          backgroundColor: appThemeColor,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: MyAppBar(
                title: 'Active Job',
                isLeading: false,
              )),
          body: WillPopScope(
            onWillPop: () async {
              Get.offAllNamed(RouteConstant.dashboardScreen);

              return false;
            },
            child: controller.isDataLoading.value
                ? Center(
                    child: Loader(
                      color: purpleColor,
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Column(
                                children: [
                                  Stack(
                                    alignment: AlignmentDirectional.topCenter,
                                    children: [
                                      Card(
                                          elevation: 3,
                                          color: appThemeColor,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 130.0, left: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomText(
                                                        text: 'Customer Info',
                                                        textColor: purpleColor,
                                                      ),
                                                      GestureDetector(
                                                        child: Image.asset(
                                                          '${baseImagePath}info.png',
                                                          height: 20,
                                                          width: 20,
                                                        ),
                                                        onTap: () {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            isDismissible:
                                                                false,
                                                            isScrollControlled:
                                                                true,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        16.0),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          15.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                CustomText(
                                                                              text: 'Customer Info',
                                                                              textColor: purpleColor,
                                                                              maxLines: 1,
                                                                              textOverflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(bottom: 10.0),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                Get.back();
                                                                              },
                                                                              child: Image.asset(
                                                                                '${baseImagePath}close.png',
                                                                                height: Utils.height! / 30,
                                                                                width: Utils.width! / 10,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            Utils.height! /
                                                                                70,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Transform
                                                                              .scale(
                                                                            scale:
                                                                                0.7,
                                                                            child:
                                                                                Image.asset(
                                                                              '${baseImagePath}profilee.png',
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                Utils.width! / 30,
                                                                          ),
                                                                          CustomText(
                                                                            text:
                                                                                controller.activeJobModel.data.first.customer.name.toString(),
                                                                            maxLines:
                                                                                1,
                                                                            textOverflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: Utils.height! /
                                                                            100,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Transform
                                                                              .scale(
                                                                            scale:
                                                                                0.7,
                                                                            child:
                                                                                Image.asset(
                                                                              '${baseImagePath}calender.png',
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                Utils.width! / 30,
                                                                          ),
                                                                          CustomText(
                                                                            text:
                                                                                controller.activeJobModel.data.first.customer.createdAt.toString(),
                                                                            maxLines:
                                                                                1,
                                                                            textOverflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: Utils.height! /
                                                                            100,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Transform
                                                                              .scale(
                                                                            scale:
                                                                                0.7,
                                                                            child:
                                                                                Image.asset(
                                                                              '${baseImagePath}watch.png',
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                Utils.width! / 30,
                                                                          ),
                                                                          CustomText(
                                                                            text:
                                                                                '10:00',
                                                                            maxLines:
                                                                                1,
                                                                            textOverflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: Utils.height! /
                                                                            100,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Transform
                                                                              .scale(
                                                                            scale:
                                                                                0.7,
                                                                            child:
                                                                                Image.asset(
                                                                              '${baseImagePath}phone.png',
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                Utils.width! / 30,
                                                                          ),
                                                                          CustomText(
                                                                            text:
                                                                                controller.activeJobModel.data.first.customer.contactNumber.toString(),
                                                                            maxLines:
                                                                                1,
                                                                            textOverflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: Utils.height! /
                                                                            100,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Transform
                                                                              .scale(
                                                                            scale:
                                                                                0.7,
                                                                            child:
                                                                                Image.asset(
                                                                              '${baseImagePath}sent.png',
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                Utils.width! / 30,
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                CustomText(
                                                                              text: '904 E. California Street. Ontario. CA. 91761.',
                                                                              maxLines: 1,
                                                                              textOverflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Utils.height! / 60,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            'Assigned Employees',
                                                        textColor: purpleColor,
                                                      ),
                                                      GestureDetector(
                                                        child: Image.asset(
                                                          '${baseImagePath}info.png',
                                                          height: 20,
                                                          width: 20,
                                                        ),
                                                        onTap: () {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            isScrollControlled:
                                                                true,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        16.0),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          15.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                CustomText(
                                                                              text: 'Assigned Employees',
                                                                              textColor: purpleColor,
                                                                              maxLines: 1,
                                                                              textOverflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(bottom: 10.0),
                                                                            child:
                                                                                Image.asset(
                                                                              '${baseImagePath}close.png',
                                                                              height: Utils.height! / 30,
                                                                              width: Utils.width! / 10,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            Utils.height! /
                                                                                70,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Transform
                                                                              .scale(
                                                                            scale:
                                                                                0.7,
                                                                            child:
                                                                                Image.asset(
                                                                              '${baseImagePath}addProfile.png',
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                Utils.width! / 30,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              CustomText(
                                                                                text: 'Aman',
                                                                                maxLines: 1,
                                                                                textOverflow: TextOverflow.ellipsis,
                                                                              ),
                                                                              CustomText(
                                                                                text: ' (Team Lead)',
                                                                                maxLines: 1,
                                                                                textColor: purpleColor,
                                                                                textOverflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: Utils.height! /
                                                                            100,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Transform
                                                                              .scale(
                                                                            scale:
                                                                                0.7,
                                                                            child:
                                                                                Image.asset(
                                                                              '${baseImagePath}addProfile.png',
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                Utils.width! / 30,
                                                                          ),
                                                                          CustomText(
                                                                            text:
                                                                                'Jerry',
                                                                            maxLines:
                                                                                1,
                                                                            textOverflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: Utils.height! /
                                                                            100,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Utils.height! / 20,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                      text: 'Task List',
                                                      textColor: purpleColor,
                                                    ),
                                                    Expanded(
                                                      child: CustomText(
                                                        text:
                                                            ' (Check each task when completed)',
                                                        textColor: grayColor,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Utils.height! / 60,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20.0),
                                                  child: ListView.separated(
                                                    itemCount: controller
                                                        .activeJobModel
                                                        .data
                                                        .first
                                                        .tasks
                                                        .length,
                                                    separatorBuilder:
                                                        (context, index) {
                                                      return SizedBox(
                                                        height: 20,
                                                      );
                                                    },
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: CustomText(
                                                              text: controller
                                                                  .activeJobModel
                                                                  .data
                                                                  .first
                                                                  .tasks[index]
                                                                  .taskName
                                                                  .toString(),
                                                              textColor:
                                                                  grayColor,
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                          Container(
                                                              height: 35,
                                                              width: 35,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color:
                                                                        whiteColor,
                                                                    width: 2),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color:
                                                                        innerShadowColor,
                                                                  ),
                                                                  BoxShadow(
                                                                      color: appThemeColor
                                                                          .withOpacity(
                                                                              0.7),
                                                                      spreadRadius:
                                                                          -2.0,
                                                                      blurRadius:
                                                                          5.0,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              2)),
                                                                  BoxShadow(
                                                                      color: appThemeColor
                                                                          .withOpacity(
                                                                              0.7),
                                                                      spreadRadius:
                                                                          -2.0,
                                                                      blurRadius:
                                                                          5.0,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              2)),
                                                                ],
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: controller
                                                                            .activeJobModel
                                                                            .data
                                                                            .first
                                                                            .tasks[
                                                                                index]
                                                                            .status ==
                                                                        1
                                                                    ? Image.asset(
                                                                        '${baseImagePath}check.png')
                                                                    : SizedBox(),
                                                              ))
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Utils.height! / 10,
                                                ),
                                              ],
                                            ),
                                          )),
                                      Stack(
                                        alignment:
                                            AlignmentDirectional.topCenter,
                                        children: [
                                          Container(
                                            width: Utils.width! / 1.6,
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
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10)),
                                              border: Border(
                                                  top: BorderSide(
                                                      color: appThemeColor,
                                                      width: 7)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: innerShadowColor
                                                        .withOpacity(0.9),
                                                    offset: Offset(2, 0)),
                                                BoxShadow(
                                                    color: innerShadowColor
                                                        .withOpacity(0.5),
                                                    offset: Offset(-2, 0)),
                                                BoxShadow(
                                                    color: appThemeColor,
                                                    spreadRadius: -1.0,
                                                    blurRadius: 1.0,
                                                    offset: Offset(0, 0)),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: Utils.width! / 1.8,
                                            height: 86,
                                            margin: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 4,
                                            ),
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: whiteColor
                                                        .withOpacity(0.7),
                                                    spreadRadius: 10.0,
                                                    blurRadius: 7,
                                                    offset: Offset(3, 2)),
                                                BoxShadow(
                                                    color: appThemeColor
                                                        .withOpacity(0.7),
                                                    spreadRadius: 10.0,
                                                    blurRadius: 7,
                                                    offset: Offset(0, -60)),
                                                BoxShadow(
                                                  color: innerShadowColor
                                                      .withOpacity(0.7),
                                                ),
                                                BoxShadow(
                                                    color: appThemeColor
                                                        .withOpacity(0.7),
                                                    spreadRadius: -2.0,
                                                    blurRadius: 5.0,
                                                    offset: Offset(0, 2)),
                                                BoxShadow(
                                                    color: appThemeColor
                                                        .withOpacity(0.7),
                                                    spreadRadius: -2.0,
                                                    blurRadius: 5.0,
                                                    offset: Offset(0, 2)),
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TimerBuilder.periodic(
                                                    Duration(seconds: 1),
                                                    builder: (context) {
                                                  return SizedBox(
                                                    width: 200,
                                                    child: Text(
                                                      "${getSystemTime()}",
                                                      style: TextStyle(
                                                          color: blackColor,
                                                          fontSize: 35,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  );
                                                }),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 18,
                                                    ),
                                                    CustomText(
                                                      text: 'HOUR',
                                                      fontSize: 12,
                                                    ),
                                                    SizedBox(
                                                      width: 27,
                                                    ),
                                                    CustomText(
                                                      text: 'MINUTE',
                                                      fontSize: 12,
                                                    ),
                                                    SizedBox(
                                                      width: 25,
                                                    ),
                                                    Expanded(
                                                      child: CustomText(
                                                        text: 'SECOND',
                                                        fontSize: 12,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        bottom: -50,
                                        child: Container(
                                          width: Utils.width! / 1.3,
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
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            border: Border(
                                                top: BorderSide(
                                                    color: appThemeColor,
                                                    width: 7)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: innerShadowColor
                                                      .withOpacity(0.9),
                                                  offset: Offset(-1, -2)),
                                              BoxShadow(
                                                  color: innerShadowColor
                                                      .withOpacity(0.9),
                                                  offset: Offset(1, -2)),
                                              BoxShadow(
                                                  color: appThemeColor,
                                                  spreadRadius: 1.0,
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
                                  ) //
                                ],
                              ),
                              Positioned(
                                bottom: 36,
                                child: Container(
                                  width: Utils.width! / 1.4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: purpleColor),
                                  child: CupertinoButton(
                                    onPressed: () {
                                      Get.toNamed(
                                          RouteConstant.uploadImageScreen,
                                          arguments: 'finishJob');
                                    },
                                    child: CustomText(
                                      text: "Upload Completion Images",
                                      textColor: appThemeColor,
                                      fontSize: 20,
                                      maxLines: 1,
                                      textOverflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          bottomNavigationBar: CommonBottomBar(
            index: 1,
          ),
        ));
  }
}
