// ignore_for_file: body_might_complete_normally_nullable

import 'dart:convert';
import 'dart:developer';

import 'package:dendy_app/Model/activeJobModel.dart';
import 'package:dendy_app/Model/loginModel.dart';
import 'package:dendy_app/Model/pendingJobListModel.dart';
import 'package:dendy_app/Network/post.dart';
import 'package:dendy_app/controllers/dashboardController.dart';
import 'package:dendy_app/routes.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class PendingJobDetailsController extends GetxController {
  var isAcceptTap = false.obs;
  var isClockInTap = false.obs;
  var isDeclineTap = false.obs;
  var isAcceptDone = false.obs;
  late PendingJobs pendingJobDetails;
  @override
  void onInit() {
    super.onInit();

    pendingJobDetails = Get.arguments['pendingJobDetail'];
  }

  @override
  void dispose() {
    Get.delete<PendingJobDetailsController>();
    super.dispose();
  }

  Future acceptJob({bool forReject = false}) async {
    if (forReject) {
      isDeclineTap.value = true;
    } else {
      isAcceptTap.value = true;
    }

    await acceptJobApi(forReject: forReject).then((acceptJobResponse) {
      if (acceptJobResponse != null) {
        if (!acceptJobResponse.status) {
          showSnackBar(acceptJobResponse.message.toString());

          if (forReject) {
            isDeclineTap.value = false;
          } else {
            isAcceptTap.value = false;
          }
        } else {
          if (forReject) {
            showSnackBar('Job declined successfully !',
                backgroundColor: purpleColor);
          } else {
            showSnackBar(acceptJobResponse.message.toString(),
                backgroundColor: purpleColor);
          }

          if (forReject) {
            isDeclineTap.value = false;
          } else {
            isAcceptTap.value = false;
            Get.find<DashboardController>().getPendingJobList();
            isAcceptDone.value = true;
            for (var employee in pendingJobDetails.employees) {
              if (employee.employeeId == GetStorage().read('user_id')) {
                employee.request_status =
                    1; // Update request_status to desired value
                break; // Exit loop once found and updated
              }
            }
          }
          if (!isAcceptDone.value) {
            Get.offAllNamed(RouteConstant.dashboardScreen);
          }
        }
      } else {
        if (forReject) {
          isDeclineTap.value = false;
        } else {
          isAcceptTap.value = false;
        }
      }
    });
  }

  Future<LoginModel?> acceptJobApi({bool forReject = false}) async {
    try {
      Post post = Post();
      var jobId = GetStorage().read('jobId');
      // var jobId = '101';
      print("jobId: $jobId");
      return await post
          .post(
        'job/${forReject ? 'rejectjob' : 'acceptjob'}/$jobId',
      )
          .then((dynamic res) async {
        print("acceptjob$res");
        return LoginModel.fromJson(res!);
      });
    } catch (e) {
      log('Error in acceptjob is $e');
    }
  }


  Future clockIn() async {
    isClockInTap.value = true;
    await clockInApi().then((jobDetails) {
      print("jobDetails$jobDetails");
      if (jobDetails != null) {
        if (!jobDetails['status']) {
          showSnackBar(jobDetails['message'].toString());
        
          isClockInTap.value = false;
        } else {
            showSnackBar(jobDetails['message'].toString());
       

          isClockInTap.value = false;
        }
      } else {
        isClockInTap.value = false;
      }
    });
  }

  Future clockInApi() async {
    try {
      Post post = Post();
      var jobId = GetStorage().read('jobId').toString();
 String jobClockInTime =
          DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());
      print("jobId: $jobId $jobClockInTime");
       Map data = {
        'clock_in': jobClockInTime,
     
      };
      return await post
          .post(
        'job/clockin/$jobId',
        body: jsonEncode(data)
      )
          .then((dynamic res) async {
        print("clockin$res");
        if (res == 'Error') {
          return res;
        } else {
       return res;
        }
      });
    } catch (e) {
      log('Error in clockInApi is $e');
    } finally {
      isClockInTap(false);
    }
  }

}
