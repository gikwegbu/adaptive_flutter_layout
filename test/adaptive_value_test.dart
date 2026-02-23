import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adaptive_flutter_layout/adaptive_flutter_layout.dart';

void main() {
  group('AdaptiveValue', () {
    testWidgets('returns mobile value for small screen', (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      late EdgeInsets result;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(builder: (context) {
            result = AdaptiveValue.of<EdgeInsets>(
              context,
              mobile: const EdgeInsets.all(8),
              tablet: const EdgeInsets.all(16),
              desktop: const EdgeInsets.all(24),
            );
            return const SizedBox();
          }),
        ),
      );
      expect(result, const EdgeInsets.all(8));
    });

    testWidgets('returns tablet value for medium screen', (tester) async {
      tester.view.physicalSize = const Size(800, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      late EdgeInsets result;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(builder: (context) {
            result = AdaptiveValue.of<EdgeInsets>(
              context,
              mobile: const EdgeInsets.all(8),
              tablet: const EdgeInsets.all(16),
              desktop: const EdgeInsets.all(24),
            );
            return const SizedBox();
          }),
        ),
      );
      expect(result, const EdgeInsets.all(16));
    });

    testWidgets('respects custom breakpoints from AdaptiveLayoutConfig',
        (tester) async {
      tester.view.physicalSize = const Size(500, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      late AdaptiveScreenType type;
      await tester.pumpWidget(
        MaterialApp(
          home: AdaptiveLayoutConfig(
            mobileBreakpoint: 400, // Custom mobile breakpoint
            child: Builder(builder: (context) {
              type = context.adaptiveScreenType;
              return const SizedBox();
            }),
          ),
        ),
      );
      // Since width is 500 and mobileBreakpoint is 400, it should be tablet (or desktop depending on tabletBreakpoint)
      expect(type, isNot(AdaptiveScreenType.mobile));
    });
  });
}
