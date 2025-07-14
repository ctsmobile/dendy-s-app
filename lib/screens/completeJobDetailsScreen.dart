// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dendy_app/controllers/jobDetailsController.dart';
import 'package:dendy_app/customWidgets/customAppBar.dart';
import 'package:dendy_app/customWidgets/customLoader.dart';
import 'package:dendy_app/customWidgets/customText.dart';
import 'package:dendy_app/routes.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

class CompleteJobDetailsScreen extends StatelessWidget {
  const CompleteJobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    JobDetailsController controller = Get.put(JobDetailsController());
    return Obx(
      () => Scaffold(
          backgroundColor: appThemeColor,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: MyAppBar(
                title: 'Details',
                isLeading: Navigator.canPop(context) ? true : false,
              )),
          body: controller.isDataLoading.value
              ? Center(
                  child: Loader(
                    color: purpleColor,
                  ),
                )
              : controller.jobDetailsModel.data == null
                  ? Center(
                      child: CustomText(
                      text: 'No data Available',
                      textColor: purpleColor,
                    ))
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.topCenter,
                              children: [
                                Card(
                                    elevation: 7,
                                    color: appThemeColor,
                                    shadowColor: innerShadowColor,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 130.0, left: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                                          Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              CustomText(
                                                                                                                                                      text:
                                                                                'Job Start Time',
                                                                                                                                                      textColor:
                                                                                purpleColor,
                                                                                                                                                      maxLines:
                                                                                1,
                                                                                                                                                      textOverflow:
                                                                                TextOverflow.ellipsis,
                                                                                                                                                    ),

                                                                                                                                                      CustomText(
                                                                        text:
                                                                         '${DateFormat('MM/dd/yyyy').format(controller
                                                                              .jobDetailsModel
                                                                              .data!
                                                                              .jobStartTime!)}, ${converter24To12(DateFormat('HH:mm:ss').format(controller
                                                                                  .jobDetailsModel
                                                                                  .data!
                                                                                  .jobStartTime!))}',
                                                                         
                                                                        textColor:
                                                                            grayColor,
                                                                            fontSize: 14,
                                                                        maxLines:
                                                                            1,
                                                                        textOverflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                            ],
                                                                          ),


                                                                          
                                                                    ),
                                                                    
                                                                       Expanded(
                                                                      child:
                                                                          Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                                            children: [

                                                                               CustomText(
                                                                                                                                                      text:
                                                                                'Job End Time',
                                                                                                                                                      textColor:
                                                                                purpleColor,
                                                                                                                                                      maxLines:
                                                                                1,
                                                                                                                                                      textOverflow:
                                                                                TextOverflow.ellipsis,
                                                                                                                                                    ),
                                                                              CustomText(
                                                                                                                                                      text:
                                                                          '${DateFormat('MM/dd/yyyy').format(controller
                                                                              .jobDetailsModel
                                                                              .data!
                                                                              .jobEndTime)}, ${converter24To12(DateFormat('HH:mm:ss').format(controller
                                                                                  .jobDetailsModel
                                                                                  .data!
                                                                                  .jobEndTime))}',
                                                                                                                                                      textColor:
                                                                                grayColor,
                                                                                                                                                      maxLines:
                                                                                1,fontSize: 14,
                                                                                                                                                      textOverflow:
                                                                                TextOverflow.ellipsis,
                                                                                                                                                    ),
                                                                            ],
                                                                          ),
                                                                    ),
                                                                    SizedBox(width: 15,)]),

                                                                    SizedBox(height: 20,),



                                                           GetStorage().read('user_id') ==
                                          controller.jobDetailsModel.data!.teamLead ||    controller
                                                                              .jobDetailsModel
                                                                              .data!
                                                                              .employees.firstWhere((employee) => 
                                                                                  employee.employeeId ==
                                                                                  GetStorage().read('user_id')as int).clock_in==null||controller
                                                                              .jobDetailsModel
                                                                              .data!
                                                                              .employees.firstWhere((employee) => 
                                                                                  employee.employeeId ==
                                                                                  GetStorage().read('user_id')as int).clock_out==null?SizedBox():     Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              CustomText(
                                                                                                                                                      text:
                                                                                'My Clock-In Time',
                                                                                                                                                      textColor:
                                                                                purpleColor,
                                                                                                                                                      maxLines:
                                                                                1,
                                                                                                                                                      textOverflow:
                                                                                TextOverflow.ellipsis,
                                                                                                                                                    ),

                                                                                                                                                      CustomText(
                                                                        text:
                                                                         '${DateFormat('MM/dd/yyyy').format(DateTime.parse(controller
                                                                              .jobDetailsModel
                                                                              .data!
                                                                              .employees.firstWhere((employee) => 
                                                                                  employee.employeeId ==
                                                                                  GetStorage().read('user_id')as int).clock_in))}, ${converter24To12(DateFormat('HH:mm:ss').format(DateTime.parse(controller
                                                                                  .jobDetailsModel
                                                                                  .data!
                                                                                  .employees.firstWhere((employee) => 
                                                                                  employee.employeeId ==
                                                                                  GetStorage().read('user_id')as int).clock_in)))}',
                                                                         
                                                                        textColor:
                                                                            grayColor,
                                                                            fontSize: 14,
                                                                        maxLines:
                                                                            1,
                                                                        textOverflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                            ],
                                                                          ),


                                                                          
                                                                    ),
                                                                    
                                                                       Expanded(
                                                                      child:
                                                                          Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                                            children: [

                                                                               CustomText(
                                                                                                                                                      text:
                                                                                'My Clock-Out Time',
                                                                                                                                                      textColor:
                                                                                purpleColor,
                                                                                                                                                      maxLines:
                                                                                1,
                                                                                                                                                      textOverflow:
                                                                                TextOverflow.ellipsis,
                                                                                                                                                    ),
                                                                              CustomText(
                                                                                                                                                      text:
                                                                          '${DateFormat('MM/dd/yyyy').format(DateTime.parse(controller
                                                                              .jobDetailsModel
                                                                              .data!
                                                                              .employees.firstWhere((employee) => 
                                                                                  employee.employeeId ==
                                                                                  GetStorage().read('user_id')as int).clock_out))}, ${converter24To12(DateFormat('HH:mm:ss').format(DateTime.parse(controller
                                                                                  .jobDetailsModel
                                                                                  .data!
                                                                                  .employees.firstWhere((employee) => 
                                                                                  employee.employeeId ==
                                                                                  GetStorage().read('user_id')as int).clock_out)))}',
                                                                                                                                                      textColor:
                                                                                grayColor,
                                                                                                                                                      maxLines:
                                                                                1,fontSize: 14,
                                                                                                                                                      textOverflow:
                                                                                TextOverflow.ellipsis,
                                                                                                                                                    ),
                                                                            ],
                                                                          ),
                                                                    ),
                                                                    SizedBox(width: 15,)]),

                                                                    SizedBox(height:GetStorage().read('user_id') ==
                                          controller.jobDetailsModel.data!.teamLead ?0: 20,),
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
                                                      isScrollControlled: true,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15.0),
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
                                                                        child: Image
                                                                            .asset(
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
                                                                  height: Utils
                                                                          .height! /
                                                                      70,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Image.asset(
                                                                      '${baseImagePath}profilee.png',
                                                                      height:
                                                                          Utils.height! /
                                                                              20,
                                                                      width:
                                                                          Utils.width! /
                                                                              20,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          Utils.width! /
                                                                              30,
                                                                    ),
                                                                    CustomText(
                                                                      text: controller
                                                                          .jobDetailsModel
                                                                          .data!
                                                                          .customer
                                                                          .name
                                                                          .toString(),
                                                                      maxLines:
                                                                          1,
                                                                      textOverflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: Utils
                                                                          .height! /
                                                                      100,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Image.asset(
                                                                      '${baseImagePath}calender.png',
                                                                      height:
                                                                          Utils.height! /
                                                                              20,
                                                                      width:
                                                                          Utils.width! /
                                                                              20,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          Utils.width! /
                                                                              30,
                                                                    ),
                                                                    CustomText(
                                                                      text: controller
                                                                          .jobDetailsModel
                                                                          .data!
                                                                          .date
                                                                          .toString(),
                                                                      maxLines:
                                                                          1,
                                                                      textOverflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: Utils
                                                                          .height! /
                                                                      100,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Image.asset(
                                                                      '${baseImagePath}watch.png',
                                                                      height:
                                                                          Utils.height! /
                                                                              20,
                                                                      width:
                                                                          Utils.width! /
                                                                              20,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          Utils.width! /
                                                                              30,
                                                                    ),
                                                                    CustomText(
                                                                      text: controller.jobDetailsModel.data!.time ==
                                                                              'null'
                                                                          ? ''
                                                                          : converter24To12(controller
                                                                              .jobDetailsModel
                                                                              .data!
                                                                              .time),
                                                                      maxLines:
                                                                          1,
                                                                      textOverflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: Utils
                                                                          .height! /
                                                                      100,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Image.asset(
                                                                      '${baseImagePath}phone.png',
                                                                      height:
                                                                          Utils.height! /
                                                                              20,
                                                                      width:
                                                                          Utils.width! /
                                                                              20,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          Utils.width! /
                                                                              30,
                                                                    ),
                                                                    CustomText(
                                                                      text: controller
                                                                          .jobDetailsModel
                                                                          .data!
                                                                          .customer
                                                                          .contactNumber
                                                                          .toString(),
                                                                      maxLines:
                                                                          1,
                                                                      textOverflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: Utils
                                                                          .height! /
                                                                      100,
                                                                ),
                                                                GestureDetector(
                                                                  child: Row(
                                                                    crossAxisAlignment: controller.jobDetailsModel.data!.jobLocation.toString().length <
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
                                                                            Utils.height! /
                                                                                20,
                                                                        width: Utils.width! /
                                                                            20,
                                                                      ),
                                                                      SizedBox(
                                                                        width: Utils.width! /
                                                                            30,
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            CustomText(
                                                                          text: controller
                                                                              .jobDetailsModel
                                                                              .data!
                                                                              .jobLocation
                                                                              
                                                                              .toString(),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  onTap: () {
                                                                    launchURL(Uri
                                                                        .parse(
                                                                            'https://www.google.com/maps/search/?api=1&query=${controller.jobDetailsModel.data!.jobLat.toString()},${controller.jobDetailsModel.data!.jobLng.toString()}'));
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
                                                      isScrollControlled: true,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15.0),
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
                                                                        child: Image
                                                                            .asset(
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
                                                                  height: Utils
                                                                          .height! /
                                                                      70,
                                                                ),
                                                                ListView
                                                                    .separated(
                                                                        itemCount: controller
                                                                            .jobDetailsModel
                                                                            .data!
                                                                            .employees
                                                                            .where((employee) =>
                                                                                employee.jobuser !=
                                                                                null)
                                                                            .length,
                                                                        separatorBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return SizedBox(
                                                                            height:
                                                                                10,
                                                                          );
                                                                        },
                                                                        shrinkWrap:
                                                                            true,
                                                                        physics:
                                                                            NeverScrollableScrollPhysics(),
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int index) {
                                                                          final filteredEmployees = controller
                                                                              .jobDetailsModel
                                                                              .data!
                                                                              .employees
                                                                              .where((employee) => employee.jobuser != null)
                                                                              .toList();

                                                                          final employee =
                                                                              filteredEmployees[index];
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
                                                                  height: Utils
                                                                          .height! /
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                  text: 'Initial Images',
                                                  textColor: purpleColor,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: GestureDetector(
                                                    child: Row(
                                                      children: [
                                                        CustomText(
                                                          text: 'View All',
                                                          textColor: grayColor,
                                                          textUnderLined: true,
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: grayColor,
                                                          size: 22,
                                                        )
                                                      ],
                                                    ),
                                                    onTap: () {
                                                      controller
                                                          .forInitialImages
                                                          .value = true;
                                                      Get.toNamed(RouteConstant
                                                          .viewAllImagesScreen);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: Utils.height! / 60,
                                          ),
                                          SizedBox(
                                            height: Utils.height! / 7.3,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20.0),
                                              child: ListView.separated(
                                                itemCount: controller
                                                    .jobDetailsModel
                                                    .data!
                                                    .startimage
                                                    .length,
                                                separatorBuilder:
                                                    (context, index) {
                                                  return SizedBox(
                                                    width: 20,
                                                  );
                                                },
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Container(
                                                    width: 90,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: grayColor,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              'http://dandyshoodcleaningapp.com/public/${controller.jobDetailsModel.data!.startimage[index].imageUrl}',
                                                          fit: BoxFit.cover,
                                                          width:
                                                              Utils.width! / 4,
                                                          height:
                                                              Utils.height! /
                                                                  7.3,
                                                          placeholder:
                                                              (context, url) =>
                                                                  Center(
                                                            child: CircularProgressIndicator(
                                                                color:
                                                                    purpleColor),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        )
                                                        //  Image.network(
                                                        //   'https://dendyapp.chawtechsolutions.ch/public/${controller.jobDetailsModel.data.startimage[index].imageUrl}',
                                                        //   fit: BoxFit.cover,
                                                        //   width: Utils.width! / 4,
                                                        //   height: Utils.height! / 7.3,
                                                        //   loadingBuilder: (BuildContext
                                                        //           context,
                                                        //       Widget child,
                                                        //       ImageChunkEvent?
                                                        //           loadingProgress) {
                                                        //     if (loadingProgress ==
                                                        //         null) {
                                                        //       return child;
                                                        //     }
                                                        //     return Center(
                                                        //       child:
                                                        //           CircularProgressIndicator(
                                                        //         value: loadingProgress
                                                        //                     .expectedTotalBytes !=
                                                        //                 null
                                                        //             ? loadingProgress
                                                        //                     .cumulativeBytesLoaded /
                                                        //                 (loadingProgress
                                                        //                         .expectedTotalBytes ??
                                                        //                     1)
                                                        //             : null,
                                                        //         color: purpleColor,
                                                        //       ),
                                                        //     );
                                                        //   },
                                                        //   errorBuilder: (context,
                                                        //           error,
                                                        //           stackTrace) =>
                                                        //       Icon(Icons
                                                        //           .error), // Show an error icon if the image fails to load
                                                        // ),
                                                        ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: controller.jobDetailsModel
                                                    .data!.tasks.isEmpty
                                                ? 0
                                                : Utils.height! / 25,
                                          ),
                                          CustomText(
                                            text: controller.jobDetailsModel
                                                    .data!.tasks.isEmpty
                                                ? ''
                                                : 'Task List',
                                            textColor: purpleColor,
                                          ),
                                          SizedBox(
                                            height: controller.jobDetailsModel
                                                    .data!.tasks.isEmpty
                                                ? 0
                                                : Utils.height! / 60,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20.0),
                                            child: ListView.separated(
                                              itemCount: controller
                                                  .jobDetailsModel
                                                  .data!
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
                                                    CustomText(
                                                      text: controller
                                                          .jobDetailsModel
                                                          .data!
                                                          .tasks[index]
                                                          .taskName,
                                                      textColor: grayColor,
                                                    ),
                                                    Container(
                                                        height: 35,
                                                        width: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: whiteColor,
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
                                                                blurRadius: 5.0,
                                                                offset: Offset(
                                                                    0, 2)),
                                                            BoxShadow(
                                                                color: appThemeColor
                                                                    .withOpacity(
                                                                        0.7),
                                                                spreadRadius:
                                                                    -2.0,
                                                                blurRadius: 5.0,
                                                                offset: Offset(
                                                                    0, 2)),
                                                          ],
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Image.asset(
                                                              '${baseImagePath}check.png'),
                                                        ))
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: Utils.height! / 40,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                  text: 'Completion Images',
                                                  textColor: purpleColor,
                                                  maxLines: 1,
                                                ),
                                                Spacer(),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: GestureDetector(
                                                      child: Row(
                                                        children: [
                                                          CustomText(
                                                            text: 'View All',
                                                            textColor:
                                                                grayColor,
                                                            textUnderLined:
                                                                true,
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            color: grayColor,
                                                            size: 22,
                                                          )
                                                        ],
                                                      ),
                                                      onTap: () {
                                                        controller
                                                            .forInitialImages
                                                            .value = false;
                                                        Get.toNamed(RouteConstant
                                                            .viewAllImagesScreen);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: Utils.height! / 60,
                                          ),
                                          SizedBox(
                                            height: Utils.height! / 7.3,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20.0),
                                              child: ListView.separated(
                                                itemCount: controller
                                                    .jobDetailsModel
                                                    .data!
                                                    .endimage
                                                    .length,
                                                separatorBuilder:
                                                    (context, index) {
                                                  return SizedBox(
                                                    width: 20,
                                                  );
                                                },
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Container(
                                                    width: 90,
                                                    // margin: EdgeInsets.only(right: 4),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: grayColor,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              'http://dandyshoodcleaningapp.com/public/${controller.jobDetailsModel.data!.endimage[index].imageUrl}',
                                                          fit: BoxFit.cover,
                                                          width:
                                                              Utils.width! / 4,
                                                          height:
                                                              Utils.height! /
                                                                  7.3,
                                                          placeholder:
                                                              (context, url) =>
                                                                  Center(
                                                            child: CircularProgressIndicator(
                                                                color:
                                                                    purpleColor),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        )),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Utils.height! / 25,
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
                                      child: Builder(builder: (context) {
                                      String time = controller.jobDetailsModel.data!.spentTime.toString();

// Updated regex to match optional days, hours, and minutes
final regex = RegExp(
  r'(?:(\d+)\s*days?)?\s*(?:(\d+)\s*hours?)?\s*(?:(\d+)\s*min)?',
  caseSensitive: false,
);

final match = regex.firstMatch(time);

String days = '00';
String hours = '00';
String minutes = '00';

if (match != null) {
  if (match.group(1) != null) {
    days = match.group(1)!.padLeft(2, '0');
  }
  if (match.group(2) != null) {
    hours = match.group(2)!.padLeft(2, '0');
  }
  if (match.group(3) != null) {
    minutes = match.group(3)!.padLeft(2, '0');
  }

  print("Days: $days, Hours: $hours, Minutes: $minutes");
} else {
  print("Invalid format");
}

                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Access each part individually

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      days == '00'
                                                          ? '$hours :'
                                                          : '$days :',
                                                      style: TextStyle(
                                                          color: blackColor,
                                                          fontSize: 26,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      days == '00'
                                                          ? '$minutes :'
                                                          : '$hours :',
                                                      style: TextStyle(
                                                          color: blackColor,
                                                          fontSize: 26,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      days == '00'
                                                          ? '00'
                                                          : minutes,
                                                      style: TextStyle(
                                                          color: blackColor,
                                                          fontSize: 26,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                            )

                                            // Row(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment.spaceBetween,
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
                                            //       padding: const EdgeInsets.only(
                                            //           left: 5.0),
                                            //       child: CustomText(
                                            //         text: 'MINUTE',
                                            //         fontSize: 12,
                                            //       ),
                                            //     ),
                                            //     Padding(
                                            //       padding: const EdgeInsets.only(
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
                                        );
                                      }),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    )),
    );
  }
}
