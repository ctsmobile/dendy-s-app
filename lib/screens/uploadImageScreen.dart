// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:dendy_app/controllers/uploadImagesController.dart';
import 'package:dendy_app/customWidgets/customAppBar.dart';
import 'package:dendy_app/customWidgets/customLoader.dart';
import 'package:dendy_app/customWidgets/customText.dart';
import 'package:dendy_app/routes.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UploadImageController controller = Get.put(UploadImageController());

    return Obx(() => Scaffold(
          backgroundColor: appThemeColor,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: MyAppBar(
                title: 'Upload Images',
              )),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!controller.showImage.value)
                  Container(
                      height: 200,
                      child: Center(
                          child: Loader(
                        color: purpleColor,
                      ))), // Loader displayed for 2 seconds
                if (controller.showImage.value)
                  Image.asset(
                    '${baseImagePath}upload3.png',
                    fit: BoxFit.cover,
                    height: 200,
                    width: Utils.width,
                  ),
                SizedBox(
                  height: Utils.height! / 20,
                ),
                Center(
                  child: (!controller.showImage.value)
                      ? Container(height: 200, child: Center(child: SizedBox()))
                      : Container(
                          width: 240,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: purpleColor),
                          child: CupertinoButton(
                            onPressed: () {
                              // controller.captureImage();
                              Get.toNamed(RouteConstant.cameraPreviewScreen);
                            },
                            child:
                                // controller.isImageProcessing.value
                                //     ? Loader(
                                //         color: whiteColor,
                                //       )
                                //     :
                                Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Transform.scale(
                                  scale: 0.7,
                                  child: Image.asset(
                                    '${baseImagePath}upload2.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: Utils.width! / 50,
                                ),
                                CustomText(
                                  text: 'Upload Images',
                                  fontSize: 20,
                                  textColor: whiteColor,
                                )
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          // bottomNavigationBar:  Padding(
          //   padding: const EdgeInsets.only(bottom:70.0, left: 60, right: 60),
          //   child: Container(
          //     width: 240,
          //     height: 60,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10.0),
          //         color: purpleColor),
          //     child: CupertinoButton(
          //       onPressed: () {
          //         controller.onImageButtonPressed(
          //           ImageSource.camera,
          //         );
          //       },
          //       child:
          //           // controller.isImageProcessing.value
          //           //     ? Loader(
          //           //         color: whiteColor,
          //           //       )
          //           //     :
          //           Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Transform.scale(
          //             scale: 0.7,
          //             child: Image.asset(
          //               '${baseImagePath}upload2.png',
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //           SizedBox(
          //             width: Utils.width! / 50,
          //           ),
          //           CustomText(
          //             text: 'Upload Images',
          //             fontSize: 20,
          //             textColor: whiteColor,
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ));
  }
}
