import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../models/home_tab.dart';

/// A gold bar where the selected destination sits in a dark pill with its
/// label underneath.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.current,
    required this.onSelected,
  });

  final HomeTab current;
  final ValueChanged<HomeTab> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h + MediaQuery.viewPaddingOf(context).bottom,
      color: AppColors.gold,
      padding: EdgeInsets.only(
        top: 6.h,
        bottom: MediaQuery.viewPaddingOf(context).bottom,
      ),
      child: Row(
        children: <Widget>[
          for (final tab in HomeTab.values)
            Expanded(
              child: _NavItem(
                tab: tab,
                isSelected: tab == current,
                onTap: () => onSelected(tab),
              ),
            ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  final HomeTab tab;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final icon = SvgPicture.asset(
      tab.icon,
      height: 26.r,
      colorFilter: ColorFilter.mode(
        isSelected ? Colors.white : AppColors.background,
        BlendMode.srcIn,
      ),
    );

    return Semantics(
      selected: isSelected,
      button: true,
      label: tab.label,
      child: InkWell(
        onTap: onTap,
        // On a short screen the bar's own height shrinks faster than its
        // text does, so the contents scale down instead of overflowing.
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (isSelected)
                Container(
                  width: 59.w,
                  height: 34.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.navSelectedPill,
                    borderRadius: BorderRadius.circular(66.r),
                  ),
                  child: icon,
                )
              else
                SizedBox(height: 34.h, child: Center(child: icon)),
              if (isSelected)
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Text(tab.label, style: AppTextStyles.navLabel),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
