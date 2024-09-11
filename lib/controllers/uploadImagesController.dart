// ignore_for_file: body_might_complete_normally_nullable

import 'dart:io';

import 'package:dendy_app/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_painter_v2/flutter_painter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;

class UploadImageController extends GetxController {
  var isDataLoading = false.obs;
  late PainterController imageController;
  ui.Image? backgroundImage;
  FocusNode textFocusNode = FocusNode();
  final ImagePicker _picker = ImagePicker();
  late XFile? pickedFile;
  Paint shapePaint = Paint()
    ..strokeWidth = 5
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;
  @override
  void onInit() {
    super.onInit();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void dispose() {
    Get.delete<UploadImageController>();
    super.dispose();
  }

  paintImage() async {
    isDataLoading.value = true;
    imageController = PainterController(
        settings: PainterSettings(
            text: TextSettings(
              focusNode: textFocusNode,
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                  fontSize: 18),
            ),
            freeStyle: const FreeStyleSettings(
              color: Colors.red,
              strokeWidth: 5,
            ),
            shape: ShapeSettings(
              paint: shapePaint,
            ),
            scale: const ScaleSettings(
              enabled: true,
              minScale: 1,
              maxScale: 5,
            )));
    // Listen to focus events of the text field
    // textFocusNode.addListener(onFocus);
    // Initialize background
    final codec = await ui.instantiateImageCodec(
      await File(pickedFile!.path).readAsBytes(),
    );
    backgroundImage = (await codec.getNextFrame()).image;

    imageController.background = backgroundImage!.backgroundDrawable;
    isDataLoading.value = false;
  }

  Future<void> onImageButtonPressed(
    ImageSource source,
  ) async {
    try {
      pickedFile = await _picker.pickImage(
        source: source,
      );

      Get.toNamed(RouteConstant.imageEditorScreen);
    } catch (e) {}
  }
}
