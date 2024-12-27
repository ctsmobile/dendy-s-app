// ignore_for_file: prefer_const_constructors

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dendy_app/controllers/activeJobController.dart';
import 'package:dendy_app/routes.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CommonBottomBar extends StatelessWidget {
  const CommonBottomBar({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    Utils.width = MediaQuery.of(context).size.width;
    Utils.height = MediaQuery.of(context).size.height;
    return Container(
      height: 80,
      decoration: BoxDecoration(
          color: appThemeColor,
          image: DecorationImage(
              image: AssetImage('${baseImagePath}footer2.png'),
              alignment: Alignment.bottomCenter)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            index == 0
                ? _commonTabWithIndex(
                    imagePath: '${baseImagePath}scan.png',
                  )
                : _commonTab(
                    imagePath: '${baseImagePath}scan2.png',
                    navigationPath: RouteConstant.dashboardScreen,
                  ),
            index == 1
                ? _commonTabWithIndex(
                    imagePath: '${baseImagePath}active2.png',
                  )
                : _commonTab(
                    imagePath: '${baseImagePath}active2.png',
                    navigationPath: GetStorage().read('onlyOne') == true
                        ? RouteConstant.activeJobDetailsScreen
                        : RouteConstant.activeJobListScreen,
                  ),
            index == 2
                ? _commonTabWithIndex(
                    imagePath: '${baseImagePath}profile2.png',
                  )
                : _commonTab(
                    imagePath: '${baseImagePath}profile.png',
                    navigationPath: RouteConstant.profileScreen,
                  ),
          ],
        ),
      ),
    );
  }

  Widget _commonTabWithIndex({
    required String imagePath,
  }) {
    return Image.asset(
      imagePath,
      height: Utils.height! / 6,
      width: Utils.width! / 7,
    );
  }

  Widget _commonTab({
    required String imagePath,
    required String navigationPath,
  }) {
    return GestureDetector(
      child: Image.asset(
        imagePath,
        height: Utils.height! / 7,
        width: Utils.width! / 7,
      ),
      onTap: () async {
        final connectivityResult = await Connectivity().checkConnectivity();

        if (connectivityResult.contains(ConnectivityResult.none)) {
          showSnackBar(
            'Please check your internet connection!',
            titleText: 'Network Error',
          );
        } else {
          if (Get.isRegistered<ActiveJobController>()) {
            Get.toNamed(navigationPath);
          } else {
            Get.offAllNamed(navigationPath.replaceAll(
                RouteConstant.activeJobDetailsScreen,
                RouteConstant.activeJobListScreen));
          }
        }
      },
    );
  }
}
