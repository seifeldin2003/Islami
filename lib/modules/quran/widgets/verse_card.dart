import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_strings.dart';
import '../../../core/theme/app_theme.dart';

/// One verse in an outlined gold card.
///
/// The card takes its height from the text, so a long verse simply makes
/// a taller card.
class VerseCard extends StatelessWidget {
  const VerseCard({super.key, required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 16.w,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gold),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Text(
        AppStrings.verse(number, text),
        textAlign: TextAlign.center,
        // The paragraph is right-to-left, and the leading `[n]` is a
        // neutral run, so it lands at the right-hand end of the first line.
        textDirection: TextDirection.rtl,
        style: AppTextStyles.verse,
      ),
    );
  }
}
