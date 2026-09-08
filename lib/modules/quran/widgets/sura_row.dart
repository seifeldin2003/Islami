import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_assets.dart';
import '../../../core/app_strings.dart';
import '../../../core/models/sura.dart';
import '../../../core/theme/app_theme.dart';

/// A numbered star badge, the English name over the verse count, and the
/// Arabic name pinned to the right.
class SuraRow extends StatelessWidget {
  const SuraRow({super.key, required this.sura, required this.onTap});

  final Sura sura;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      // A minimum rather than a fixed height: on the artboard the row is
      // exactly 73pt, but on a short, wide screen the text must be allowed
      // to push it taller instead of overflowing.
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 73.h),
        child: Row(
          children: <Widget>[
            SizedBox(width: 21.w),
            SizedBox(
              width: 52.r,
              height: 52.r,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    AppAssets.icSuraNumber,
                    width: 52.r,
                    height: 52.r,
                  ),
                  Text('${sura.number}', style: AppTextStyles.suraName),
                ],
              ),
            ),
            SizedBox(width: 24.w),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    sura.englishName,
                    style: AppTextStyles.suraName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    AppStrings.verses(sura.versesCount),
                    style: AppTextStyles.suraVerses,
                  ),
                ],
              ),
            ),
            Text(sura.arabicName, style: AppTextStyles.suraName),
            SizedBox(width: 23.w),
          ],
        ),
      ),
    );
  }
}

/// The hairline that separates two sura rows.
class SuraRowDivider extends StatelessWidget {
  const SuraRowDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 302.w,
        child: Divider(height: 10.h, color: Colors.white),
      ),
    );
  }
}
