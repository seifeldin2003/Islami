import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:islami/main.dart' show kDesignSize;

/// Wraps a widget under test the way `IslamiApp` wraps the real app.
///
/// ScreenUtil's `.w` / `.h` / `.sp` only resolve once `ScreenUtilInit` has
/// laid out, so every widget test has to sit inside one.
Widget scaled(Widget app) =>
    ScreenUtilInit(designSize: kDesignSize, child: app);

/// Pumps [app] and settles the extra frame `ScreenUtilInit` needs before it
/// builds its child.
Future<void> pumpScaled(WidgetTester tester, Widget app) async {
  await tester.pumpWidget(scaled(app));
  await tester.pump();
}

/// Sizes the test surface to the design artboard so lazily built lists and
/// carousels lay out the way they do on a phone.
void useDesignSurface(WidgetTester tester, {Size size = kDesignSize}) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}
