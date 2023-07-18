import 'package:flutter_test/flutter_test.dart';
import 'package:map_app/app/app.dart';
import 'package:map_app/map/map.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(MapPage), findsOneWidget);
    });
  });
}
