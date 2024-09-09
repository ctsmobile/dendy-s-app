import 'package:dendy_app/customWidgets/customText.dart';
import 'package:flutter/material.dart';

class TabItem2 extends StatelessWidget {
  final String title;

  const TabItem2({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomText(
                text: title,
                textAlign: true,
                textColor: null,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
