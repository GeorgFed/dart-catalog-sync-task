import 'package:dart_catalog_sync_task/catalog.dart';

void main() {
  const previous = [
    Product(id: 'coffee', name: 'Кофе', priceRubles: 159),
    Product(id: 'tea', name: 'Чай', priceRubles: 99),
  ];
  const current = [
    Product(id: 'coffee', name: 'Кофе', priceRubles: 179),
    Product(id: 'water', name: 'Вода', priceRubles: 50),
  ];

  CatalogComparator comparator = DefaultCatalogComparator();
  final logs = <String>[];

  try {
    final changedIds = comparator.findChangedIds(
      previous,
      current,
      log: logs.add,
    );
    print('Изменившиеся товары: ${changedIds.toList()..sort()}');
    for (final message in logs) {
      print('LOG: $message');
    }
  } on FormatException catch (error) {
    print('Не удалось сравнить каталоги: $error');
  }
}
