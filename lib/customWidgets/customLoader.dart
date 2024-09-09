import 'dart:io';

import 'package:dendy_app/utils/appcolors.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final Color color;
  const Loader({super.key, this.color = whiteColor});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CircularProgressIndicator.adaptive(
            backgroundColor: color,
            strokeWidth: 8,
            valueColor: AlwaysStoppedAnimation<Color>(color))
        : SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator.adaptive(
                backgroundColor: null,
                valueColor: AlwaysStoppedAnimation<Color>(color)),
          );
  }
}
