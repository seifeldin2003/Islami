import 'package:flutter/material.dart';

import '../../../core/app_dimens.dart';
import '../../../core/app_routes.dart';
import '../../../core/app_strings.dart';
import '../../../core/design_scale.dart';
import '../../../core/models/hadith.dart';
import '../../../core/route_arguments.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/detail_scaffold.dart';

/// Figma `Soura Details Screen` with hadith copy (node 138:18): the full
/// text of one hadith on the shared detail chrome.
class HadithDetailsScreen extends StatelessWidget {
  const HadithDetailsScreen({super.key, required this.hadith});

  final Hadith hadith;

  /// Builder for the named route; reads the [Hadith] off the route settings.
  static Widget fromRoute(BuildContext context) =>
      HadithDetailsScreen(hadith: context.routeArgument<Hadith>());

  /// Opens the reader for [hadith].
  static Future<void> open(BuildContext context, Hadith hadith) =>
      Navigator.of(context)
          .pushNamed(AppRoutes.hadithDetails, arguments: hadith);

  @override
  Widget build(BuildContext context) {
    return DetailScaffold(
      title: AppStrings.hadithNumber(hadith.number),
      heading: hadith.title,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: AppDimens.hadithDetailGutter,
          right: AppDimens.hadithDetailGutter,
          bottom: context.dy(AppDimens.detailBottomDecorationHeight),
        ),
        child: Text(
          hadith.body,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: AppTextStyles.hadithBody,
        ),
      ),
    );
  }
}
