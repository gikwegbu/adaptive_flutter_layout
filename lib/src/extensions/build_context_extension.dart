import 'package:flutter/widgets.dart';
import '../adaptive_screen_type.dart';
import '../adaptive_layout_config.dart';
import '../adaptive_breakpoint.dart';

/// Extension on [BuildContext] to provide easy access to adaptive layout information.
extension BuildContextAdaptiveExtension on BuildContext {
  /// Returns the width of the current screen.
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Returns the [AdaptiveScreenType] for the current [BuildContext].
  AdaptiveScreenType get adaptiveScreenType {
    final config = AdaptiveLayoutConfig.of(this);
    final width = screenWidth;

    final mobileBreakpoint =
        config?.mobileBreakpoint ?? AdaptiveBreakpoint.mobile;
    final tabletBreakpoint =
        config?.tabletBreakpoint ?? AdaptiveBreakpoint.tablet;

    if (width < mobileBreakpoint) {
      return AdaptiveScreenType.mobile;
    } else if (width < tabletBreakpoint) {
      return AdaptiveScreenType.tablet;
    } else {
      return AdaptiveScreenType.desktop;
    }
  }

  /// Returns true if the screen type is [AdaptiveScreenType.mobile].
  bool get isMobile => adaptiveScreenType == AdaptiveScreenType.mobile;

  /// Returns true if the screen type is [AdaptiveScreenType.tablet].
  bool get isTablet => adaptiveScreenType == AdaptiveScreenType.tablet;

  /// Returns true if the screen type is [AdaptiveScreenType.desktop].
  bool get isDesktop => adaptiveScreenType == AdaptiveScreenType.desktop;
}
