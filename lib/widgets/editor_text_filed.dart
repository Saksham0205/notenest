import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditorTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextStyle? style;
  final int? maxLines;

  const EditorTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.style,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(16.w),
      ),
      style: style,
      maxLines: maxLines,
      keyboardType: maxLines == null ? TextInputType.multiline : null,
    );
  }
}