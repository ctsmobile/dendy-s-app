// ignore_for_file: body_might_complete_normally_nullable, empty_catches, prefer_interpolation_to_compose_strings, prefer_const_constructors, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dendy_app/main.dart';
import 'package:dendy_app/routes.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_painter_v2/flutter_painter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:ui' as ui;
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';
import 'package:lecle_flutter_absolute_path/lecle_flutter_absolute_path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class UploadImageController extends GetxController {
  var isDataLoading = false.obs;
  var isImageProcessing = false.obs;
  var isUploadImageLoading = false.obs;
  var showImage = false.obs;
  late PainterController imageController;
  final commentController = TextEditingController();
  FocusNode focusNodes1 = FocusNode();
  var file = File("").obs;
  var fileName = "".obs;
  ui.Image? backgroundImage;
  FocusNode textFocusNode = FocusNode();
  // final ImagePicker _picker = ImagePicker();
  late CameraController cameraController;

  late XFile? pickedFile;
  var filePaths = <File>[].obs;
  var xFiles = <Uint8List>[].obs;
  var fileNames = <String>[].obs;
  Paint shapePaint = Paint()
    ..strokeWidth = 5
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;
  var isCameraReady = false.obs;
  var selectedCameraIndex = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 250), () {
      showImage.value = true;
    });

    initializeCamera(selectedCameraIndex.value);
    filePaths.value = [];
    fileNames.value = [];
    xFiles.value = [];
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void dispose() {
    Get.delete<UploadImageController>();
    super.dispose();
  }

  Future<void> initializeCamera(int cameraIndex) async {
    isCameraReady.value = false;
    if (cameras.isEmpty) {
      print("No cameras available");
      return;
    }

    cameraController = CameraController(
      cameras[cameraIndex],
      ResolutionPreset.high,
    );

    await cameraController.initialize();

    isCameraReady.value = true;
  }

  switchCamera() async {
    selectedCameraIndex.value =
        (selectedCameraIndex.value + 1) % cameras.length;

    await initializeCamera(selectedCameraIndex.value);
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
    textFocusNode.addListener(onFocus);
    // Initialize background
    final codec = await ui.instantiateImageCodec(
      await File(pickedFile!.path).readAsBytes(),
    );
    backgroundImage = (await codec.getNextFrame()).image;

    imageController.background = backgroundImage!.backgroundDrawable;
    isDataLoading.value = false;
  }

  void onFocus() {
    update();
  }

  Future<void> captureImage() async {
    if (!cameraController.value.isInitialized) {
      return;
    } else {
      pickedFile = await cameraController.takePicture();
      // print("Captured Image: ${pickedFile!.path}");
      if (pickedFile != null) {
        Get.toNamed(RouteConstant.imageEditorScreen);
      }
    }
    // Navigate or save image as needed
  }

  // Future<void> onImageButtonPressed(
  //   ImageSource source,
  // ) async {
  //   try {
  //     pickedFile = await _picker.pickImage(
  //       source: source,
  //     );
  //     // print("pickedFile${pickedFile!.name}");
  //     // print("pickedFile${pickedFile!.path}");
  //     // print("pickedFile${pickedFile!.mimeType}");
  //     // print("pickedFile${await pickedFile!.length()}");
  //     if (pickedFile != null) {
  //       Get.toNamed(RouteConstant.imageEditorScreen);
  //     }
  //   } catch (e) {}
  // }

  void uploadImage(XFile image, String imageName) {
    isImageProcessing(true);
    uploadImageApi(image, imageName);
  }

  Future uploadImageApi(XFile image, String imageName) async {
    try {
      isUploadImageLoading(true);

      Uint8List uint8list = await image.readAsBytes();
      xFiles.add(uint8list);
      fileName.value = imageName;

      // print('Image name is: ${fileName.value}');

      file.value = File(image.path);

      filePaths.add(file.value);
      fileNames.add(fileName.value);
      isImageProcessing.value = false;
      Get.back();
      Get.toNamed(RouteConstant.uploadImagesViewScreen,
          arguments: {"imagePath": '${file.value}'});
    } catch (e) {
      log('Error while getting data is $e');
    } finally {
      isUploadImageLoading(false);
    }
  }

  Future startJobApi() async {
    try {
      isUploadImageLoading(true);
      // Prepare FormData to hold multiple images
      // print("filePaths.length${xFiles.length}");
      // print("fileNames.length${fileNames}");
      // Iterate through selected images and add them to FormData
      var jobId = GetStorage().read('jobId').toString();
      // var jobId = '39';
      // print("jobId: $jobId");
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              "http://dandyshoodcleaningapp.com/api/job/startjob/$jobId"));
      for (int i = 0; i < xFiles.length; i++) {
        request.files.add(http.MultipartFile.fromBytes(
          'image[]',
          xFiles[i],
          filename: fileNames[i],
          contentType: MediaType('image', 'png'),
        ));
      }
      String jobStartTime = DateFormat('dd-MM-yyyy HH:mm:ss')
          .format(DateTime.now().add(Duration(seconds: 2)));
      // print(jobStartTime);
      request.fields['job_start_time'] = jobStartTime;

      //  params.fields.add(MapEntry('job_start_time', jobStartTime));
      var token = GetStorage().read('access_token');
      // print("token: $token");

      request.headers['Authorization'] = 'Bearer $token';

      var streamResponse = await request.send();
      var response = await http.Response.fromStream(streamResponse);

      // print("response.data: ${response.body}");
      var responseBody = jsonDecode(response.body);

      if (responseBody['status'] == true) {
        log("BODY DATA UPLOAD PHOTO: ${responseBody['message']}");
        showSnackBar(responseBody['message'], backgroundColor: purpleColor);

        Get.offAllNamed(RouteConstant.activeJobListScreen);
        return responseBody;
      } else {
        log("BODYg DATA UPLOAD PHOTO: ${responseBody['message']}");
        showSnackBar(
          responseBody['message'],
        );
        if (responseBody['message'].contains('Unauthenticated')) {
          await GetStorage().erase();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.offAndToNamed(RouteConstant.loginScreen);
          });
        }
      }
    } catch (e) {
      log('Error while getting data: $e');
      showSnackBar(e.toString());
    } finally {
      isUploadImageLoading(false);
    }
  }

  Future finishJobApi() async {
    try {
      isUploadImageLoading(true);
      // Prepare FormData to hold multiple images
      // print("xFiles.length${xFiles.length}");
      // print("fileNames.length${fileNames.length}");
      // Iterate through selected images and add them to FormData
      var jobId = GetStorage().read('jobId');
      // print("jobIdd: $jobId");

      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              "http://dandyshoodcleaningapp.com/api/job/completejob/$jobId"));
      for (int i = 0; i < xFiles.length; i++) {
        request.files.add(http.MultipartFile.fromBytes(
          'image[]', // Replace 'image' with the form field name expected by your API
          xFiles[i],
          filename: fileNames[i],
          contentType: MediaType('image', 'png'),
        ));
        // print(" request.files${request.files}");
      }
      String jobEndTime =
          DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());
      // params.fields.add(MapEntry('job_end_time', jobEndTime));
      request.fields['job_end_time'] = jobEndTime;
      request.fields['comment'] = commentController.text;
      var token = GetStorage().read('access_token');
      // print("token: $token");

      request.headers['Authorization'] = 'Bearer $token';

      var streamResponse = await request.send();
      var response = await http.Response.fromStream(streamResponse);
      // print("response.data: ${response}");

      var responseBody = jsonDecode(response.body);

      if (responseBody['status'] == true) {
        log("BODY DATA UPLOAD PHOTO: ${responseBody['message']}");
        showSnackBar(responseBody['message'], backgroundColor: purpleColor);

        Get.offAllNamed(RouteConstant.dashboardScreen,
            arguments: {"initialIndex": 2});
      } else {
        log("BODY DATA UPLOAD PHOTO: ${responseBody['message']}");
        showSnackBar(
          responseBody['message'],
        );
        if (responseBody['message'].contains('Unauthenticated')) {
          await GetStorage().erase();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.offAndToNamed(RouteConstant.loginScreen);
          });
        }
      }
    } catch (e) {
      log('Error while getting data: $e');
      showSnackBar(
        e.toString(),
      );
    } finally {
      isUploadImageLoading(false);
    }
  }
}
