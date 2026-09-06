import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../core/app_dimens.dart';
import '../../../core/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/islami_header.dart';
import '../../home/widgets/scrim_backdrop.dart';
import '../widgets/sebha_beads.dart';

/// Figma `Sebha Screen` (node 51:117): a tasbeeh counter.
///
/// Each tap turns the ring by one bead and advances the count; after
/// [AppDimens.tasbeehTarget] the count restarts and the next phrase in
/// [AppStrings.tasbeehPhrases] takes over.
class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => SebhaTabState();
}

@visibleForTesting
class SebhaTabState extends State<SebhaTab> {
  int _count = 0;
  int _phraseIndex = 0;
  double _turns = 0;

  int get count => _count;
  String get phrase => AppStrings.tasbeehPhrases[_phraseIndex];

  void tally() {
    setState(() {
      _turns += AppDimens.sebhaBeadTurn;
      if (_count >= AppDimens.tasbeehTarget) {
        _count = 1;
        _phraseIndex =
            (_phraseIndex + 1) % AppStrings.tasbeehPhrases.length;
      } else {
        _count++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const ScrimBackdrop(
          image: AppAssets.sebhaBackground,
          designHeight: AppDimens.sebhaBackdropHeight,
        ),
        SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              const IslamiHeader(),
              const SizedBox(height: AppDimens.sebhaVerseGap),
              const Text(
                AppStrings.sebhaVerse,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: AppTextStyles.sebha,
              ),
              const SizedBox(height: AppDimens.sebhaVerseGap),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppDimens.sebhaBottomGap,
                  ),
                  // The beads are authored at a fixed size; scale them to
                  // whatever the header and the bottom bar leave behind so
                  // the ring is never clipped.
                  child: FittedBox(
                    child: SebhaBeads(
                      turns: _turns,
                      phrase: phrase,
                      count: _count,
                      onTap: tally,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
