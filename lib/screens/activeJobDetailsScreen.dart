// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, must_be_immutable, unused_local_variable

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
import 'package:get_storage/get_storage.dart';
import 'package:timer_builder/timer_builder.dart';

import '../routes.dart';

class ActiveJobDetailsScreen extends StatelessWidget {
  ActiveJobDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ActiveJobController controller = Get.put(ActiveJobController());

    return Obx(() => Scaffold(
          backgroundColor: appThemeColor,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: MyAppBar(
                title: 'Active Job',
                isLeading: !controller.onlyOne.value,
              )),
          body: WillPopScope(
            onWillPop: () async {
              print("controller.onlyOne.value${controller.onlyOne.value}");
              if (controller.onlyOne.value) {
                Get.offAllNamed(RouteConstant.dashboardScreen);
              } else {
                Get.back();
              }
              return false;
            },
            child: RefreshIndicator(
              color: purpleColor,
              onRefresh: () async {
                if (controller.onlyOne.value) {
                  Get.offAllNamed(
                    RouteConstant.activeJobListScreen,
                  );
                }
              },
              child: SingleChildScrollView(
                physics: controller.onlyOne.value
                    ? AlwaysScrollableScrollPhysics()
                    : null,
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
                                              padding: const EdgeInsets.only(
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
                                                        isScrollControlled:
                                                            true,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16.0),
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
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            CustomText(
                                                                          text:
                                                                              'Customer Info',
                                                                          textColor:
                                                                              purpleColor,
                                                                          maxLines:
                                                                              1,
                                                                          textOverflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            bottom:
                                                                                10.0),
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Get.back();
                                                                          },
                                                                          child:
                                                                              Image.asset(
                                                                            '${baseImagePath}close.png',
                                                                            height:
                                                                                Utils.height! / 30,
                                                                            width:
                                                                                Utils.width! / 10,
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
                                                                      Image
                                                                          .asset(
                                                                        '${baseImagePath}profilee.png',
                                                                        height:
                                                                            Utils.height! /
                                                                                20,
                                                                        width: Utils.width! /
                                                                            20,
                                                                      ),
                                                                      SizedBox(
                                                                        width: Utils.width! /
                                                                            30,
                                                                      ),
                                                                      CustomText(
                                                                        text: controller
                                                                            .activeJobModel
                                                                            .value
                                                                            .data[controller.iindex.value]
                                                                            .customer
                                                                            .name
                                                                            .toString(),
                                                                        maxLines:
                                                                            1,
                                                                        textOverflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        Utils.height! /
                                                                            100,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        '${baseImagePath}calender.png',
                                                                        height:
                                                                            Utils.height! /
                                                                                20,
                                                                        width: Utils.width! /
                                                                            20,
                                                                      ),
                                                                      SizedBox(
                                                                        width: Utils.width! /
                                                                            30,
                                                                      ),
                                                                      CustomText(
                                                                        text: controller
                                                                            .activeJobModel
                                                                            .value
                                                                            .data[controller.iindex.value]
                                                                            .date
                                                                            .toString(),
                                                                        maxLines:
                                                                            1,
                                                                        textOverflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        Utils.height! /
                                                                            100,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        '${baseImagePath}watch.png',
                                                                        height:
                                                                            Utils.height! /
                                                                                20,
                                                                        width: Utils.width! /
                                                                            20,
                                                                      ),
                                                                      SizedBox(
                                                                        width: Utils.width! /
                                                                            30,
                                                                      ),
                                                                      CustomText(
                                                                        text: controller.activeJobModel.value.data[controller.iindex.value].time ==
                                                                                'null'
                                                                            ? ''
                                                                            : converter24To12(controller.activeJobModel.value.data[controller.iindex.value].time!),
                                                                        maxLines:
                                                                            1,
                                                                        textOverflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        Utils.height! /
                                                                            100,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        '${baseImagePath}phone.png',
                                                                        height:
                                                                            Utils.height! /
                                                                                20,
                                                                        width: Utils.width! /
                                                                            20,
                                                                      ),
                                                                      SizedBox(
                                                                        width: Utils.width! /
                                                                            30,
                                                                      ),
                                                                      CustomText(
                                                                        text: controller
                                                                            .activeJobModel
                                                                            .value
                                                                            .data[controller.iindex.value]
                                                                            .customer
                                                                            .contactNumber
                                                                            .toString(),
                                                                        maxLines:
                                                                            1,
                                                                        textOverflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        Utils.height! /
                                                                            100,
                                                                  ),
                                                                  GestureDetector(
                                                                    child: Row(
                                                                      crossAxisAlignment: controller.activeJobModel.value.data[controller.iindex.value].customer.location.toString().length <
                                                                              30
                                                                          ? CrossAxisAlignment
                                                                              .center
                                                                          : CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Image
                                                                            .asset(
                                                                          '${baseImagePath}sent.png',
                                                                          height:
                                                                              Utils.height! / 20,
                                                                          width:
                                                                              Utils.width! / 20,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              Utils.width! / 30,
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              CustomText(
                                                                            text:
                                                                                controller.activeJobModel.value.data[controller.iindex.value].customer.location.toString(),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    onTap: () {
                                                                      launchURL(
                                                                          Uri.parse(
                                                                              'https://www.google.com/maps/search/?api=1&query=${controller.activeJobModel.value.data[controller.iindex.value].customer.lat.toString()},${controller.activeJobModel.value.data[controller.iindex.value].customer.lng.toString()}'));
                                                                    },
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
                                              padding: const EdgeInsets.only(
                                                  right: 20.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomText(
                                                    text: 'Assigned Employees',
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
                                                        builder: (BuildContext
                                                            context) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16.0),
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
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            CustomText(
                                                                          text:
                                                                              'Assigned Employees',
                                                                          textColor:
                                                                              purpleColor,
                                                                          maxLines:
                                                                              1,
                                                                          textOverflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            bottom:
                                                                                10.0),
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Get.back();
                                                                          },
                                                                          child:
                                                                              Image.asset(
                                                                            '${baseImagePath}close.png',
                                                                            height:
                                                                                Utils.height! / 30,
                                                                            width:
                                                                                Utils.width! / 10,
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
                                                                  ListView
                                                                      .separated(
                                                                          itemCount: controller
                                                                              .activeJobModel
                                                                              .value
                                                                              .data[controller
                                                                                  .iindex.value]
                                                                              .employees
                                                                              .where((employee) =>
                                                                                  employee.jobuser !=
                                                                                  null)
                                                                              .length,
                                                                          separatorBuilder:
                                                                              (context,
                                                                                  employeesIndex) {
                                                                            return SizedBox(
                                                                              height: 10,
                                                                            );
                                                                          },
                                                                          shrinkWrap:
                                                                              true,
                                                                          physics:
                                                                              NeverScrollableScrollPhysics(),
                                                                          itemBuilder:
                                                                              (BuildContext context, int employeesIndex) {
                                                                            final filteredEmployees =
                                                                                controller.activeJobModel.value.data[controller.iindex.value].employees.where((employee) => employee.jobuser != null).toList();

                                                                            final employee =
                                                                                filteredEmployees[employeesIndex];
                                                                            return Row(
                                                                              children: [
                                                                                Image.asset(
                                                                                  '${baseImagePath}addProfile.png',
                                                                                  height: Utils.height! / 20,
                                                                                  width: Utils.width! / 20,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: Utils.width! / 30,
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    CustomText(
                                                                                      text: employee.jobuser!.name.toString(),
                                                                                      maxLines: 1,
                                                                                      textOverflow: TextOverflow.ellipsis,
                                                                                    ),
                                                                                    CustomText(
                                                                                      text: employee.crewLead == 1 ? ' (Team Lead)' : '',
                                                                                      maxLines: 1,
                                                                                      textColor: purpleColor,
                                                                                      textOverflow: TextOverflow.ellipsis,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            );
                                                                          }),
                                                                  SizedBox(
                                                                    height:
                                                                        Utils.height! /
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
                                            controller
                                                    .activeJobModel
                                                    .value
                                                    .data[
                                                        controller.iindex.value]
                                                    .tasks
                                                    .isEmpty
                                                ? SizedBox()
                                                : SizedBox(
                                                    height: Utils.height! / 20,
                                                  ),
                                            controller
                                                    .activeJobModel
                                                    .value
                                                    .data[
                                                        controller.iindex.value]
                                                    .tasks
                                                    .isEmpty
                                                ? SizedBox()
                                                : Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                              padding: const EdgeInsets.only(
                                                  right: 20.0),
                                              child: ListView.separated(
                                                itemCount: controller
                                                    .activeJobModel
                                                    .value
                                                    .data[
                                                        controller.iindex.value]
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
                                                        int tasksIndex) {
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: CustomText(
                                                          text: controller
                                                              .activeJobModel
                                                              .value
                                                              .data[controller
                                                                  .iindex.value]
                                                              .tasks[tasksIndex]
                                                              .taskName
                                                              .toString(),
                                                          textColor: grayColor,
                                                          maxLines: 2,
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (controller
                                                                  .activeJobModel
                                                                  .value
                                                                  .data[controller
                                                                      .iindex
                                                                      .value]
                                                                  .tasks[
                                                                      tasksIndex]
                                                                  .status ==
                                                              0) {
                                                            controller
                                                                .updateTaskStatus(
                                                                    controller
                                                                        .iindex
                                                                        .value,
                                                                    tasksIndex,
                                                                    1);
                                                          } else {
                                                            controller
                                                                .updateTaskStatus(
                                                                    controller
                                                                        .iindex
                                                                        .value,
                                                                    tasksIndex,
                                                                    0);
                                                          }
                                                        },
                                                        child: Container(
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
                                                                      .all(8.0),
                                                              child: controller
                                                                          .activeJobModel
                                                                          .value
                                                                          .data[controller
                                                                              .iindex
                                                                              .value]
                                                                          .tasks[
                                                                              tasksIndex]
                                                                          .status ==
                                                                      1
                                                                  ? Image.asset(
                                                                      '${baseImagePath}check.png')
                                                                  : SizedBox(),
                                                            )),
                                                      )
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
                                    alignment: AlignmentDirectional.topCenter,
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
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
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
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                                color:
                                                    whiteColor.withOpacity(0.7),
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
                                              String time = getTimeDifference(
                                                  controller
                                                      .activeJobModel
                                                      .value
                                                      .data[controller
                                                          .iindex.value]
                                                      .job_start_time!);
                                              print("ttt$time");
                                              final regex = RegExp(
                                                  r"(\d+)\s+days\s+(\d+)\s+Hours\s+(\d+)\s+Min\s+(\d+)\s+Sec",
                                                  caseSensitive: false);

                                              final match =
                                                  regex.firstMatch(time);
                                              String days = '';
                                              String hours = '';
                                              String minutes = '';
                                              String seconds = '';
                                              if (match != null) {
                                                days = match.group(1)!.padLeft(
                                                    2, '0'); // Keeps "01"
                                                hours = match.group(2)!.padLeft(
                                                    2, '0'); // Keeps "00"
                                                minutes = match
                                                    .group(3)!
                                                    .padLeft(2, '0');
                                                seconds = match
                                                    .group(4)!
                                                    .padLeft(2, '0');
                                              } else {
                                                print("Invalid format");
                                              }
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        days == '00'
                                                            ? '$hours :'
                                                            : '$days :',
                                                        style: TextStyle(
                                                            color: blackColor,
                                                            fontSize: 26,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      CustomText(
                                                        text: days == '00'
                                                            ? 'HOURS'
                                                            : 'DAYS',
                                                        fontSize: 12,
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        days == '00'
                                                            ? '$minutes :'
                                                            : '$hours :',
                                                        style: TextStyle(
                                                            color: blackColor,
                                                            fontSize: 26,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      CustomText(
                                                        text: days == '00'
                                                            ? 'MINUTES'
                                                            : 'HOURS',
                                                        fontSize: 12,
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        days == '00'
                                                            ? seconds
                                                            : minutes,
                                                        style: TextStyle(
                                                            color: blackColor,
                                                            fontSize: 26,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      CustomText(
                                                        text: days == '00'
                                                            ? 'SECONDS'
                                                            : 'MINUTES',
                                                        fontSize: 12,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            }),
                                            // Row(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment
                                            //           .spaceBetween,
                                            //   children: [
                                            //     Padding(
                                            //       padding: EdgeInsets.only(
                                            //           left: Utils.width! < 380
                                            //               ? 7
                                            //               : Utils.width! < 395
                                            //                   ? 10
                                            //                   : 15.0),
                                            //       child: CustomText(
                                            //         text: 'HOUR',
                                            //         fontSize: 12,
                                            //       ),
                                            //     ),
                                            //     Padding(
                                            //       padding:
                                            //           const EdgeInsets
                                            //               .only(
                                            //               left: 5.0),
                                            //       child: CustomText(
                                            //         text: 'MINUTE',
                                            //         fontSize: 12,
                                            //       ),
                                            //     ),
                                            //     Padding(
                                            //       padding:
                                            //           const EdgeInsets
                                            //               .only(
                                            //         left: 3.0,
                                            //       ),
                                            //       child: CustomText(
                                            //         text: 'SECOND',
                                            //         fontSize: 12,
                                            //         maxLines: 1,
                                            //       ),
                                            //     ),
                                            //     SizedBox(
                                            //       width: 1,
                                            //     ),
                                            //   ],
                                            // )
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
                                        borderRadius: const BorderRadius.all(
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
                     controller
                                          .activeJobModel
                                          .value
                                          .data[controller.iindex.value].employees.firstWhere((employee) => 
                                                                                  employee.employeeId ==
                                                                                  GetStorage().read('user_id')as int).clock_out!=null?SizedBox():     Positioned(
                            bottom: 36,
                            child: Container(
                              width: Utils.width! / 1.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: purpleColor),
                              child: CupertinoButton(
                                onPressed: () async {
                                  if (GetStorage().read('user_id') !=
                                      controller
                                          .activeJobModel
                                          .value
                                          .data[controller.iindex.value]
                                          .team_lead) {
                                            if( controller
                                          .activeJobModel
                                          .value
                                          .data[controller.iindex.value].employees.firstWhere((employee) => 
                                                                                  employee.employeeId ==
                                                                                  GetStorage().read('user_id')as int).clock_in==null){


                                                                                    controller.clockIn(  controller
                                          .activeJobModel
                                          .value
                                          .data[controller.iindex.value].id);




                                                                                  }else{
                                                                                       controller.clockIn(  controller
                                          .activeJobModel
                                          .value
                                          .data[controller.iindex.value].id, isClockIn: false);

                                                                                  }



                             
                                  } else {
                                    bool allChecked = controller
                                        .activeJobModel
                                        .value
                                        .data[controller.iindex.value]
                                        .tasks
                                        .every((task) => task.status == 1);

                                    if (allChecked) {
                                      await GetStorage().write(
                                          'jobId',
                                          controller.activeJobModel.value
                                              .data[controller.iindex.value].id
                                              .toString());
                                      await GetStorage()
                                          .write('finishJob', true);

                                      Get.toNamed(
                                        RouteConstant.uploadImageScreen,
                                      );
                                    } else {
                                      if (!Get.isSnackbarOpen) {
                                        showSnackBar(
                                            'Please complete all the tasks first!');
                                      }
                                    }
                                  }
                                },
                                child:controller.isClockInTap.value?Loader(): CustomText(
                                  text:(GetStorage().read('user_id') ==
                                      controller
                                          .activeJobModel
                                          .value
                                          .data[controller.iindex.value]
                                          .team_lead) ? "Upload Completion Images":  ( controller
                                          .activeJobModel
                                          .value
                                          .data[controller.iindex.value].employees.firstWhere((employee) => 
                                                                                  employee.employeeId ==
                                                                                  GetStorage().read('user_id')as int).clock_in==null?'Clock-In':'Clock-Out'),
                                  textColor: appThemeColor,
                                  fontSize: 20.0,
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
          ),
          bottomNavigationBar: controller.onlyOne.value
              ? CommonBottomBar(
                  index: 1,
                )
              : null,
        ));
  }
}
