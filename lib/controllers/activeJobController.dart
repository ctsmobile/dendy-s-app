// ignore_for_file: body_might_complete_normally_nullable

import 'dart:developer';

import 'package:dendy_app/Model/activeJobModel.dart';
import 'package:dendy_app/Network/post.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:get/get.dart';

class ActiveJobController extends GetxController {
  var isDataLoading = false.obs;
  var activeJobModel =
      ActiveJobModel(data: [], error: null, message: "null", status: false).obs;
  var index = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getActiveJobDetails();
  }

  @override
  void dispose() {
    Get.delete<ActiveJobController>();
    super.dispose();
  }

  void updateTaskStatus(int index, int status) {
    activeJobModel.value.data.first.tasks[index].status = status;
    activeJobModel.refresh(); // Refresh to trigger UI updates
  }

  Future getActiveJobDetails() async {
    isDataLoading.value = true;
    await getActiveJobDetailsApi().then((activeJob) {
      if (activeJob != null) {
        if (!activeJob.status) {
          Get.snackbar('activejob', activeJob.message,
              backgroundColor: purpleColor, colorText: whiteColor);
          isDataLoading.value = false;
        } else {
          activeJobModel.value = activeJob;

          isDataLoading.value = false;
        }
      } else {
        isDataLoading.value = false;
      }
    });
  }

  Future<ActiveJobModel?> getActiveJobDetailsApi() async {
    try {
      Post post = Post();
      return await post
          .get(
        'job/list/active',
      )
          .then((dynamic res) async {
        print("active$res");
        return ActiveJobModel.fromJson(res!);
      });
    } catch (e) {
      log('Error in active is $e');
    } finally {
      isDataLoading(false);
    }
  }
}
