// ignore_for_file: body_might_complete_normally_nullable

import 'package:get/get.dart';

class UploadImagesViewController extends GetxController {
  var isDataLoading = false.obs;

  var whichJob = 'null'.obs;

  @override
  void onInit() {
    super.onInit();
    whichJob.value = Get.arguments.toString();
  }

  @override
  void dispose() {
    Get.delete<UploadImagesViewController>();
    super.dispose();
  }
}
