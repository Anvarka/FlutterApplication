import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_2/main.dart';

void main() {
  testWidgets('renders dashboard and allows navigation', (WidgetTester tester) async {
    await tester.pumpWidget(const FitnessCoachApp());

    expect(find.text('Привет, Рустам 👋'), findsOneWidget);
    expect(find.text('Сегодня: Спина + Бицепс'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.restaurant_menu));
    await tester.pumpAndSettle();

    expect(find.text('Дневник питания'), findsOneWidget);
    expect(find.text('Добавить приём пищи'), findsOneWidget);
  });
}
