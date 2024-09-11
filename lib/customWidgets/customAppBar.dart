// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors

import 'package:dendy_app/customWidgets/customText.dart';
import 'package:dendy_app/utils/appcolors.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final bool isLeading;
  final List<Widget>? actionsWidget;
  MyAppBar({required this.title, this.actionsWidget, this.isLeading = true});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppBar(
          backgroundColor: appThemeColor,
          scrolledUnderElevation: 0,
          centerTitle: true,
          leading: isLeading
              ? IconButton(
                  icon: Image.asset(
                    '${baseImagePath}back.png',
                    height: Utils.height! / 12,
                    width: Utils.width! / 12,
                  ), // Custom Icon
                  onPressed: () {
                    Get.back();
                  },
                )
              : SizedBox(),
          title: CustomText(
            text: title,
            textColor: purpleColor,
            fontSize: 24,
          ),
          actions: actionsWidget),
    );
  }
}
