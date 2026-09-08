import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_assets.dart';
import '../../../core/data/hadith_repository.dart';
import '../../../core/models/hadith.dart';
import '../../../core/widgets/islami_header.dart';
import '../../home/widgets/scrim_backdrop.dart';
import '../widgets/hadith_card.dart';

/// Page extent as a fraction of the canvas: one 319pt slot on a 430pt
/// artboard. A fraction, so it is not scaled.
const double _kCardViewport = 319 / 430;

/// Neighbouring cards render at 293/313 of the active card.
const double _kSideScale = 293 / 313;

/// The fifty hadiths as a paged carousel, the neighbouring cards peeking
/// in at a slightly smaller scale.
class HadethTab extends StatefulWidget {
  const HadethTab({super.key, required this.onHadithSelected});

  final ValueChanged<Hadith> onHadithSelected;

  @override
  State<HadethTab> createState() => _HadethTabState();
}

class _HadethTabState extends State<HadethTab> {
  final PageController _controller = PageController(
    viewportFraction: _kCardViewport,
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
        ScrimBackdrop(
          image: AppAssets.hadethBackground,
          designHeight: 567.h,
        ),
        SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              const IslamiHeader(),
              SizedBox(height: 13.h),
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
            height: 618.h,
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
                    _kSideScale,
                    distance,
                  )!;
                  return Transform.scale(scale: scale, child: child);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
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
