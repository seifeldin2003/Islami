import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_assets.dart';
import '../../../core/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/islami_header.dart';
import '../../home/widgets/scrim_backdrop.dart';
import '../widgets/sebha_beads.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  /// A full round of tasbeeh.
  static const int tasbeehTarget = 33;

  /// One bead of the 33-bead ring, in turns.
  static const double beadTurn = 1 / tasbeehTarget;

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
      _turns += SebhaTab.beadTurn;
      if (_count >= SebhaTab.tasbeehTarget) {
        _count = 1;
        _phraseIndex = (_phraseIndex + 1) % AppStrings.tasbeehPhrases.length;
      } else {
        _count++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          ScrimBackdrop(
            image: AppAssets.sebhaBackground,
            designHeight: 852.h,
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: <Widget>[
                const IslamiHeader(),
                SizedBox(height: 16.h),
                Text(
                  AppStrings.sebhaVerse,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.sebha,
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    // `scaleDown` rather than `contain`: the beads keep their
                    // authored proportions and only shrink when the header and
                    // the bottom bar leave too little room.
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
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
      ),
    );
  }
}
