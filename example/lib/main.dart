import 'package:flutter/material.dart';
import 'package:adaptive_flutter_layout/adaptive_flutter_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayoutConfig(
      // Optional: Custom breakpoints
      mobileBreakpoint: 600,
      tabletBreakpoint: 1024,
      desktopBreakpoint: 1440,
      child: MaterialApp(
        title: 'Adaptive Layout Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adaptive Layout Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: AdaptiveValue.of<EdgeInsets>(
          context,
          mobile: const EdgeInsets.all(16),
          tablet: const EdgeInsets.all(32),
          desktop: const EdgeInsets.all(48),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Screen: ${context.adaptiveScreenType.name.toUpperCase()}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),

            // Using AdaptiveLayout
            const Text('1. Using AdaptiveLayout Widget:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            AdaptiveLayout(
              mobile: (context) =>
                  _buildCard(context, Colors.blue, 'Mobile View'),
              tablet: (context) =>
                  _buildCard(context, Colors.green, 'Tablet View'),
              desktop: (context) =>
                  _buildCard(context, Colors.orange, 'Desktop View'),
            ),
            const SizedBox(height: 30),

            // Using AdaptiveBuilder
            const Text('2. Using AdaptiveBuilder:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            AdaptiveBuilder(
              builder: (context, screenType) {
                return _buildCard(
                  context,
                  Colors.purple,
                  'AdaptiveBuilder: ${screenType.name}',
                );
              },
            ),
            const SizedBox(height: 30),

            // Using BuildContext Extensions
            const Text('3. Using BuildContext Extensions:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[200],
              child: Column(
                children: [
                  _buildStatusRow('isMobile', context.isMobile),
                  _buildStatusRow('isTablet', context.isTablet),
                  _buildStatusRow('isDesktop', context.isDesktop),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, Color color, String text) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: color.withAlpha(51), // 20% opacity (0.2 * 255 ≈ 51)
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 2),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Icon(
            value ? Icons.check_circle : Icons.cancel,
            color: value ? Colors.green : Colors.red,
          ),
        ],
      ),
    );
  }
}
