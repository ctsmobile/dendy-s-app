// ignore_for_file: prefer_const_constructors

import 'package:dendy_app/controllers/uploadImagesViewController.dart';
import 'package:dendy_app/customWidgets/customAppBar.dart';
import 'package:dendy_app/customWidgets/customText.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes.dart';

class UploadeImagesViewScreen extends StatelessWidget {
  const UploadeImagesViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UploadImagesViewController controller =
        Get.put(UploadImagesViewController());

    return Obx(() => Scaffold(
          backgroundColor: appThemeColor,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: MyAppBar(
                title: 'Upload Images',
              )),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  GridView.builder(
                      shrinkWrap: true,
                      itemCount: 6,
                      padding: EdgeInsets.only(
                        top: 0,
                      ),
                      // physics: ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: Utils.height! / 7.3,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20
                          // childAspectRatio: 4 / 4.5,
                          ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: index == 0
                              ? Container(
                                  width: Utils.width! / 3.2,
                                  height: Utils.height! / 5.95,
                                  decoration: BoxDecoration(
                                    color: purpleColor,
                                    border: Border.all(
                                      color: grayColor,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Transform.scale(
                                      scale: 0.5,
                                      child: Image.asset(
                                          '${baseImagePath}addPhoto.png')),
                                )
                              : Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: grayColor,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        child: Image.asset(
                                          '${baseImagePath}image5.png',
                                          fit: BoxFit.cover,
                                          width: Utils.width! / 4,
                                          height: Utils.height! / 7.3,

                                          // Utils.height! / 3,
                                        ),
                                      ),
                                    ),
                                    Transform.scale(
                                        scale: 0.5,
                                        child: Image.asset(
                                            '${baseImagePath}delete.png')),
                                  ],
                                ),
                          onTap: () {
                            if (index == 0) {
                              Get.toNamed(RouteConstant.uploadImageScreen);
                            } else {
                              showGeneralDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierLabel: 'h',
                                pageBuilder: (_, __, ___) {
                                  return Material(
                                    color: Colors.transparent,
                                    child: Center(
                                      child: Container(
                                        // Dialog background
                                        width:
                                            Utils.width! - 50, // Dialog width
                                        height: 400, // Dialog height

                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                child: Image.asset(
                                                  '${baseImagePath}image5.png',
                                                  fit: BoxFit.cover,
                                                  width: Utils.width! -
                                                      50, // Dialog width
                                                  height: 400,

                                                  // Utils.height! / 3,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        );
                      }),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 50.0, left: 40, right: 40),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: purpleColor),
              child: CupertinoButton(
                onPressed: () {
                  if (controller.whichJob.value == 'finishJob') {
                    Get.offAllNamed(RouteConstant.dashboardScreen);
                  } else {
                    Get.offAllNamed(RouteConstant.pendingJobDetailsScreen);
                  }
                },
                child:
                    // controller.isLoginTap.value
                    //     ? Loader(
                    //         color: whiteColor,
                    //       )
                    //     :
                    CustomText(
                  text: controller.whichJob.value == 'finishJob'
                      ? 'Finish Job'
                      : 'Start Job',
                  fontSize: 20,
                  textColor: whiteColor,
                ),
              ),
            ),
          ),
        ));
  }
}
