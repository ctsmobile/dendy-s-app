// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:dendy_app/Model/pendingJobListModel.dart';
import 'package:dendy_app/controllers/dashboardController.dart';
import 'package:dendy_app/customWidgets/customAppBar.dart';
import 'package:dendy_app/customWidgets/customText.dart';
import 'package:dendy_app/routes.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class PendingDetailsScreen extends StatefulWidget {
  const PendingDetailsScreen({super.key});

  @override
  State<PendingDetailsScreen> createState() => _PendingDetailsScreenState();
}

class _PendingDetailsScreenState extends State<PendingDetailsScreen> {
  late PendingJobs pendingJobDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pendingJobDetails = Get.arguments['pendingJobDetail'];

    print("user_id${GetStorage().read('user_id')}");
    print(pendingJobDetails.team_lead.toString());
    print(
        checkSameDate(pendingJobDetails.date.toString().replaceAll('-', ':')));
  }

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
                                                text: pendingJobDetails.name!,
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
                                              text: pendingJobDetails
                                                  .customer.name
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
                                              text:
                                                  '${pendingJobDetails.date.toString()} | ${pendingJobDetails.time.toString().split(':').sublist(0, 2).join(':')}',
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
                                              text: pendingJobDetails
                                                  .customer.contactNumber
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
                                                text: pendingJobDetails
                                                    .customer.location
                                                    .toString(),
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
                                        ListView.separated(
                                            itemCount: pendingJobDetails
                                                .employees.length,
                                            separatorBuilder: (context, index) {
                                              return SizedBox(
                                                height: 10,
                                              );
                                            },
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Row(
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
                                                        text: pendingJobDetails
                                                            .employees[index]
                                                            .jobuser
                                                            .name
                                                            .toString(),
                                                        maxLines: 1,
                                                        textOverflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                      ),
                                                      pendingJobDetails
                                                                  .employees[
                                                                      index]
                                                                  .crewLead ==
                                                              1
                                                          ? CustomText(
                                                              text:
                                                                  ' (Team Lead)',
                                                              maxLines: 1,
                                                              textColor:
                                                                  purpleColor,
                                                              textOverflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            )
                                                          : SizedBox()
                                                    ],
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
                                        //       scale: 0.7,
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
                                          itemCount:
                                              pendingJobDetails.tasks.length,
                                          separatorBuilder: (context, index) {
                                            return SizedBox(
                                              height: 10,
                                            );
                                          },
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return CustomText(
                                              text: pendingJobDetails
                                                  .tasks[index].taskName
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
              Positioned(
                bottom: 30,
                child: Container(
                  width: 210,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: GetStorage().read('user_id') ==
                                  pendingJobDetails.team_lead &&
                              checkSameDate(pendingJobDetails.date
                                  .toString()
                                  .replaceAll('-', ':'))
                          ? purpleColor
                          : grayColor),
                  child: CupertinoButton(
                    onPressed: GetStorage().read('user_id') ==
                                pendingJobDetails.team_lead &&
                            checkSameDate(pendingJobDetails.date
                                .toString()
                                .replaceAll('-', ':'))
                        ? () {
                            Get.toNamed(RouteConstant.uploadImageScreen);
                          }
                        : GetStorage().read('user_id') !=
                                pendingJobDetails.team_lead
                            ? () {
                                Get.snackbar('Sorry!',
                                    'Only team lead can start the job',
                                    backgroundColor: redColor,
                                    colorText: whiteColor);
                              }
                            : null,
                    child: Center(
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
