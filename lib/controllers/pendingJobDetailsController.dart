// ignore_for_file: body_might_complete_normally_nullable

import 'dart:developer';

import 'package:dendy_app/Model/activeJobModel.dart';
import 'package:dendy_app/Model/loginModel.dart';
import 'package:dendy_app/Network/post.dart';
import 'package:dendy_app/routes.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PendingJobDetailsController extends GetxController {
  var isCancelTap = false.obs;

  @override
  void dispose() {
    Get.delete<PendingJobDetailsController>();
    super.dispose();
  }

  Future cancelJob() async {
    isCancelTap.value = true;
    await cancelJobApi().then((cancelJobResponse) {
      if (cancelJobResponse != null) {
        if (!cancelJobResponse.status) {
          showSnackBar(cancelJobResponse.message);

          isCancelTap.value = false;
        } else {
          showSnackBar(cancelJobResponse.message, backgroundColor: purpleColor);

          isCancelTap.value = false;
          Get.offAllNamed(RouteConstant.dashboardScreen);
        }
      } else {
        isCancelTap.value = false;
      }
    });
  }

  Future<LoginModel?> cancelJobApi() async {
    try {
      Post post = Post();
      var jobId = GetStorage().read('jobId');
      // var jobId = '101';
      print("jobId: $jobId");
      return await post
          .post(
        'job/canceljob/$jobId',
      )
          .then((dynamic res) async {
        print("canceljob$res");
        return LoginModel.fromJson(res!);
      });
    } catch (e) {
      log('Error in canceljob is $e');
    }
  }
}
