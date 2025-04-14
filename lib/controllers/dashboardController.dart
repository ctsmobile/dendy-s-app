// ignore_for_file: body_might_complete_normally_nullable, avoid_print

import 'dart:developer';

import 'package:dendy_app/Model/pendingJobListModel.dart';
import 'package:dendy_app/Network/post.dart';
import 'package:dendy_app/firebaseApi.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var isDataLoading = false.obs;
  late PendingJobListModel newJobListModel;

  late PendingJobListModel pendingJobListModel;
  late PendingJobListModel completedJobListModel;
  late PendingJobListModel expectedJobListModel;
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
        await getNewJobListApi().then((newJob) async {
      if (newJob != null) {

            if (!newJob.status) {
          isDataLoading.value = false;
          newJobListModel = newJob;
          pendingJobListModel = newJob;
          expectedJobListModel = newJob;
          completedJobListModel = newJob;
          showSnackBar(newJob.message.toString());
        }else{
  newJobListModel = newJob;
  await FirebaseAPI().initNotifications();
  await getPendingJobListApi().then((pendingJob) async {
      if (pendingJob != null) {
        if (!pendingJob.status) {
          isDataLoading.value = false;
          pendingJobListModel = pendingJob;
          completedJobListModel = pendingJob;
          showSnackBar(pendingJob.message.toString());
        } else {
          pendingJobListModel = pendingJob;
        
          await getExpectedJobListApi().then((expectedJob) async {
            if (expectedJob != null) {
              if (!expectedJob.status) {
                print("bvbbv");

                expectedJobListModel = expectedJob;
                showSnackBar(expectedJob.message.toString());
              } else {
                expectedJobListModel = expectedJob;
                await getCompletedJobListApi().then((completeJob) {
                  if (completeJob != null) {
                    if (!completeJob.status) {
                      print("bvbbv");
                      isDataLoading.value = false;
                      completedJobListModel = completeJob;
                      showSnackBar(completeJob.message.toString());
                    } else {
                      completedJobListModel = completeJob;
                    }
                  }
                  isDataLoading.value = false;
                });
              }
            }
          });
        }
      } else {
        isDataLoading.value = false;
      }
    });
        }
      }

        });


    
  }
Future<PendingJobListModel?> getNewJobListApi() async {
    try {
      Post post = Post();
      return await post
          .get(
        'job/list/new',
      )
          .then((dynamic res) async {
        print("newJob$res");
        if (res == 'Error') {
          return PendingJobListModel.fromJson({});
        } else {
          return PendingJobListModel.fromJson(res!);
        }
      });
    } catch (e) {
      log('Error in new is $e');
    } finally {
      // isDataLoading(false);
    }
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
        if (res == 'Error') {
          return PendingJobListModel.fromJson({});
        } else {
          return PendingJobListModel.fromJson(res!);
        }
      });
    } catch (e) {
      log('Error in pendingJob is $e');
    } finally {
      // isDataLoading(false);
    }
  }

  Future<PendingJobListModel?> getExpectedJobListApi() async {
    try {
      Post post = Post();
      return await post
          .get(
        'job/list/expected',
      )
          .then((dynamic res) async {
        print("ExpectedJob$res");
        if (res == 'Error') {
          return PendingJobListModel.fromJson({});
        } else {
          return PendingJobListModel.fromJson(res!);
        }
      });
    } catch (e) {
      log('Error in ExpectedJob is $e');
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
        if (res == 'Error') {
          return PendingJobListModel.fromJson({});
        } else {
          return PendingJobListModel.fromJson(res!);
        }
      });
    } catch (e) {
      log('Error in completedJob is $e');
    } finally {
      isDataLoading(false);
    }
  }
}
