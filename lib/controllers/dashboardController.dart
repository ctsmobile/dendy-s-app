// ignore_for_file: body_might_complete_normally_nullable, avoid_print

import 'dart:developer';

import 'package:dendy_app/Model/pendingJobListModel.dart';
import 'package:dendy_app/Network/post.dart';
import 'package:dendy_app/firebaseApi.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var isDataLoading = false.obs;
  late PendingJobListModel pendingJobListModel;
  late PendingJobListModel completedJobListModel;
  late PendingJobs pendingJobDetails;
  late PendingJobs completeJobDetails;
  var initialIndex = 0;
  @override
  void onInit() {
    super.onInit();
    print("Get.arguments${Get.arguments}");
    if (Get.arguments != null) {
      initialIndex = Get.arguments['initialIndex'];
    }
    getPendingJobList();
  }

  @override
  void dispose() {
    Get.delete<DashboardController>();
    super.dispose();
  }

  Future getPendingJobList() async {
    isDataLoading.value = true;
    await getPendingJobListApi().then((pendingJob) async {
      if (pendingJob != null) {
        if (!pendingJob.status) {
          showSnackBar(pendingJob.message);
        } else {
          pendingJobListModel = pendingJob;
          await FirebaseAPI().initNotifications();
          await getCompletedJobListApi().then((completeJob) {
            if (completeJob != null) {
              if (!completeJob.status) {
                showSnackBar(completeJob.message);
              } else {
                completedJobListModel = completeJob;
              }
            }
            isDataLoading.value = false;
          });
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
      // isDataLoading(false);
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
        print("completedJob$res");
        return PendingJobListModel.fromJson(res!);
      });
    } catch (e) {
      log('Error in completedJob is $e');
    } finally {
      isDataLoading(false);
    }
  }
}
