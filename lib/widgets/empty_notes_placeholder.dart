import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyNotesPlaceholder extends StatelessWidget {
  const EmptyNotesPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No notes yet\nTap + to create one',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: 16.sp,
        ),
      ),
    );
  }
}