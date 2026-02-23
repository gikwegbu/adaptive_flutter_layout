import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adaptive_flutter_layout/adaptive_flutter_layout.dart';

void main() {
  group('AdaptiveLayout', () {
    testWidgets('renders mobile widget when width < 600', (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: AdaptiveLayout(
            mobile: (_) => const Text('mobile'),
            tablet: (_) => const Text('tablet'),
            desktop: (_) => const Text('desktop'),
          ),
        ),
      );
      expect(find.text('mobile'), findsOneWidget);
      expect(find.text('tablet'), findsNothing);
      expect(find.text('desktop'), findsNothing);
    });

    testWidgets('renders tablet widget when width is between 600 and 1024',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: AdaptiveLayout(
            mobile: (_) => const Text('mobile'),
            tablet: (_) => const Text('tablet'),
            desktop: (_) => const Text('desktop'),
          ),
        ),
      );
      expect(find.text('tablet'), findsOneWidget);
      expect(find.text('mobile'), findsNothing);
    });

    testWidgets('renders desktop widget when width >= 1024', (tester) async {
      tester.view.physicalSize = const Size(1200, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: AdaptiveLayout(
            mobile: (_) => const Text('mobile'),
            tablet: (_) => const Text('tablet'),
            desktop: (_) => const Text('desktop'),
          ),
        ),
      );
      expect(find.text('desktop'), findsOneWidget);
    });

    testWidgets('renders fallback when no matching builder', (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: AdaptiveLayout(
            tablet: (_) => const Text('tablet'),
            fallback: (_) => const Text('fallback'),
          ),
        ),
      );
      expect(find.text('fallback'), findsOneWidget);
    });
  });
}
