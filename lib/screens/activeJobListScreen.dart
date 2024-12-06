// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, use_key_in_widget_constructors

import 'package:dendy_app/customWidgets/customAppBar.dart';
import 'package:dendy_app/customWidgets/customBottomBar.dart';
import 'package:dendy_app/customWidgets/customLoader.dart';
import 'package:dendy_app/customWidgets/customText.dart';
import 'package:dendy_app/routes.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/activeJobController.dart';

class ActiveJobListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ActiveJobController controller = Get.put(ActiveJobController());

    return Obx(() => Scaffold(
          backgroundColor: appThemeColor,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: MyAppBar(
                title: 'Active Jobs',
                isLeading: false,
              )),
          body: controller.isDataLoading.value
              ? Center(
                  child: Loader(
                  color: purpleColor,
                ))
              : WillPopScope(
                  onWillPop: () async {
                    Get.offAllNamed(RouteConstant.dashboardScreen);

                    return false;
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          color: purpleColor,
                          onRefresh: () async {
                            await controller.getActiveJobDetails();
                          },
                          child: controller.activeJobModel.value.data.isEmpty
                              ? Center(
                                  child: CustomText(
                                    text: 'No Active job found!',
                                    textColor: purpleColor,
                                  ),
                                )
                              : ListView.separated(
                                  itemCount: controller
                                      .activeJobModel.value.data.length,
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 2,
                                    );
                                  },
                                  physics: AlwaysScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(top: 0),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      child: Container(
                                          width: Utils.width,
                                          height: 100,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            color: appThemeColor,
                                            boxShadow: [
                                              BoxShadow(
                                                offset: Offset(0, 2),
                                                spreadRadius: 0.0,

                                                blurRadius: 3.0,
                                                color:
                                                    innerShadowColor, // darker color
                                              ),
                                            ],
                                          ),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional.centerEnd,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: Utils.width! / 60,
                                                  ),
                                                  Expanded(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                        text: controller
                                                            .activeJobModel
                                                            .value
                                                            .data[index]
                                                            .name
                                                            .toString(),
                                                        maxLines: 1,
                                                        textOverflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Utils.height! / 200,
                                                      ),
                                                      CustomText(
                                                        text: controller
                                                            .activeJobModel
                                                            .value
                                                            .data[index]
                                                            .date
                                                            .toString(),
                                                        maxLines: 1,
                                                        textOverflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Utils.height! / 200,
                                                      ),
                                                      CustomText(
                                                        text: converter24To12(
                                                          controller
                                                              .activeJobModel
                                                              .value
                                                              .data[index]
                                                              .time
                                                              .toString(),
                                                        ),
                                                        maxLines: 1,
                                                        textOverflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                      ),
                                                    ],
                                                  )),
                                                ],
                                              ),
                                              Image.asset(
                                                '${baseImagePath}Rectangle2.png',
                                                height: 25,
                                                width: 25,
                                              ),
                                            ],
                                          )),
                                      onTap: () {
                                        GetStorage().write(
                                            'jobId',
                                            controller.activeJobModel.value
                                                .data[index].id
                                                .toString());
                                        controller.iindex.value = index;
                                        controller.onlyOne.value = false;
                                        Get.toNamed(
                                          RouteConstant.activeJobDetailsScreen,
                                        );
                                      },
                                    );
                                  }),
                        ),
                      )
                    ],
                  ),
                ),
          bottomNavigationBar: CommonBottomBar(
            index: 1,
          ),
        ));
  }
}
