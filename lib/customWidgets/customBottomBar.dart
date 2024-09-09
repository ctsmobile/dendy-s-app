// ignore_for_file: prefer_const_constructors

import 'package:dendy_app/routes.dart';
import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonBottomBar extends StatelessWidget {
  const CommonBottomBar({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    Utils.width = MediaQuery.of(context).size.width;
    Utils.height = MediaQuery.of(context).size.height;
    return Container(
      height: 100,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('${baseImagePath}footer.png'),
              alignment: Alignment.bottomCenter)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            index == 0
                ? _commonTabWithIndex(
                    imagePath: '${baseImagePath}scan.png', tabName: 'My Map')
                : _commonTab(
                    tabName: 'My Map',
                    imagePath: '${baseImagePath}scan.png',
                    navigationPath: RouteConstant.myMapScreen,
                  ),
            index == 1
                ? _commonTabWithIndex(
                    imagePath: '${baseImagePath}clock.png',
                    tabName: 'My Orders')
                : _commonTab(
                    tabName: 'My Orders',
                    imagePath: '${baseImagePath}clock.png',
                    navigationPath: RouteConstant.dashboardScreen,
                  ),
            index == 2
                ? _commonTabWithIndex(
                    imagePath: '${baseImagePath}profile.png',
                    tabName: 'Unassigned')
                : _commonTab(
                    tabName: 'Unassigned',
                    imagePath: '${baseImagePath}profile.png',
                    navigationPath: RouteConstant.myMapScreen,
                  ),
          ],
        ),
      ),
    );
  }

  Widget _commonTabWithIndex(
      {required String imagePath, required String tabName}) {
    return Image.asset(
      imagePath,
      height: Utils.height! / 7,
      width: Utils.width! / 7,
    );
  }

  Widget _commonTab({
    required String tabName,
    required String imagePath,
    required String navigationPath,
  }) {
    return GestureDetector(
      child: Image.asset(
        imagePath,
        height: Utils.height! / 7,
        width: Utils.width! / 7,
      ),
      onTap: () {
        Get.offAllNamed(navigationPath);
      },
    );
  }
}

class CustomShapeBorder extends ShapeBorder {
  const CustomShapeBorder();

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      _getPath(rect);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      _getPath(rect);

  _getPath(Rect rect) {
    print(
        "rrr${rect.height} rect.topLeft.dx${rect.topLeft.dx} rect.topLeft.dy${rect.topLeft.dy}");
    final r = rect.height / 5;
    final radius = Radius.circular(r);
    final offset = Rect.fromCircle(center: Offset.zero, radius: r);
    return Path()
      ..moveTo(rect.topLeft.dx, rect.topLeft.dy)
      ..relativeArcToPoint(offset.bottomRight, clockwise: false, radius: radius)
      ..lineTo(rect.centerRight.dx - r, rect.centerRight.dy - r - 10)
      ..relativeArcToPoint(offset.topRight, clockwise: false, radius: radius)
      ..addRect(rect);
  }

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(0);
  }

  @override
  ShapeBorder scale(double t) {
    return CustomShapeBorder();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}
}
