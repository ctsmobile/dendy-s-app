// ignore_for_file: prefer_const_constructors

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dendy_app/controllers/uploadImagesController.dart';
import 'package:dendy_app/customWidgets/customAppBar.dart';
import 'package:dendy_app/customWidgets/customLoader.dart';
import 'package:dendy_app/customWidgets/customText.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../routes.dart';

class UploadeImagesViewScreen extends StatelessWidget {
  const UploadeImagesViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UploadImageController controller = Get.put(UploadImageController());

    return Obx(() => GestureDetector(
          onTap: () {
            controller.focusNodes1.unfocus();
          },
          child: Scaffold(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.builder(
                        shrinkWrap: true,
                        itemCount: controller.filePaths.length + 1,
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
                        itemBuilder: (BuildContext context2, int index) {
                          return GestureDetector(
                            child: index == 0
                                ? Container(
                                    width: Utils.width! / 3.2,
                                    height: Utils.height! / 5.95,
                                    decoration: BoxDecoration(
                                      color: purpleColor,
                                      // border: Border.all(
                                      //   color: grayColor,
                                      // ),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          child: Image.memory(
                                            controller.xFiles[index - 1],
                                            fit: BoxFit.cover,
                                            width: Utils.width! / 4,
                                            height: Utils.height! / 7.3,

                                            // Utils.height! / 3,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        child: Transform.scale(
                                            scale: 0.5,
                                            child: Image.asset(
                                                '${baseImagePath}delete.png')),
                                        onTap: () {
                                          controller.filePaths
                                              .removeAt(index - 1);
                                          controller.fileNames
                                              .removeAt(index - 1);
                                          controller.xFiles.removeAt(index - 1);
                                        },
                                      ),
                                    ],
                                  ),
                            onTap: () {
                              if (index == 0) {
                                controller.onImageButtonPressed(
                                  ImageSource.camera,
                                );
                              } else {
                                showGeneralDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  barrierLabel: 'Dismiss',
                                  pageBuilder: (_, __, ___) {
                                    return Center(
                                      child: SizedBox(
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
                                                child: Image.memory(
                                                  controller.xFiles[index - 1],
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
                                    );
                                  },
                                );
                              }
                            },
                          );
                        }),
                    GetStorage().read('finishJob') == true
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Utils.height! / 30,
                              ),
                              CustomText(
                                text: 'Add a comment',
                                textColor: purpleColor,
                              ),
                              SizedBox(
                                height: Utils.height! / 100,
                              ),
                              Container(
                                height: Utils.height! / 9,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: blackColor, width: 1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: TextFormField(
                                  controller: controller.commentController,
                                  focusNode: controller.focusNodes1,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(
                                      10.0,
                                    ),
                                  ),
                                  maxLines: 10,
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                      height: Utils.height! / 30,
                    ),
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
                  onPressed: controller.isUploadImageLoading.value
                      ? null
                      : () async {
                          final connectivityResult =
                              await Connectivity().checkConnectivity();

                          if (connectivityResult
                              .contains(ConnectivityResult.none)) {
                            showSnackBar(
                              'Please check your internet connection!',
                              titleText: 'Network Error',
                            );
                          } else {
                            if (GetStorage().read('finishJob') == true) {
                              if (controller.filePaths.isEmpty) {
                                if (!Get.isSnackbarOpen) {
                                  showSnackBar(
                                      'Please upload atleat one final picture');
                                }
                              } else {
                                controller.finishJobApi();
                              }
                            } else {
                              if (controller.filePaths.isEmpty) {
                                if (!Get.isSnackbarOpen) {
                                  showSnackBar(
                                      'Please upload atleat one initial picture');
                                }
                              } else {
                                controller.startJobApi();
                              }
                            }
                          }
                        },
                  child: controller.isUploadImageLoading.value
                      ? Loader(
                          color: whiteColor,
                        )
                      : CustomText(
                          text: GetStorage().read('finishJob') == true
                              ? 'Finish Job'
                              : 'Start Job',
                          fontSize: 20,
                          textColor: whiteColor,
                        ),
                ),
              ),
            ),
          ),
        ));
  }
}
