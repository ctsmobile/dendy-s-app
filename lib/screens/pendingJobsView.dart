// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dendy_app/Model/pendingJobListModel.dart';
import 'package:dendy_app/customWidgets/customText.dart';
import 'package:dendy_app/routes.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PendingJobsView extends StatelessWidget {
  final bool isCompletedJobs;
  final PendingJobListModel? pendingJobListModel;
  const PendingJobsView(
      {super.key, this.pendingJobListModel, this.isCompletedJobs = false});

  @override
  Widget build(BuildContext context) {
    return pendingJobListModel!.pendingJob.isEmpty
        ? SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height - 230,
              child: Center(
                child: CustomText(
                  text: isCompletedJobs
                      ? 'No completed job found!'
                      : 'No pending job found!',
                  textColor: purpleColor,
                ),
              ),
            ),
          )
        : ListView.separated(
            itemCount: pendingJobListModel!.pendingJob.length,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 2,
              );
            },
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 0),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Container(
                    width: Utils.width,
                    height: 100,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                            // Container(
                            //   width: 80,
                            //   height: 80,
                            //   margin: const EdgeInsets.symmetric(
                            //       vertical: 10),
                            //   decoration: BoxDecoration(
                            //     borderRadius: const BorderRadius.all(
                            //         Radius.circular(10)),
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: innerShadowColor
                            //             .withOpacity(0.7),
                            //       ),
                            //       BoxShadow(
                            //           color: appThemeColor
                            //               .withOpacity(0.7),
                            //           spreadRadius: -2.0,
                            //           blurRadius: 5.0,
                            //           offset: Offset(0, 2)),
                            //       BoxShadow(
                            //           color: appThemeColor
                            //               .withOpacity(0.7),
                            //           spreadRadius: -2.0,
                            //           blurRadius: 5.0,
                            //           offset: Offset(0, 2)),
                            //     ],
                            //   ),
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(15.0),
                            //     child: Image.asset(
                            //       '${baseImagePath}a.png',
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              width: Utils.width! / 60,
                            ),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: pendingJobListModel!
                                      .pendingJob[index].name
                                      .toString(),
                                  maxLines: 1,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: Utils.height! / 200,
                                ),
                                // !isCompletedJobs
                                //     ? CustomText(
                                //         text: pendingJobListModel!
                                //             .pendingJob[index].date
                                //             .toString(),
                                //         maxLines: 1,
                                //         textOverflow: TextOverflow.ellipsis,
                                //       )
                                //     :
                                CustomText(
                                  text: pendingJobListModel!
                                      .pendingJob[index].date
                                      .toString(),
                                  maxLines: 1,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: Utils.height! / 200,
                                ),
                                CustomText(
                                  text: converter24To12(pendingJobListModel!
                                      .pendingJob[index].time
                                      .toString()),
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
                onTap: () async {
                  print(
                      "pendingJobListModel!.pendingJob[index].id.toString()${pendingJobListModel!.pendingJob[index].id.toString()}");
                  GetStorage().write('jobId',
                      pendingJobListModel!.pendingJob[index].id.toString());
                  if (isCompletedJobs) {
                    final connectivityResult =
                        await Connectivity().checkConnectivity();

                    if (connectivityResult.contains(ConnectivityResult.none)) {
                      showSnackBar(
                        'Please check your internet connection!',
                        titleText: 'Network Error',
                      );
                    } else {
                      Get.toNamed(RouteConstant.completeJobDetailsScreen);
                    }
                  } else {
                    Get.toNamed(RouteConstant.pendingDetailsScreen, arguments: {
                      "pendingJobDetail": pendingJobListModel!.pendingJob[index]
                    });
                  }
                },
              );
            });
  }
}
