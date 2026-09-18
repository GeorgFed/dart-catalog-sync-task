import 'package:collection/collection.dart';

typedef CartItem = ({String productId, int quantity});

typedef CheckoutTotal = ({
  int itemsCount,
  int subtotalKopecks,
  int discountKopecks,
  int totalKopecks,
});

final class Product {
  static const tagsEquality = ListEquality<String>();

  final String id;
  final String name;
  final int priceKopecks;
  final String? description;
  final List<String> tags;

  const Product({
    required this.id,
    required this.name,
    required this.priceKopecks,
    this.description,
    this.tags = const [],
  }) : assert(id != ''),
       assert(name != ''),
       assert(priceKopecks >= 0);

  @override
  bool operator ==(Object other) {
    // TODO: сравните все поля. Для tags нужна глубокая проверка списка.
    return identical(this, other);
  }

  @override
  int get hashCode {
    // TODO: одинаковые Product должны получать одинаковый hashCode.
    return identityHashCode(this);
  }
}

bool sameCart(List<CartItem> left, List<CartItem> right) {
  // TODO: обычный == сравнивает объекты List, а не их содержимое.
  return identical(left, right);
}

abstract interface class ProductCatalog {
  List<Product> get products;

  Product? findById(String id);
}

final class MemoryProductCatalog implements ProductCatalog {
  late final List<Product> _products;
  late final Map<String, Product> _byId;

  MemoryProductCatalog(List<Product> products) {
    // TODO: проверьте уникальность id и инициализируйте оба late final поля.
    // Наружу нельзя отдавать изменяемую коллекцию.
  }

  @override
  List<Product> get products => _products;

  @override
  Product? findById(String id) => _byId[id];
}

abstract interface class DiscountPolicy {
  int discountKopecks({required int subtotalKopecks, String? promoCode});
}

final class PromoCodeDiscount implements DiscountPolicy {
  @override
  int discountKopecks({required int subtotalKopecks, String? promoCode}) {
    // TODO: используйте switch pattern:
    // SAVE10 — 10%, SAVE500 — 50 000 копеек, null/неизвестный код — 0.
    return 0;
  }
}

final class CheckoutService {
  final ProductCatalog catalog;
  final DiscountPolicy discountPolicy;

  const CheckoutService({required this.catalog, required this.discountPolicy});

  CheckoutTotal quote(List<CartItem> items, {String? promoCode}) {
    // TODO: разберите records через pattern, найдите товары и посчитайте итог.
    // quantity <= 0 -> ArgumentError; неизвестный productId -> StateError.
    // Скидку ограничьте диапазоном 0..subtotal.
    throw UnimplementedError();
  }
}
