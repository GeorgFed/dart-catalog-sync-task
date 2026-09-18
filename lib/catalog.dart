import 'package:collection/collection.dart';

/*
Продуктовый контекст

Приложение хранит локальный каталог товаров и получает его новую версию
с бэкенда. Чтобы не обновлять все карточки, нужно определить товары,
которые добавились, исчезли или изменились.

Задача

Сделать так, чтобы товары с одинаковыми данными считались равными, сравнить
две версии каталога и вернуть множество id, требующих обновления.
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

abstract interface class CatalogComparator {
  bool sameProductList(List<Product> left, List<Product> right);

  Map<String, Product> indexById(
    List<Product> products, {
    LogSink? log,
  });

  Set<String> findChangedIds(
    List<Product> previous,
    List<Product> current, {
    LogSink? log,
  });
}

final class DefaultCatalogComparator implements CatalogComparator {
  @override
  bool sameProductList(List<Product> left, List<Product> right) {
    // TODO 2: определите, представляют ли два списка один и тот же каталог.
    return identical(left, right);
  }

  @override
  Map<String, Product> indexById(
    List<Product> products, {
    LogSink? log,
  }) {
    // TODO 3: подготовьте каталог для поиска товара по id.
    // Некорректный каталог должен дать понятную ошибку и лог;
    // успешная операция — итоговый лог. Результат нельзя менять снаружи.
    throw UnimplementedError();
  }

  @override
  Set<String> findChangedIds(
    List<Product> previous,
    List<Product> current, {
    LogSink? log,
  }) {
    // TODO 4: верните id товаров, состояние которых различается между версиями.
    // Не изменяйте входные каталоги; зафиксируйте результат в логе.
    throw UnimplementedError();
  }
}
