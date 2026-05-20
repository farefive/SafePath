import 'package:flutter_test/flutter_test.dart';
import 'package:safepath/main.dart';

void main() {
  testWidgets('Safe Path App home screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SafePathApp());

    // Verify that the title of the app bar is displayed in Arabic
    expect(find.text('طريقك آمن 🕋'), findsOneWidget);

    // Verify that the main categories are present
    expect(find.text('أرقام الطوارئ 🚑'), findsOneWidget);
    expect(find.text('الوقاية الصحية 💧'), findsOneWidget);
    expect(find.text('إرشادات الزحام 🚶‍♂️'), findsOneWidget);
    expect(find.text('الدليل المكاني 📍'), findsOneWidget);
    expect(find.text('تقييم الخدمة والاستبيان ⭐'), findsOneWidget);
  });
}
