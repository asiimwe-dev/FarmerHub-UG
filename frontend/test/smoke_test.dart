import 'package:farmer_hub_ug/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('app boots', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: FarmerHubApp()));
    await tester.pumpAndSettle();

    expect(find.text('Farmer Hub UG'), findsOneWidget);
  });
}
