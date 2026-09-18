import 'package:collection/collection.dart';

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
    // TODO 1: сравните все поля. tags нужно сравнить по содержимому.
    return identical(this, other);
  }

  @override
  int get hashCode {
    // TODO 1: используйте те же поля, что и в operator ==.
    return identityHashCode(this);
  }
}

bool sameProductList(List<Product> left, List<Product> right) {
  // TODO 2: два разных объекта List могут содержать одинаковые товары.
  return identical(left, right);
}

Map<String, Product> indexById(
  List<Product> products, {
  LogSink? log,
}) {
  // TODO 3:
  // 1. Соберите Map: product.id -> product.
  // 2. При повторяющемся id запишите ошибку в log и бросьте FormatException.
  // 3. После успеха запишите в log число товаров.
  // 4. Верните Map, которую нельзя изменить снаружи.
  throw UnimplementedError();
}

Set<String> findChangedIds(
  List<Product> previous,
  List<Product> current, {
  LogSink? log,
}) {
  // TODO 4:
  // 1. Постройте два индекса через indexById.
  // 2. Соберите Set всех id из старого и нового каталогов.
  // 3. Оставьте id добавленных, удалённых или изменённых товаров.
  // 4. Запишите в log число изменений и верните read-only Set.
  throw UnimplementedError();
}
