import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vitalink_africa/app.dart';
import 'package:vitalink_africa/providers/app_providers.dart';

void main() {
  testWidgets('VitaLink app smoke test', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const VitaLinkApp(),
      ),
    );

    expect(find.text('VitaLink Africa'), findsOneWidget);
  });
}
