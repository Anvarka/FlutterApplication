import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_2/main.dart';

void main() {
  testWidgets('renders fitness home dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const FitnessFuelApp());

    expect(find.text('Привет, чемпион! 👋'), findsOneWidget);
    expect(find.text('Сегодня: Верх тела'), findsOneWidget);
    expect(find.text('Питание на сегодня'), findsOneWidget);
  });
}
