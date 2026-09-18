import 'package:collection/collection.dart';

/*
Продуктовый контекст

Приложение хранит локальный список товаров и получает его новую версию
с бэкенда. Чтобы не обновлять все карточки, нужно определить товары,
которые добавились, исчезли или изменились.

Задача

Сделать так, чтобы товары с одинаковыми данными считались равными, сравнить
две версии списка и вернуть множество id, требующих обновления.
Некорректные данные должны давать понятную ошибку, а важные этапы — оставлять
короткие сообщения в логе.
*/

typedef LogSink = void Function(String message);

final class Product {
  static const tagsEquality = ListEquality<String>();

  final String id;
  final String name;
  final int priceRubles;
  final String? category;
  final List<String> tags;

  const Product({
    required this.id,
    required this.name,
    required this.priceRubles,
    this.category,
    this.tags = const [],
  })  : assert(id != ''),
        assert(name != ''),
        assert(priceRubles >= 0);

  @override
  bool operator ==(Object other) {
    // TODO 1: товары с одинаковыми данными должны считаться равными.
    return identical(this, other);
  }

  @override
  int get hashCode {
    // TODO 1: соблюдите контракт между равенством объектов и hashCode.
    return identityHashCode(this);
  }
}

/// Операции для сравнения двух версий списка товаров.
///
/// Рекомендуемый порядок реализации:
/// 1. Завершить `Product.operator ==` и `Product.hashCode`.
/// 2. Реализовать [sameProductList].
/// 3. Реализовать [indexById].
/// 4. Реализовать [findChangedIds].
abstract interface class ProductCartManager {
  /// Проверяет, представляют ли два списка один и тот же набор данных
  /// в одинаковом порядке.
  bool sameProductList(List<Product> left, List<Product> right);

  /// Подготавливает товары для поиска по id.
  ///
  /// Повторяющийся id считается ошибкой входных данных. Операция оставляет
  /// короткий лог и возвращает результат, который нельзя изменить снаружи.
  Map<String, Product> indexById(
    List<Product> products, {
    LogSink? log,
  });

  /// Возвращает id товаров, которые добавились, исчезли или изменились.
  ///
  /// Входные списки должны остаться без изменений. Итоговое число изменений
  /// записывается в лог.
  Set<String> findChangedIds(
    List<Product> previous,
    List<Product> current, {
    LogSink? log,
  });
}

final class DefaultProductCartManager implements ProductCartManager {
  @override
  bool sameProductList(List<Product> left, List<Product> right) {
    // TODO 2: реализуйте поведение, описанное в интерфейсе.
    return identical(left, right);
  }

  @override
  Map<String, Product> indexById(
    List<Product> products, {
    LogSink? log,
  }) {
    // TODO 3: реализуйте поведение, описанное в интерфейсе.
    throw UnimplementedError();
  }

  @override
  Set<String> findChangedIds(
    List<Product> previous,
    List<Product> current, {
    LogSink? log,
  }) {
    // TODO 4: реализуйте поведение, описанное в интерфейсе.
    throw UnimplementedError();
  }
}

// -----------------------------------------------------------------------------
// Готовый пример запуска. Код ниже менять не требуется.
// После реализации он печатает: [coffee, tea, water] и три сообщения LOG.
// -----------------------------------------------------------------------------

void main() {
  const previous = [
    Product(id: 'coffee', name: 'Кофе', priceRubles: 159),
    Product(id: 'tea', name: 'Чай', priceRubles: 99),
  ];
  const current = [
    Product(id: 'coffee', name: 'Кофе', priceRubles: 179),
    Product(id: 'water', name: 'Вода', priceRubles: 50),
  ];

  ProductCartManager manager = DefaultProductCartManager();
  final logs = <String>[];

  try {
    final changedIds = manager.findChangedIds(
      previous,
      current,
      log: logs.add,
    );
    print('Изменившиеся товары: ${changedIds.toList()..sort()}');
    for (final message in logs) {
      print('LOG: $message');
    }
  } on FormatException catch (error) {
    print('Не удалось сравнить списки товаров: $error');
  }
}
