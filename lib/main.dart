import 'package:flutter/material.dart';

void main() {
  runApp(const AugmentedKeysApp());
}

class AugmentedKeysApp extends StatelessWidget {
  const AugmentedKeysApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AugmentedKeys',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7BC8A4),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const M0FoundationScreen(),
    );
  }
}

class M0FoundationScreen extends StatelessWidget {
  const M0FoundationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Semantics(
                    header: true,
                    child: Text(
                      'AugmentedKeys',
                      textAlign: TextAlign.center,
                      style: textTheme.displaySmall,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'M0 — Research & Architecture',
                    textAlign: TextAlign.center,
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Audio and MIDI features are not implemented.',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Designed for Android and Apple phones and tablets.',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
