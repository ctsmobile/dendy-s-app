// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:camera/camera.dart';
import 'package:dendy_app/controllers/uploadImagesController.dart';
import 'package:dendy_app/main.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UploadImageController controller = Get.put(UploadImageController());

    return Obx(() => Scaffold(
          body: Stack(
            children: [
              controller.isCameraReady.value
                  ? Transform.scale(
                      scaleX: controller.selectedCameraIndex.value == 1
                          ? -1
                          : 1, // Flip only for front camera

                      child: CameraPreview(controller.cameraController))
                  : Center(child: SizedBox()),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios_sharp,
                          color: whiteColor,
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: controller.captureImage,
                        child: Icon(
                          Icons.camera,
                          color: whiteColor,
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: controller.switchCamera,
                        child: Icon(
                          Icons.cameraswitch,
                          color: whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
