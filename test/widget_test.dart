import 'package:augmented_keys/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the truthful M0 foundation status', (tester) async {
    await tester.pumpWidget(const AugmentedKeysApp());

    expect(find.text('AugmentedKeys'), findsOneWidget);
    expect(find.text('M0 — Research & Architecture'), findsOneWidget);
    expect(
      find.text('Audio and MIDI features are not implemented.'),
      findsOneWidget,
    );
    expect(
      find.text('Designed for Android and Apple phones and tablets.'),
      findsOneWidget,
    );
    expect(find.textContaining('performance-ready'), findsNothing);
  });
}
