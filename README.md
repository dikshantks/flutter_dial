# flutter_dial

A customizable rotary dial input widget for Flutter, allowing users to select numbers by rotating a dial. The package provides a configurable interface with animation support for mode changes.

## Features

-   Customizable rotary dial with configurable properties such as padding, width, colors, and more.
-   Animated transitions for background and foreground elements.
-   Easy integration with other widgets through a `DialConfigProvider`.
-   Supports gesture detection for rotating the dial and selecting numbers.

## Getting Started

### Prerequisites

-   Flutter SDK
-   Dart SDK

### Installation

Add `flutter_dial` to your `pubspec.yaml`:

```yaml
dependencies:
    flutter_dial:
        git:
            url: git://github.com/yourusername/flutter_dial.git
            ref: main
```

Run `flutter pub get` to install the package.

## Usage

### Basic Usage

Here is a simple example of how to use the `RotationDialInput` widget in your Flutter application:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_dial/flutter_dial.dart';
import 'dart:math' show pi;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Dial Example'),
        ),
        body: const Center(
          child: DialExample(),
        ),
      ),
    );
  }
}

class DialExample extends StatefulWidget {
  const DialExample({super.key});

  @override
  _DialExampleState createState() => _DialExampleState();
}

class _DialExampleState extends State<DialExample>
    with SingleTickerProviderStateMixin {
  late final AnimationController modeChangeController;
  bool isAnimating = false;

  @override
  void initState() {
    super.initState();
    modeChangeController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    modeChangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int num = 0;

    return RotationDialInput(
      textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),
      passcodeAnimationInProgress: isAnimating,
      animationDuration: const Duration(seconds: 1),
      onNumSelected: (currentnum) {
        num = num * 10 + currentnum;
        print("Selected number: $currentnum, total: $num");
      },
    );
  }
}
```

## Additional Information

### Configuration

You can configure various properties of the `RotationDialInput` widget to suit your needs:

```dart
RotationDialInput(
  inputNumbers: [1, 2, 3, 4, 5, 6, 7, 8, 9, 0],
  ringPadding: 4.0,
  ringWidth: 70.0,
  singleNumberPadding: 8.0,
  firstNumPosition: pi / 3,
  maxRingAngle: pi * 7 / 4,
  maxSweepAngle: pi / 2 * 3,
  textStyle: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 20.0,
  ),
  backgroundColor: Colors.black,
  foregroundColor: Colors.white,
  numberBackgroundColor: Colors.black,
  boxSize: 400.0,
  singleNumberRadius: 20,
);
```

### Contributing

We welcome contributions! If you find a bug or have a feature request, please open an issue on our [GitHub repository](https://github.com/Dikshantks/flutter_dial). Feel free to submit pull requests as well.

### License

This project is licensed under the MIT License. See the LICENSE file for details.

For more information, visit our [GitHub repository](https://github.com/dikshantks/flutter_dial).

### Maintainers

-   [Dikshant](https://github.com/dikshantks)

Thank you for using `flutter_dial`! If you have any questions, feel free to reach out.
