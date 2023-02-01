import 'package:flutter/material.dart';

Widget sizedBox(double? sbWeight, double? sbHeight) {
  return SizedBox(
    width: sbWeight,
    height: sbHeight,
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
