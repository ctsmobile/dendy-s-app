// ignore_for_file: use_key_in_widget_constructors

import 'package:dendy_app/controllers/uploadImagesController.dart';
import 'package:dendy_app/customWidgets/customAppBar.dart';
import 'package:dendy_app/customWidgets/customText.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UploadImageController controller = Get.put(UploadImageController());

    return Scaffold(
      backgroundColor: appThemeColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: MyAppBar(
            title: 'Upload Images',
            isLeading: false,
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              '${baseImagePath}upload.png',
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: Utils.height! / 50,
            ),
            Container(
              width: 240,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: purpleColor),
              child: CupertinoButton(
                onPressed: () {
                  controller.onImageButtonPressed(
                    ImageSource.camera,
                  );
                },
                child:
                    // controller.isLoginTap.value
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
          ],
        ),
      ),
    );
  }
}
