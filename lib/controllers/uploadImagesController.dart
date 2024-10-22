// ignore_for_file: body_might_complete_normally_nullable, empty_catches, prefer_interpolation_to_compose_strings, prefer_const_constructors, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

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
import 'package:image_picker/image_picker.dart';
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
  late PainterController imageController;

  var file = File("").obs;
  var fileName = "".obs;
  ui.Image? backgroundImage;
  FocusNode textFocusNode = FocusNode();
  final ImagePicker _picker = ImagePicker();
  late XFile? pickedFile;
  var filePaths = <File>[].obs;
  var fileNames = <String>[].obs;
  Paint shapePaint = Paint()
    ..strokeWidth = 5
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;
  @override
  void onInit() {
    super.onInit();

    print("object");
    filePaths.value = [];
    fileNames.value = [];
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

  Future<void> onImageButtonPressed(
    ImageSource source,
  ) async {
    try {
      pickedFile = await _picker.pickImage(
        source: source,
      );

      if (pickedFile != null) {
        Get.toNamed(RouteConstant.imageEditorScreen);
      }
    } catch (e) {}
  }

  void uploadImage(XFile image) {
    isImageProcessing(true);
    uploadImageApi(image).then((auth) {
      if (auth != null) {
        if (auth.data['status'] == true) {
          // Get.back();
          if (!Get.isSnackbarOpen) {
            Get.snackbar('Message', auth.data['message'],
                backgroundColor: Colors.red,
                dismissDirection: DismissDirection.horizontal,
                colorText: whiteColor);
          }
        } else {
          if (!Get.isSnackbarOpen) {
            Get.snackbar('Error', auth.data['message'],
                backgroundColor: Colors.red,
                dismissDirection: DismissDirection.horizontal,
                colorText: whiteColor);
          }
        }
      }
      isImageProcessing(false);
    });
  }

  Future<dio.Response?> uploadImageApi(XFile image) async {
    try {
      isUploadImageLoading(true);
      print("image.path${image.path}");

      fileName.value = image.path.split('/').last;

      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;

      // Create a custom path with the file name
      String customFilePath = '$appDocPath/${fileName.value}';

      // Move the file from the temp location to your custom directory
      File tempFile = File(pickedFile!.path);
      File savedImage = await tempFile.copy(customFilePath);

      print('Image saved to: $customFilePath');

      file.value = savedImage;

      filePaths.add(file.value);
      fileNames.add(fileName.value);
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
      dio.FormData params = dio.FormData();
      print("filePaths.length${filePaths.length}");
      print("fileNames.length${fileNames.length}");
      // Iterate through selected images and add them to FormData
      var jobId = GetStorage().read('jobId').toString();
      print("jobId: $jobId");
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              "https://dendyapp.chawtechsolutions.ch/api/job/startjob/$jobId"));
      for (int i = 0; i < filePaths.length; i++) {
        var filePath = filePaths[i].path;
        if (await File(filePath).exists()) {
          print("filePath$filePath");
          // final tempDir = await getTemporaryDirectory();
          // final filee = await File(filePaths[i].path)
          //     .copy('${tempDir.path}/${fileNames[i]}');
          // final filePathh = filee.path;
          // // String? filePath = await LecleFlutterAbsolutePath.getAbsolutePath(
          // //     uri: filePaths[i].path);

          // print("filePathg$filePathh");
          request.files.add(await http.MultipartFile.fromPath(
              'image[]', // Replace 'image' with the form field name expected by your API
              filePaths[i].path));
        } else {
          log("File not found: $filePath");
        }
      }
      String jobStartTime = DateFormat('dd-MM-yyyy HH:mm:ss')
          .format(DateTime.now().add(Duration(seconds: 2)));
      print(jobStartTime);
      request.fields['job_start_time'] = jobStartTime;

      //  params.fields.add(MapEntry('job_start_time', jobStartTime));
      print("params: $params");
      print("params: ${params.files}");
      // print("params: ${params.fields[0]}");
      var token = GetStorage().read('access_token');
      print("token: $token");

      request.headers['Authorization'] = 'Bearer $token';

      var streamResponse = await request.send();
      var response = await http.Response.fromStream(streamResponse);

      print("response.data: ${response.body}");
      var responseBody = jsonDecode(response.body);

      if (responseBody['status'] == true) {
        log("BODY DATA UPLOAD PHOTO: ${responseBody['message']}");
        Get.snackbar('Success', responseBody['message'],
            backgroundColor: purpleColor,
            dismissDirection: DismissDirection.horizontal,
            colorText: whiteColor);

        Get.offAllNamed(RouteConstant.activeJobScreen);
        return responseBody;
      } else {
        log("BODY DATA UPLOAD PHOTO: ${responseBody['message']}");
        Get.snackbar('Something went wrong!', responseBody['message'],
            backgroundColor: redColor,
            dismissDirection: DismissDirection.horizontal,
            colorText: whiteColor);
      }
    } catch (e) {
      log('Error while getting data: $e');
      Get.snackbar('Something went wrong!', e.toString(),
          backgroundColor: redColor,
          dismissDirection: DismissDirection.horizontal,
          colorText: whiteColor);
    } finally {
      isUploadImageLoading(false);
    }
  }

  Future finishJobApi() async {
    try {
      isUploadImageLoading(true);
      // Prepare FormData to hold multiple images
      dio.FormData params = dio.FormData();
      print("filePaths.length${filePaths.length}");
      print("fileNames.length${fileNames.length}");
      // Iterate through selected images and add them to FormData
      var jobId = GetStorage().read('jobId');
      print("jobIdd: $jobId");

      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              "https://dendyapp.chawtechsolutions.ch/api/job/completejob/$jobId"));
      for (int i = 0; i < filePaths.length; i++) {
        // var fileName = fileNames[i]; // Get the file name
        // var multipartFile = await dio.MultipartFile.fromFile(filePaths[i].path,
        //     filename: fileName);
        // params.files
        //     .add(MapEntry('image[]', multipartFile)); // Add image to FormData
        // Store the file name
        // var fileStream = http.ByteStream(filePaths[i].openRead());
        // var fileLength = await filePaths[i].length();
        // print("fileName$fileName");
        // print("filePaths[i]${filePaths[i].path}");
        // String? filePath = await LecleFlutterAbsolutePath.getAbsolutePath(
        //     uri: filePaths[i].path);
        // final tempDir = await getTemporaryDirectory();
        // print("tempDir.path${tempDir.path}");
        // final filee = await File(filePaths[i].path)
        //     .copy('${tempDir.path}/${fileNames[i]}');
        // final filePathh = filee.path;
        // // String? filePath = await LecleFlutterAbsolutePath.getAbsolutePath(
        // //     uri: filePaths[i].path);

        print("filePathh${filePaths[i].path}");
        request.files.add(http.MultipartFile(
            'image[]', // Replace 'image' with the form field name expected by your API
            // filePaths[i].path
            File(filePaths[i].path).readAsBytes().asStream(),
            File(filePaths[i].path).lengthSync(),
            // fileLength,
            filename: fileNames[i]));
        print(" request.files${request.files}");
      }
      String jobEndTime =
          DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());
      // params.fields.add(MapEntry('job_end_time', jobEndTime));
      request.fields['job_end_time'] = jobEndTime;
      print("params: $params");
      var token = GetStorage().read('access_token');
      print("token: $token");

      request.headers['Authorization'] = 'Bearer $token';

      var streamResponse = await request.send();
      var response = await http.Response.fromStream(streamResponse);
      print("response.data: ${response}");

      var responseBody = jsonDecode(response.body);

      if (responseBody['status'] == true) {
        log("BODY DATA UPLOAD PHOTO: ${responseBody['message']}");
        Get.snackbar('Success', responseBody['message'],
            backgroundColor: purpleColor,
            dismissDirection: DismissDirection.horizontal,
            colorText: whiteColor);

        Get.offAllNamed(RouteConstant.dashboardScreen);
      } else {
        log("BODY DATA UPLOAD PHOTO: ${responseBody['message']}");
        Get.snackbar('Something went wrong!', responseBody['message'],
            backgroundColor: redColor,
            dismissDirection: DismissDirection.horizontal,
            colorText: whiteColor);
      }
    } catch (e) {
      log('Error while getting data: $e');
      Get.snackbar('Something went wrong!', e.toString(),
          backgroundColor: redColor,
          dismissDirection: DismissDirection.horizontal,
          colorText: whiteColor);
    } finally {
      isUploadImageLoading(false);
    }
  }
}
