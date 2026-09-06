import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_assets.dart';
import '../../../core/app_dimens.dart';
import '../../../core/app_strings.dart';
import '../../../core/models/sura.dart';
import '../../../core/theme/app_theme.dart';

/// Figma `Sura Name` row: numbered star badge, English name over the verse
/// count, and the Arabic name pinned to the right.
class SuraRow extends StatelessWidget {
  const SuraRow({super.key, required this.sura, required this.onTap});

  final Sura sura;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: AppDimens.suraRowHeight,
        child: Row(
          children: <Widget>[
            const SizedBox(width: AppDimens.homeSectionGutter),
            SizedBox(
              width: AppDimens.suraNumberSize,
              height: AppDimens.suraNumberSize,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    AppAssets.icSuraNumber,
                    width: AppDimens.suraNumberSize,
                    height: AppDimens.suraNumberSize,
                  ),
                  Text('${sura.number}', style: AppTextStyles.suraName),
                ],
              ),
            ),
            const SizedBox(width: AppDimens.suraNumberGap),
            Expanded(
              child: Column(
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
            const SizedBox(width: AppDimens.suraRowTrailingGutter),
          ],
        ),
      ),
    );
  }
}

/// Figma `Line 1`: the hairline that separates two sura rows.
class SuraRowDivider extends StatelessWidget {
  const SuraRowDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: AppDimens.dividerWidth,
        child: Divider(height: AppDimens.suraRowGap, color: Colors.white),
      ),
    );
  }
}
