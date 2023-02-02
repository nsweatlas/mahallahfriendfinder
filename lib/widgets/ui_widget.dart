import 'package:flutter/material.dart';

double iconSize = 26.0;

Widget sizedBox(double? sbWeight, double? sbHeight) {
  return SizedBox(
    width: sbWeight,
    height: sbHeight,
  );
}

Widget sizedBoxChild(double? sbWidth, double? sbHeight, Widget? child) {
  return SizedBox(
    width: sbWidth,
    height: sbHeight,
    child: child,
  );
}

Widget entryField(
  String title,
  TextEditingController controller,
) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(labelText: title),
  );
}

Widget circleLoading(double? value) {
  return CircularProgressIndicator(
    value: value,
    valueColor: const AlwaysStoppedAnimation(Color.fromARGB(255, 0, 124, 112)),
    backgroundColor: const Color.fromARGB(255, 206, 206, 206),
    strokeWidth: 12,
  );
}
