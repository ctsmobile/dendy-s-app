// ignore_for_file: body_might_complete_normally_nullable

import 'dart:developer';

import 'package:dendy_app/Model/activeJobModel.dart';
import 'package:dendy_app/Network/post.dart';
import 'package:dendy_app/routes.dart';
import 'package:dendy_app/utils/utils.dart';
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

  void updateTaskStatus(int index, int taskIndex, int status) {
    activeJobModel.value.data[index].tasks[taskIndex].status = status;
    activeJobModel.refresh(); // Refresh to trigger UI updates
  }

  Future getActiveJobDetails() async {
    isDataLoading.value = true;
    await getActiveJobDetailsApi().then((activeJob) {
      if (activeJob != null) {
        if (!activeJob.status) {
          showSnackBar(activeJob.message);

          isDataLoading.value = false;
        } else {
          activeJobModel.value = activeJob;
          if (activeJobModel.value.data.length == 1) {
            Get.toNamed(RouteConstant.activeJobDetailsScreen,
                arguments: {'index': 0, 'onlyOne': true});
          } else {
            isDataLoading.value = false;
          }
        }
      } else {
        if (activeJobModel.value.data.length != 1) {
          isDataLoading.value = false;
        }
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
    }
  }
}
