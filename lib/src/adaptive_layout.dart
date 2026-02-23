import 'package:flutter/widgets.dart';
import 'adaptive_screen_type.dart';
import 'extensions/build_context_extension.dart';

/// A widget that builds different UI based on the screen size.
class AdaptiveLayout extends StatelessWidget {
  /// Builder for mobile devices.
  final WidgetBuilder? mobile;

  /// Builder for tablet devices.
  final WidgetBuilder? tablet;

  /// Builder for desktop devices.
  final WidgetBuilder? desktop;

  /// Fallback builder if no matching builder is found.
  final WidgetBuilder? fallback;

  const AdaptiveLayout({
    super.key,
    this.mobile,
    this.tablet,
    this.desktop,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    final screenType = context.adaptiveScreenType;

    switch (screenType) {
      case AdaptiveScreenType.mobile:
        if (mobile != null) return mobile!(context);
        break;
      case AdaptiveScreenType.tablet:
        if (tablet != null) return tablet!(context);
        break;
      case AdaptiveScreenType.desktop:
        if (desktop != null) return desktop!(context);
        break;
    }

    // If specific builder is missing, use fallback if provided,
    // otherwise try other builders as a last resort.
    final result = fallback ?? mobile ?? tablet ?? desktop;

    if (result != null) {
      return result(context);
    }

    throw FlutterError(
      'AdaptiveLayout could not find a builder for screen type $screenType '
      'and no fallback was provided.',
    );
  }
}
