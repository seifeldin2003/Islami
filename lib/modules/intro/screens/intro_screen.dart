import 'package:flutter/material.dart';

import '../../../core/app_dimens.dart';
import '../../../core/app_durations.dart';
import '../../../core/app_routes.dart';
import '../../../core/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/islami_header.dart';
import '../widgets/onboarding_progress_dots.dart';
import 'intro_page_data.dart';

/// The five onboarding slides from the Figma `Intro Screen` flow.
class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  bool get _isFirst => _index == 0;
  bool get _isLast => _index == introPages.length - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_isLast) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      return;
    }
    _controller.nextPage(
      duration: AppDurations.pageTransition,
      curve: Curves.easeOut,
    );
  }

  void _back() {
    _controller.previousPage(
      duration: AppDurations.pageTransition,
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.screenPadding),
          child: Column(
            children: [
              const IslamiHeader(),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: introPages.length,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (context, i) => _IntroSlide(data: introPages[i]),
                ),
              ),
              _BottomBar(
                index: _index,
                showBack: !_isFirst,
                nextLabel: _isLast ? AppStrings.finish : AppStrings.next,
                onBack: _back,
                onNext: _next,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IntroSlide extends StatelessWidget {
  const _IntroSlide({required this.data});

  final IntroPageData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child: Center(child: Image.asset(data.illustration))),
        Text(
          data.title,
          textAlign: TextAlign.center,
          style: AppTextStyles.title,
        ),
        if (data.body != null) ...[
          const SizedBox(height: AppDimens.introTitleGap),
          Text(
            data.body!,
            textAlign: TextAlign.center,
            style: AppTextStyles.body,
          ),
        ],
        const SizedBox(height: AppDimens.introSlideBottomGap),
      ],
    );
  }
}

/// Figma `Frame 4`: Back on the left, the progress pill centred, and
/// Next / Finish on the right.
class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.index,
    required this.showBack,
    required this.nextLabel,
    required this.onBack,
    required this.onNext,
  });

  final int index;
  final bool showBack;
  final String nextLabel;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: AppDimens.introNavButtonWidth,
          child: showBack
              ? GestureDetector(
                  onTap: onBack,
                  child: const Text(
                    AppStrings.back,
                    style: AppTextStyles.button,
                  ),
                )
              : null,
        ),
        Expanded(
          child: Center(
            child: OnboardingProgressDots(
              count: introPages.length,
              currentIndex: index,
            ),
          ),
        ),
        SizedBox(
          width: AppDimens.introNavButtonWidth,
          child: GestureDetector(
            onTap: onNext,
            child: Text(
              nextLabel,
              textAlign: TextAlign.right,
              style: AppTextStyles.button,
            ),
          ),
        ),
      ],
    );
  }
}
