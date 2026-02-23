# adaptive_flutter_layout

[![pub package](https://img.shields.io/pub/v/adaptive_flutter_layout.svg)](https://pub.dev/packages/adaptive_flutter_layout)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.10.0-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-%3E%3D3.0.0-blue.svg)](https://dart.dev)

A production-ready Flutter package that automatically adapts widget layouts across mobile, tablet, and desktop breakpoints using a clean, declarative API.

## Overview

Building responsive Flutter apps often involves repetitive `MediaQuery` checks and complex conditional logic. `adaptive_flutter_layout` simplifies this process by providing a set of widgets and utilities that handle breakpoint detection and layout switching automatically.

## Features

*   🚀 **Declarative Layouts**: Switch between mobile, tablet, and desktop views easily.
*   📱 **Built-in Breakpoints**: Intelligent defaults for standard device sizes.
*   ⚙️ **Customizable**: Set your own global breakpoints via `AdaptiveLayoutConfig`.
*   🛠️ **Utility Extensions**: Get screen type information directly from `BuildContext`.
*   📦 **AdaptiveValue**: Resolve non-widget values (like padding or colors) based on screen size.

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  adaptive_flutter_layout: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

```dart
import 'package:adaptive_flutter_layout/adaptive_flutter_layout.dart';

// ... inside your build method
AdaptiveLayout(
  mobile: (context) => MobileView(),
  tablet: (context) => TabletView(),
  desktop: (context) => DesktopView(),
  fallback: (context) => MobileView(),
)
```

## Usage

### AdaptiveLayout Widget

The primary widget for switching between different views based on the screen width.

```dart
AdaptiveLayout(
  mobile: (context) => const Center(child: Text('Mobile')),
  tablet: (context) => const Center(child: Text('Tablet')),
  desktop: (context) => const Center(child: Text('Desktop')),
)
```

### AdaptiveBuilder

A builder that exposes the current `AdaptiveScreenType` enum for more granular control.

```dart
AdaptiveBuilder(
  builder: (context, screenType) {
    return switch (screenType) {
      AdaptiveScreenType.mobile => MobileContent(),
      AdaptiveScreenType.tablet => TabletContent(),
      AdaptiveScreenType.desktop => DesktopContent(),
    };
  },
)
```

### AdaptiveValue<T>

A utility for resolving values without adding widgets to the tree.

```dart
final padding = AdaptiveValue.of<EdgeInsets>(
  context,
  mobile: EdgeInsets.all(8),
  tablet: EdgeInsets.all(16),
  desktop: EdgeInsets.all(24),
);
```

### BuildContext Extensions

Easily check the current screen type anywhere you have a `BuildContext`.

```dart
final type = context.adaptiveScreenType;
final isMobile = context.isMobile;
final isTablet = context.isTablet;
final isDesktop = context.isDesktop;
```

### Custom Breakpoints via AdaptiveLayoutConfig

Wrap your app root to set global breakpoint thresholds.

```dart
AdaptiveLayoutConfig(
  mobileBreakpoint: 600,
  tabletBreakpoint: 1024,
  desktopBreakpoint: 1440,
  child: MyApp(),
)
```

## API Reference

| Class | Constructor | Parameters |
|-------|-------------|------------|
| `AdaptiveLayout` | `AdaptiveLayout(...)` | `mobile`, `tablet`, `desktop`, `fallback` (all `WidgetBuilder?`) |
| `AdaptiveBuilder` | `AdaptiveBuilder(...)` | `builder` (`Widget Function(BuildContext, AdaptiveScreenType)`) |
| `AdaptiveValue` | `AdaptiveValue.of(...)` | `context`, `mobile`, `tablet`, `desktop`, `fallback` (types `T?`) |
| `AdaptiveLayoutConfig` | `AdaptiveLayoutConfig(...)` | `mobileBreakpoint`, `tabletBreakpoint`, `desktopBreakpoint`, `child` |

## Testing

You can easily test your adaptive layouts by setting the physical size in your widget tests:

```dart
testWidgets('renders mobile widget', (tester) async {
  tester.view.physicalSize = const Size(400, 800);
  tester.view.devicePixelRatio = 1.0;
  await tester.pumpWidget(MyApp());
  expect(find.text('mobile'), findsOneWidget);
});
```

To run all package tests:
```bash
flutter test
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License

Copyright (c) 2025 George Ikwegbu

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

## Author

**George Ikwegbu** (2025)
