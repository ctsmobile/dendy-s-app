// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dendy_app/customWidgets/customText.dart';
import 'package:dendy_app/routes.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabBarVieww extends StatelessWidget {
  final bool isCompletedJobs;
  const TabBarVieww({super.key, this.isCompletedJobs = false});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.separated(
              itemCount: 5,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 2,
                );
              },
              padding: EdgeInsets.only(top: 0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Container(
                      width: Utils.width,
                      height: 100,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: appThemeColor,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 2),
                            spreadRadius: 0.0,

                            blurRadius: 3.0,
                            color: innerShadowColor, // darker color
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: innerShadowColor.withOpacity(0.7),
                                    ),
                                    BoxShadow(
                                        color: appThemeColor.withOpacity(0.7),
                                        spreadRadius: -2.0,
                                        blurRadius: 5.0,
                                        offset: Offset(0, 2)),
                                    BoxShadow(
                                        color: appThemeColor.withOpacity(0.7),
                                        spreadRadius: -2.0,
                                        blurRadius: 5.0,
                                        offset: Offset(0, 2)),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image.asset(
                                    '${baseImagePath}a.png',
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Utils.width! / 60,
                              ),
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: 'Exhaust Hood System Cleaning',
                                    maxLines: 1,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: Utils.height! / 200,
                                  ),
                                  CustomText(
                                    text: '04-09-2024',
                                    maxLines: 1,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: Utils.height! / 200,
                                  ),
                                  CustomText(
                                    text: '10:00 - 13:20',
                                    maxLines: 1,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )),
                            ],
                          ),
                          isCompletedJobs
                              ? SizedBox()
                              : Image.asset(
                                  '${baseImagePath}Rectangle2.png',
                                  height: 25,
                                  width: 25,
                                ),
                        ],
                      )),
                  onTap: () {
                    if (isCompletedJobs) {
                      Get.toNamed(RouteConstant.completeJobDetailsScreen);
                    } else {
                      Get.toNamed(RouteConstant.pendingDetailsScreen);
                    }
                  },
                );
              }),
        ],
      ),
    );
  }
}
