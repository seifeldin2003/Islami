import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_assets.dart';
import '../app_dimens.dart';
import '../theme/app_theme.dart';

/// Figma `TextFormFeild`: the search box used by the sura list and the
/// radio line-up.
class AppSearchField extends StatelessWidget {
  const AppSearchField({
    super.key,
    required this.controller,
    required this.hint,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimens.searchFieldHeight,
      decoration: BoxDecoration(
        color: AppColors.scrim,
        border: Border.all(color: AppColors.gold),
        borderRadius: BorderRadius.circular(AppDimens.searchFieldRadius),
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: AppDimens.searchFieldPadding),
          SvgPicture.asset(
            AppAssets.icSearchQuran,
            width: AppDimens.searchIconSize,
            height: AppDimens.searchIconSize,
          ),
          const SizedBox(width: AppDimens.searchIconGap),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppTextStyles.sectionTitle,
              cursorColor: AppColors.gold,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: AppTextStyles.sectionTitle,
              ),
            ),
          ),
          const SizedBox(width: AppDimens.searchFieldPadding),
        ],
      ),
    );
  }
}
