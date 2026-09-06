import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../core/app_dimens.dart';
import '../../../core/data/hadith_repository.dart';
import '../../../core/design_scale.dart';
import '../../../core/models/hadith.dart';
import '../../../core/widgets/islami_header.dart';
import '../../home/widgets/scrim_backdrop.dart';
import '../widgets/hadith_card.dart';

/// Figma `Hadeth Screen` (node 40:12): the fifty hadiths as a paged
/// carousel, the neighbouring cards peeking in at a slightly smaller scale.
class HadethTab extends StatefulWidget {
  const HadethTab({super.key, required this.onHadithSelected});

  final ValueChanged<Hadith> onHadithSelected;

  @override
  State<HadethTab> createState() => _HadethTabState();
}

class _HadethTabState extends State<HadethTab> {
  final PageController _controller = PageController(
    viewportFraction: AppDimens.hadithCardViewport,
  );

  /// Held in the state: building the future inside `build` would hand the
  /// `FutureBuilder` a new future on every rebuild and flash the spinner.
  late final Future<List<Hadith>> _hadiths = HadithRepository.all();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const ScrimBackdrop(
          image: AppAssets.hadethBackground,
          designHeight: AppDimens.hadethBackdropHeight,
        ),
        SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              const IslamiHeader(),
              const SizedBox(height: AppDimens.hadethHeaderGap),
              Expanded(
                child: _Carousel(
                  controller: _controller,
                  hadiths: _hadiths,
                  onSelected: widget.onHadithSelected,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Carousel extends StatelessWidget {
  const _Carousel({
    required this.controller,
    required this.hadiths,
    required this.onSelected,
  });

  final PageController controller;
  final Future<List<Hadith>> hadiths;
  final ValueChanged<Hadith> onSelected;

  /// Current scroll offset in pages. Read inside the `AnimatedBuilder` so
  /// the scale tracks the drag; reading it in the parent's `build` would
  /// freeze it at its first value.
  double _pageOf(PageController controller) {
    if (controller.hasClients && controller.position.hasContentDimensions) {
      return controller.page ?? controller.initialPage.toDouble();
    }
    return controller.initialPage.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Hadith>>(
      future: hadiths,
      builder: (context, snapshot) {
        final hadiths = snapshot.data;
        if (hadiths == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(
          child: SizedBox(
            height: context.dy(AppDimens.hadithCardHeight),
            child: PageView.builder(
              controller: controller,
              itemCount: hadiths.length,
              itemBuilder: (context, index) => AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  final distance =
                      (_pageOf(controller) - index).abs().clamp(0.0, 1.0);
                  final scale = lerpDouble(
                    1,
                    AppDimens.hadithCardSideScale,
                    distance,
                  )!;
                  return Transform.scale(scale: scale, child: child);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.hadithCardGap,
                  ),
                  child: HadithCard(
                    hadith: hadiths[index],
                    onTap: () => onSelected(hadiths[index]),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
