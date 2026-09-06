import 'package:flutter/material.dart';

import '../../../core/app_dimens.dart';
import '../../../core/app_strings.dart';
import '../../../core/theme/app_theme.dart';

/// Figma `Group 20`: one verse in an outlined gold card.
///
/// The card takes its height from the text, which is what makes the seventh
/// verse of Al-Fatiha 120pt tall in the design while the rest are 70pt.
class VerseCard extends StatelessWidget {
  const VerseCard({super.key, required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.verseCardPadding,
        horizontal: AppDimens.verseCardTextInset,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gold),
        borderRadius: BorderRadius.circular(AppDimens.verseCardRadius),
      ),
      child: Text(
        AppStrings.verse(number, text),
        textAlign: TextAlign.center,
        // Figma leaves the paragraph on `dir="auto"`, which resolves to RTL
        // because the first strong character is Arabic. The leading `[n]` is
        // neutral, so it lands at the right-hand end of the first line.
        textDirection: TextDirection.rtl,
        style: AppTextStyles.verse,
      ),
    );
  }
}
