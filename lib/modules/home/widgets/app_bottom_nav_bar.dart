import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_dimens.dart';
import '../../../core/theme/app_theme.dart';
import '../models/home_tab.dart';

/// Figma `Bottom Navigation Bar`: a gold bar where the selected destination
/// sits in a dark pill with its label underneath.
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
      height: AppDimens.navBarHeight + MediaQuery.viewPaddingOf(context).bottom,
      color: AppColors.gold,
      padding: EdgeInsets.only(
        top: AppDimens.navBarPadding,
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
      height: AppDimens.navIconSize,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (isSelected)
              Container(
                width: AppDimens.navPillWidth,
                height: AppDimens.navPillHeight,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.navSelectedPill,
                  borderRadius: BorderRadius.circular(AppDimens.navPillRadius),
                ),
                child: icon,
              )
            else
              SizedBox(height: AppDimens.navPillHeight, child: Center(child: icon)),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.navLabelGap),
                child: Text(tab.label, style: AppTextStyles.navLabel),
              ),
          ],
        ),
      ),
    );
  }
}
