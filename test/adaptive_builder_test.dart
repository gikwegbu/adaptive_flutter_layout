import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adaptive_flutter_layout/adaptive_flutter_layout.dart';

void main() {
  group('AdaptiveBuilder', () {
    testWidgets('exposes correct screen type for mobile', (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      late AdaptiveScreenType type;
      await tester.pumpWidget(
        MaterialApp(
          home: AdaptiveBuilder(
            builder: (context, screenType) {
              type = screenType;
              return const SizedBox();
            },
          ),
        ),
      );
      expect(type, AdaptiveScreenType.mobile);
    });

    testWidgets('exposes correct screen type for tablet', (tester) async {
      tester.view.physicalSize = const Size(800, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      late AdaptiveScreenType type;
      await tester.pumpWidget(
        MaterialApp(
          home: AdaptiveBuilder(
            builder: (context, screenType) {
              type = screenType;
              return const SizedBox();
            },
          ),
        ),
      );
      expect(type, AdaptiveScreenType.tablet);
    });
  });
}
