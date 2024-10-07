// ignore_for_file: body_might_complete_normally_nullable

import 'dart:developer';

import 'package:dendy_app/Model/pendingJobListModel.dart';
import 'package:dendy_app/Network/post.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var isDataLoading = false.obs;
  late PendingJobListModel pendingJobListModel;
  late PendingJobs pendingJobDetails;
  @override
  void onInit() {
    super.onInit();
    getPendingJobList();
  }

  @override
  void dispose() {
    Get.delete<DashboardController>();
    super.dispose();
  }

  Future getPendingJobList() async {
    isDataLoading.value = true;
    await getPendingJobListApi().then((pendingJob) {
      if (pendingJob != null) {
        if (!pendingJob.status) {
          Get.snackbar('login', pendingJob.message,
              backgroundColor: purpleColor, colorText: whiteColor);
          isDataLoading.value = false;
        } else {
          pendingJobListModel = pendingJob;
          // getCompletedJobListApi();
          isDataLoading.value = false;
        }
      } else {
        isDataLoading.value = false;
      }
    });
  }

  Future<PendingJobListModel?> getPendingJobListApi() async {
    try {
      Post post = Post();
      return await post
          .get(
        'job/list/pending',
      )
          .then((dynamic res) async {
        print("pendingJob$res");
        return PendingJobListModel.fromJson(res!);
      });
    } catch (e) {
      log('Error in pendingJob is $e');
    } finally {
      isDataLoading(false);
    }
  }

  Future<PendingJobListModel?> getCompletedJobListApi() async {
    try {
      Post post = Post();
      return await post
          .get(
        'job/list/completed',
      )
          .then((dynamic res) async {
        print("pendingJob$res");
        return PendingJobListModel.fromJson(res!);
      });
    } catch (e) {
      log('Error in pendingJob is $e');
    } finally {
      isDataLoading(false);
    }
  }
}
