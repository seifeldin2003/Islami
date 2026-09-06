import 'package:flutter_test/flutter_test.dart';

import 'package:islami/core/app_durations.dart';
import 'package:islami/core/app_strings.dart';
import 'package:islami/main.dart';
import 'package:islami/modules/home/screens/home_screen.dart';
import 'package:islami/modules/intro/screens/intro_screen.dart';
import 'package:islami/modules/splash/screens/splash_screen.dart';

/// Boots the app and lets the splash timer hand over to the intro flow.
Future<void> _pumpIntro(WidgetTester tester) async {
  await tester.pumpWidget(const IslamiApp());
  await tester.pump(AppDurations.splash);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('the app opens on the splash screen', (tester) async {
    await tester.pumpWidget(const IslamiApp());

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text(AppStrings.supervisedBy), findsOneWidget);
  });

  testWidgets('the splash hands over to the intro flow', (tester) async {
    await _pumpIntro(tester);

    expect(find.byType(IntroScreen), findsOneWidget);
    expect(find.byType(SplashScreen), findsNothing);
  });

  testWidgets('the intro flow moves through the slides', (tester) async {
    await _pumpIntro(tester);

    // First slide: shows Next, no Back.
    expect(find.text(AppStrings.slide1Title), findsOneWidget);
    expect(find.text(AppStrings.next), findsOneWidget);
    expect(find.text(AppStrings.back), findsNothing);

    // Advance to the second slide.
    await tester.tap(find.text(AppStrings.next));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.slide2Title), findsOneWidget);
    expect(find.text(AppStrings.back), findsOneWidget);

    // And back again.
    await tester.tap(find.text(AppStrings.back));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.slide1Title), findsOneWidget);
    expect(find.text(AppStrings.back), findsNothing);
  });

  testWidgets('the last slide shows Finish and opens the home screen',
      (tester) async {
    await _pumpIntro(tester);

    for (var i = 0; i < 4; i++) {
      await tester.tap(find.text(AppStrings.next));
      await tester.pumpAndSettle();
    }

    expect(find.text(AppStrings.slide5Title), findsOneWidget);
    expect(find.text(AppStrings.finish), findsOneWidget);

    await tester.tap(find.text(AppStrings.finish));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byType(IntroScreen), findsNothing);
  });
}
