import 'package:flutter/widgets.dart';
import 'adaptive_screen_type.dart';
import 'extensions/build_context_extension.dart';

/// A widget builder that exposes the current [AdaptiveScreenType].
class AdaptiveBuilder extends StatelessWidget {
  /// The builder function that receives the [BuildContext] and the current [AdaptiveScreenType].
  final Widget Function(BuildContext context, AdaptiveScreenType screenType)
  builder;

  const AdaptiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return builder(context, context.adaptiveScreenType);
  }
}
