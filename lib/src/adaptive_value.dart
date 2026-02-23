import 'package:flutter/widgets.dart';
import 'extensions/build_context_extension.dart';
import 'adaptive_screen_type.dart';

/// A utility class for resolving values based on the current [AdaptiveScreenType].
class AdaptiveValue<T> {
  /// Resolves a value of type [T] based on the current screen type.
  ///
  /// The [mobile], [tablet], and [desktop] parameters provide values for their
  /// respective screen types. If a value is not provided for a specific screen
  /// type, it will fall back to the available values in the following order:
  /// mobile -> tablet -> desktop (or vice versa depending on common patterns,
  /// but here we'll prioritize providing explicit values or a sensible fallback).
  static T of<T>(
    BuildContext context, {
    T? mobile,
    T? tablet,
    T? desktop,
    T? fallback,
  }) {
    final screenType = context.adaptiveScreenType;

    switch (screenType) {
      case AdaptiveScreenType.mobile:
        return mobile ?? tablet ?? desktop ?? fallback as T;
      case AdaptiveScreenType.tablet:
        return tablet ?? mobile ?? desktop ?? fallback as T;
      case AdaptiveScreenType.desktop:
        return desktop ?? tablet ?? mobile ?? fallback as T;
    }
  }
}
