import 'package:flutter/widgets.dart';
import 'adaptive_breakpoint.dart';

/// An InheritedWidget that provides global breakpoint configurations to its descendants.
class AdaptiveLayoutConfig extends InheritedWidget {
  /// The breakpoint threshold for mobile devices.
  final double mobileBreakpoint;

  /// The breakpoint threshold for tablet devices.
  final double tabletBreakpoint;

  /// The breakpoint threshold for desktop devices.
  final double desktopBreakpoint;

  const AdaptiveLayoutConfig({
    super.key,
    this.mobileBreakpoint = AdaptiveBreakpoint.mobile,
    this.tabletBreakpoint = AdaptiveBreakpoint.tablet,
    this.desktopBreakpoint = AdaptiveBreakpoint.desktop,
    required super.child,
  });

  static AdaptiveLayoutConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AdaptiveLayoutConfig>();
  }

  @override
  bool updateShouldNotify(AdaptiveLayoutConfig oldWidget) {
    return oldWidget.mobileBreakpoint != mobileBreakpoint ||
        oldWidget.tabletBreakpoint != tabletBreakpoint ||
        oldWidget.desktopBreakpoint != desktopBreakpoint;
  }
}
