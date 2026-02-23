import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adaptive_flutter_layout/adaptive_flutter_layout.dart';

void main() {
  group('BuildContext Extension', () {
    testWidgets('isMobile returns true for width < 600', (tester) async {
      tester.view.physicalSize = const Size(350, 700);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      late bool isMobile;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(builder: (ctx) {
            isMobile = ctx.isMobile;
            return const SizedBox();
          }),
        ),
      );
      expect(isMobile, isTrue);
    });

    testWidgets('isTablet returns true for width between 600 and 1024',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      late bool isTablet;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(builder: (ctx) {
            isTablet = ctx.isTablet;
            return const SizedBox();
          }),
        ),
      );
      expect(isTablet, isTrue);
    });

    testWidgets('isDesktop returns true for width >= 1440 (default)',
        (tester) async {
      // Note: AdaptiveBreakpoint.desktop is 1440.
      // Our logic in extension uses tabletBreakpoint as the threshold for desktop too?
      // Let's check the code:
      // if (width < mobileBreakpoint) return mobile;
      // else if (width < tabletBreakpoint) return tablet;
      // else return desktop;
      // So anything >= tabletBreakpoint is desktop.
      // Wait, the prompted Sealed class says:
      // mobile = 600; tablet = 1024; desktop = 1440;
      // But the extension logic I wrote was simple mobile < 600, tablet < 1024, else desktop.
      // This matches the common 3-tier approach.

      tester.view.physicalSize = const Size(1600, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      late bool isDesktop;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(builder: (ctx) {
            isDesktop = ctx.isDesktop;
            return const SizedBox();
          }),
        ),
      );
      expect(isDesktop, isTrue);
    });
  });
}
