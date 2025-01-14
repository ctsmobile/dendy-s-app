// ignore_for_file: body_might_complete_normally_nullable

import 'dart:developer';

import 'package:dendy_app/Model/activeJobModel.dart';
import 'package:dendy_app/Model/jobDetailsModel.dart';
import 'package:dendy_app/Network/post.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class JobDetailsController extends GetxController {
  var isDataLoading = false.obs;
  late JobDetailsModel jobDetailsModel;
  var forInitialImages = true.obs;
  @override
  void onInit() {
    super.onInit();

    getJobDetails();
  }

  @override
  void dispose() {
    Get.delete<JobDetailsController>();
    super.dispose();
  }

  Future getJobDetails() async {
    isDataLoading.value = true;
    await getJobDetailsApi().then((jobDetails) {
      if (jobDetails != null) {
        if (!jobDetails.status) {
          showSnackBar(jobDetails.message.toString());
          jobDetailsModel = jobDetails;
          isDataLoading.value = false;
        } else {
          jobDetailsModel = jobDetails;

          isDataLoading.value = false;
        }
      } else {
        isDataLoading.value = false;
      }
    });
  }

  Future<JobDetailsModel?> getJobDetailsApi() async {
    try {
      Post post = Post();
      var jobId = GetStorage().read('jobId').toString();

      print("jobId: $jobId");
      return await post
          .get(
        'job/detail/$jobId',
      )
          .then((dynamic res) async {
        print("jobDetails$res");
        if (res == 'Error') {
          return JobDetailsModel.fromJson({});
        } else {
          return JobDetailsModel.fromJson(res!);
        }
      });
    } catch (e) {
      log('Error in jobDetails is $e');
    } finally {
      isDataLoading(false);
    }
  }
}
