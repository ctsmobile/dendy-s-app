// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:dendy_app/Model/pendingJobListModel.dart';
import 'package:dendy_app/controllers/dashboardController.dart';
import 'package:dendy_app/controllers/pendingJobDetailsController.dart';
import 'package:dendy_app/customWidgets/customAppBar.dart';
import 'package:dendy_app/customWidgets/customLoader.dart';
import 'package:dendy_app/customWidgets/customText.dart';
import 'package:dendy_app/routes.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class PendingDetailsScreen extends StatelessWidget {
  const PendingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PendingJobDetailsController controller =
        Get.put(PendingJobDetailsController());

    return Obx(() => Scaffold(
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
                              elevation: 3,
                              color: appThemeColor,
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
                                                    text: controller
                                                        .pendingJobDetails
                                                        .name!,
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
                                                Image.asset(
                                                  '${baseImagePath}profilee.png',
                                                  height: Utils.height! / 22,
                                                  width: Utils.width! / 22,
                                                ),
                                                SizedBox(
                                                  width: Utils.width! / 30,
                                                ),
                                                CustomText(
                                                  text: controller
                                                      .pendingJobDetails
                                                      .customer
                                                      .name
                                                      .toString(),
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
                                                Image.asset(
                                                  '${baseImagePath}calender.png',
                                                  height: Utils.height! / 22,
                                                  width: Utils.width! / 22,
                                                ),
                                                SizedBox(
                                                  width: Utils.width! / 30,
                                                ),
                                                CustomText(
                                                  text:
                                                      '${controller.pendingJobDetails.date.toString()} | ${converter24To12(controller.pendingJobDetails.time.toString())}',
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
                                                Image.asset(
                                                  '${baseImagePath}phone.png',
                                                  height: Utils.height! / 22,
                                                  width: Utils.width! / 22,
                                                ),
                                                SizedBox(
                                                  width: Utils.width! / 30,
                                                ),
                                                CustomText(
                                                  text: controller
                                                      .pendingJobDetails
                                                      .customer
                                                      .contactNumber
                                                      .toString(),
                                                  maxLines: 1,
                                                  textOverflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: Utils.height! / 100,
                                            ),
                                            GestureDetector(
                                              child: Row(
                                                crossAxisAlignment: controller
                                                            .pendingJobDetails
                                                            .customer
                                                            .location
                                                            .toString()
                                                            .length <
                                                        30
                                                    ? CrossAxisAlignment.center
                                                    : CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    '${baseImagePath}sent.png',
                                                    height: Utils.height! / 22,
                                                    width: Utils.width! / 22,
                                                  ),
                                                  SizedBox(
                                                    width: Utils.width! / 30,
                                                  ),
                                                  Expanded(
                                                    child: CustomText(
                                                      text: controller
                                                          .pendingJobDetails
                                                          .customer
                                                          .location
                                                          .toString(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                launchURL(Uri.parse(
                                                    'https://www.google.com/maps/search/?api=1&query=${controller.pendingJobDetails.jobLat.toString()},${controller.pendingJobDetails.jobLng.toString()}'));
                                              },
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
                                            ListView.separated(
                                                itemCount: controller
                                                    .pendingJobDetails
                                                    .employees
                                                    .length,
                                                separatorBuilder:
                                                    (context, index) {
                                                  return SizedBox(
                                                    height: 10,
                                                  );
                                                },
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Row(
                                                    children: [
                                                      Image.asset(
                                                        '${baseImagePath}addProfile.png',
                                                        height:
                                                            Utils.height! / 27,
                                                        width:
                                                            Utils.width! / 18,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            Utils.width! / 30,
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            CustomText(
                                                              text: controller
                                                                  .pendingJobDetails
                                                                  .employees[
                                                                      index]
                                                                  .jobuser
                                                                  .name
                                                                  .toString(),
                                                              maxLines: 2,
                                                              textOverflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            controller
                                                                        .pendingJobDetails
                                                                        .employees[
                                                                            index]
                                                                        .crewLead ==
                                                                    1
                                                                ? Flexible(
                                                                    child:
                                                                        CustomText(
                                                                      text:
                                                                          ' (Team Lead)',
                                                                      maxLines:
                                                                          1,
                                                                      textColor:
                                                                          purpleColor,
                                                                      textOverflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  )
                                                                : SizedBox(),
                                                            SizedBox(
                                                              width:
                                                                  Utils.width! /
                                                                      90,
                                                            ),
                                                            controller
                                                                        .pendingJobDetails
                                                                        .employees[
                                                                            index]
                                                                        .request_status ==
                                                                    1
                                                                ? Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            2.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .check,
                                                                      color:
                                                                          greenColor,
                                                                    ),
                                                                  )
                                                                : controller
                                                                            .pendingJobDetails
                                                                            .employees[index]
                                                                            .request_status ==
                                                                        2
                                                                    ? Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            top:
                                                                                2.0),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              redColor,
                                                                        ),
                                                                      )
                                                                    : SizedBox(),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }),

                                            // SizedBox(
                                            //   height: Utils.height! / 100,
                                            // ),
                                            // Row(
                                            //   children: [
                                            //     Transform.scale(
                                            //       scale: 0.6,
                                            //       child: Image.asset(
                                            //         '${baseImagePath}addProfile.png',
                                            //       ),
                                            //     ),
                                            //     SizedBox(
                                            //       width: Utils.width! / 30,
                                            //     ),
                                            //     CustomText(
                                            //       text: 'Jerry',
                                            //       maxLines: 1,
                                            //       textOverflow:
                                            //           TextOverflow.ellipsis,
                                            //     ),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Utils.height! / 60,
                                    ),
                                    controller.pendingJobDetails.tasks.isEmpty
                                        ? SizedBox()
                                        : Card(
                                            elevation: 0,
                                            color: whiteColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
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
                                                    itemCount: controller
                                                        .pendingJobDetails
                                                        .tasks
                                                        .length,
                                                    separatorBuilder:
                                                        (context, index) {
                                                      return SizedBox(
                                                        height: 10,
                                                      );
                                                    },
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return CustomText(
                                                        text: controller
                                                            .pendingJobDetails
                                                            .tasks[index]
                                                            .taskName
                                                            .toString(),
                                                        textColor: grayColor,
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
                            bottom: -60,
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
                                    top: BorderSide(
                                        color: appThemeColor, width: 7)),
                                boxShadow: [
                                  BoxShadow(
                                      color: innerShadowColor.withOpacity(0.9),
                                      offset: Offset(-1, -2)),
                                  BoxShadow(
                                      color: innerShadowColor.withOpacity(0.9),
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
                      )
                    ],
                  ),
                  !controller.isAcceptDone.value &&
                          controller.pendingJobDetails.employees.any(
                              (employee) =>
                                  employee.employeeId ==
                                      GetStorage().read('user_id') &&
                                  (employee.request_status == 0 ||
                                      employee.request_status == 2))
                      ? Positioned(
                          bottom: 35,
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: redColor2),
                                child: CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: controller.isDeclineTap.value
                                      ? null
                                      : () async {
                                          controller.acceptJob(forReject: true);
                                        },
                                  child: Center(
                                    child: controller.isDeclineTap.value
                                        ? Loader()
                                        : Text(
                                            "Decline",
                                            style: GoogleFonts.amaranth(
                                              color: appThemeColor,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 100,
                                height: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: greenColor),
                                child: CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: controller.isAcceptTap.value
                                      ? null
                                      : () async {
                                          await GetStorage()
                                              .remove('finishJob');
                                          controller.acceptJob();
                                        },
                                  child: Center(
                                    child: controller.isAcceptTap.value
                                        ? Loader()
                                        : Text(
                                            'Accept',
                                            style: GoogleFonts.amaranth(
                                              color: appThemeColor,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Positioned(
                          bottom: 35,
                          child: Container(
                            width: 210,
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: GetStorage().read('user_id') ==
                                        controller.pendingJobDetails.team_lead
                                    //     &&
                                    // checkSameDate(controller.pendingJobDetails.date
                                    //     .toString()
                                    //     .replaceAll('-', ':'))
                                    ? purpleColor
                                    : grayColor),
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed:
                                  // () async {
                                  //   await GetStorage().remove('finishJob');
                                  //   Get.toNamed(RouteConstant.uploadImageScreen);
                                  // },

                                  GetStorage().read('user_id') ==
                                          controller.pendingJobDetails.team_lead
                                      //     &&
                                      // checkSameDate(controller.pendingJobDetails.date
                                      //     .toString()
                                      // .replaceAll('-', ':'))
                                      ? () async {
                                          await GetStorage()
                                              .remove('finishJob');
                                          Get.toNamed(
                                              RouteConstant.uploadImageScreen);
                                        }
                                      : GetStorage().read('user_id') !=
                                              controller
                                                  .pendingJobDetails.team_lead
                                          ? () {
                                              if (!Get.isSnackbarOpen) {
                                                showSnackBar(
                                                    'Only team lead can start the job');
                                              }
                                            }
                                          : null,
                              child: Center(
                                child: Text(
                                  'Start',
                                  style: GoogleFonts.amaranth(
                                    color: appThemeColor,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ));
  }
}
