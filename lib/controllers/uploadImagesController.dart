// ignore_for_file: body_might_complete_normally_nullable, empty_catches

import 'dart:developer';
import 'dart:io';

import 'package:dendy_app/routes.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_painter_v2/flutter_painter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;
import 'package:dio/dio.dart' as dio;
import 'package:uuid/uuid.dart';

class UploadImageController extends GetxController {
  var isDataLoading = false.obs;
  var isImageProcessing = false.obs;
  var isUploadImageLoading = false.obs;
  late PainterController imageController;
  var whichJob = 'null'.obs;
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
    whichJob.value = Get.arguments.toString();
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
      var uuid = Uuid();

      fileName.value = image.path.split('/').last;
      file.value = File(image.path);
      print("FILE,${File(image.path)}");
      print("PATH,${fileName}");
      print(
          "PATH2,${dio.MultipartFile.fromFile(file.value.path, filename: fileName.value)}");
      dio.FormData params = dio.FormData.fromMap({
        'image[]': await dio.MultipartFile.fromFile(file.value.path,
            filename: fileName.value)
      });

      print("params$params");
      print("file.value.path${file.value.path}");
      print("file.value.path${fileName.value}");
      var token = GetStorage().read('access_token');
      print("token$token");
      filePaths.add(file.value);
      fileNames.add(fileName.value);
      Get.toNamed(RouteConstant.uploadImagesViewScreen,
          arguments: {"imagePath": '${file.value}'});
      // dio.Response response = await Dio().post(baseUrl + "job/startjob/1",
      //     data: params,
      //     options: Options(headers: {
      //       "Authorization": "Bearer $token",
      //     }));

      // print("response.data${response}");
      // print("response${response}");

      // if (response.data['status'] == true) {
      //   log("BODY DATA UPLOAD PHOTO,${response.data}");
      //   // filePath.value = response.data['data']['file_path'];
      //   print("BODY DATA STATUS UPLOAD PHOTO,${response.data['status']}");
      //   print("BODY DATA MESSAGE UPLOAD PHOTO,${response.data['message']}");
      //   return response;
      // } else {
      //   log("BODY DATA UPLOAD PHOTO,${response.data}");
      //   print("BODY DATA STATUS UPLOAD PHOTO,${response.data['status']}");
      //   print("BODY DATA MESSAGE UPLOAD PHOTO,${response.data['message']}");
      //   return response;
      // }
    } catch (e) {
      log('Error while getting data is $e');
      print('Error while getting data is $e');
    } finally {
      isUploadImageLoading(false);
    }
  }

  Future<dio.Response?> startJobApii() async {
    try {
      isUploadImageLoading(true);
      // Prepare FormData to hold multiple images
      dio.FormData params = dio.FormData();
      print("filePaths.length${filePaths.length}");
      print("fileNames.length${fileNames.length}");
      // Iterate through selected images and add them to FormData
      for (int i = 0; i < filePaths.length; i++) {
        var fileName = fileNames[i]; // Get the file name
        var multipartFile = await dio.MultipartFile.fromFile(filePaths[i].path,
            filename: fileName);
        params.files
            .add(MapEntry('image[]', multipartFile)); // Add image to FormData
        // Store the file name
      }

      print("params: $params");
      var token = GetStorage().read('access_token');
      print("token: $token");
      var jobId = GetStorage().read('jobId');
      // Make the API call
      dio.Response response = await Dio().post(
        baseUrl + "job/startjob/$jobId",
        data: params,
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }),
      );

      // print("response.data: ${response.data}");
      if (response.data['status'] == true) {
        log("BODY DATA UPLOAD PHOTO: ${response.data}");
        print("BODY DATA STATUS UPLOAD PHOTO: ${response.data['status']}");
        print("BODY DATA MESSAGE UPLOAD PHOTO: ${response.data['message']}");
        Get.snackbar('Success', response.data['message'],
            backgroundColor: Colors.purple,
            dismissDirection: DismissDirection.horizontal,
            colorText: whiteColor);

        Get.offAllNamed(RouteConstant.pendingJobDetailsScreen);
        return response;
      } else {
        log("BODY DATA UPLOAD PHOTO: ${response.data}");
        print("BODY DATA STATUS UPLOAD PHOTO: ${response.data['status']}");
        print("BODY DATA MESSAGE UPLOAD PHOTO: ${response.data['message']}");
        return response;
      }
    } catch (e) {
      log('Error while getting data: $e');
      print('Error while getting data: $e');
    } finally {
      isUploadImageLoading(false);
    }
  }

  Future<dio.Response?> startJobApi(XFile image) async {
    try {
      isUploadImageLoading(true);
      print(
          "PATH2,${dio.MultipartFile.fromFile(file.value.path, filename: fileName.value)}");
      dio.FormData params = dio.FormData.fromMap({
        'image[]': await dio.MultipartFile.fromFile(file.value.path,
            filename: fileName.value)
      });

      print("params$params");
      print("file.value.path${file.value.path}");
      print("file.value.path${fileName.value}");
      var token = GetStorage().read('access_token');
      print("token$token");
      filePaths.add(file.value);
      fileNames.add(fileName.value);
      Get.toNamed(RouteConstant.uploadImagesViewScreen,
          arguments: {"imagePath": '${file.value}'});
      dio.Response response = await Dio().post(baseUrl + "job/startjob/1",
          data: params,
          options: Options(headers: {
            "Authorization": "Bearer $token",
          }));

      print("response.data${response}");
      print("response${response}");

      if (response.data['status'] == true) {
        log("BODY DATA UPLOAD PHOTO,${response.data}");
        // filePath.value = response.data['data']['file_path'];
        print("BODY DATA STATUS UPLOAD PHOTO,${response.data['status']}");
        print("BODY DATA MESSAGE UPLOAD PHOTO,${response.data['message']}");
        return response;
      } else {
        log("BODY DATA UPLOAD PHOTO,${response.data}");
        print("BODY DATA STATUS UPLOAD PHOTO,${response.data['status']}");
        print("BODY DATA MESSAGE UPLOAD PHOTO,${response.data['message']}");
        return response;
      }
    } catch (e) {
      log('Error while getting data is $e');
      print('Error while getting data is $e');
    } finally {
      isUploadImageLoading(false);
    }
  }
}
