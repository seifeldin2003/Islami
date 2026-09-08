import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_routes.dart';
import '../../../core/data/azkar_repository.dart';
import '../../../core/models/azkar_category.dart';
import '../../../core/models/zikr.dart';
import '../../../core/route_arguments.dart';
import '../../../core/widgets/detail_scaffold.dart';
import '../../quran/widgets/verse_card.dart';

/// The azkar of one collection, on the shared detail chrome.
///
/// The design stops at the azkar cards, so this screen reuses the sura /
/// hadith reader layout.
class AzkarDetailsScreen extends StatelessWidget {
  const AzkarDetailsScreen({super.key, required this.category});

  final AzkarCategory category;

  static Widget fromRoute(BuildContext context) =>
      AzkarDetailsScreen(category: context.routeArgument<AzkarCategory>());

  static Future<void> open(BuildContext context, AzkarCategory category) =>
      Navigator.of(context)
          .pushNamed(AppRoutes.azkarDetails, arguments: category);

  @override
  Widget build(BuildContext context) {
    return DetailScaffold(
      title: category.title,
      heading: category.jsonKey,
      child: FutureBuilder<List<Zikr>>(
        future: AzkarRepository.of(category),
        builder: (context, snapshot) {
          final azkar = snapshot.data;
          if (azkar == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            padding: EdgeInsets.only(
              left: 18.w,
              right: 18.w,
              bottom: 112.h,
            ),
            itemCount: azkar.length,
            separatorBuilder: (_, __) => SizedBox(height: 8.h),
            itemBuilder: (context, index) => VerseCard(
              number: index + 1,
              text: azkar[index].content,
            ),
          );
        },
      ),
    );
  }
}
