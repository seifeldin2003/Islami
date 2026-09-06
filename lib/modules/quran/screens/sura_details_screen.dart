import 'package:flutter/material.dart';

import '../../../core/app_dimens.dart';
import '../../../core/app_routes.dart';
import '../../../core/data/sura_repository.dart';
import '../../../core/design_scale.dart';
import '../../../core/models/sura.dart';
import '../../../core/route_arguments.dart';
import '../../../core/widgets/detail_scaffold.dart';
import '../widgets/verse_card.dart';

/// Figma `Soura Details Screen` (node 135:29): the verses of one sura, each
/// in its own outlined card.
class SuraDetailsScreen extends StatelessWidget {
  const SuraDetailsScreen({super.key, required this.sura});

  final Sura sura;

  /// Builder for the named route; reads the [Sura] off the route settings.
  static Widget fromRoute(BuildContext context) =>
      SuraDetailsScreen(sura: context.routeArgument<Sura>());

  /// Opens the reader for [sura].
  static Future<void> open(BuildContext context, Sura sura) =>
      Navigator.of(context).pushNamed(AppRoutes.suraDetails, arguments: sura);

  @override
  Widget build(BuildContext context) {
    return DetailScaffold(
      title: sura.englishName,
      heading: sura.arabicName,
      child: FutureBuilder<List<String>>(
        future: SuraRepository.versesOf(sura),
        builder: (context, snapshot) {
          final verses = snapshot.data;
          if (verses == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            padding: EdgeInsets.only(
              left: AppDimens.verseCardGutter,
              right: AppDimens.verseCardGutter,
              bottom: context.dy(AppDimens.detailBottomDecorationHeight),
            ),
            itemCount: verses.length,
            separatorBuilder: (_, __) =>
                const SizedBox(height: AppDimens.verseCardGap),
            itemBuilder: (context, index) => VerseCard(
              number: index + 1,
              text: verses[index],
            ),
          );
        },
      ),
    );
  }
}
