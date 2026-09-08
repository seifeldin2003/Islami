import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_assets.dart';
import '../theme/app_theme.dart';

/// The search box used by the sura list and the radio line-up.
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
      height: 55.h,
      decoration: BoxDecoration(
        color: AppColors.scrim,
        border: Border.all(color: AppColors.gold),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 14.w),
          SvgPicture.asset(
            AppAssets.icSearchQuran,
            width: 28.r,
            height: 28.r,
          ),
          SizedBox(width: 15.w),
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
          SizedBox(width: 14.w),
        ],
      ),
    );
  }
}
