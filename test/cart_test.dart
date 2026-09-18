import 'package:dart_shopping_cart_task/cart.dart';
import 'package:test/test.dart';

const coffee = Product(
  id: 'coffee',
  name: 'Кофе',
  priceKopecks: 15900,
  tags: ['drink', 'hot'],
);
const tea = Product(
  id: 'tea',
  name: 'Чай',
  priceKopecks: 9900,
  description: 'Чёрный чай',
  tags: ['drink'],
);

void main() {
  test('const Product поддерживает необязательное описание', () {
    const product = Product(id: 'water', name: 'Вода', priceKopecks: 5000);
    expect(product.description, isNull);
    expect(product.tags, isEmpty);
  });

  test('Product сравнивается по значениям и глубокому списку tags', () {
    final sameCoffee = Product(
      id: 'coffee',
      name: 'Кофе',
      priceKopecks: 15900,
      tags: List.of(['drink', 'hot']),
    );
    expect(sameCoffee, coffee);
    expect(sameCoffee.hashCode, coffee.hashCode);
  });

  test('sameCart сравнивает разные List по содержимому', () {
    final first = [(productId: 'coffee', quantity: 2)];
    final second = [(productId: 'coffee', quantity: 2)];
    expect(identical(first, second), isFalse);
    expect(first == second, isFalse);
    expect(sameCart(first, second), isTrue);
  });

  test('MemoryProductCatalog реализует поиск и read-only список', () {
    final catalog = MemoryProductCatalog(const [coffee, tea]);
    expect(catalog.findById('tea'), tea);
    expect(catalog.findById('missing'), isNull);
    expect(() => catalog.products.add(coffee), throwsUnsupportedError);
    expect(
      () => MemoryProductCatalog(const [coffee, coffee]),
      throwsArgumentError,
    );
  });

  test('null и неизвестный промокод дают нулевую скидку', () {
    final policy = PromoCodeDiscount();
    expect(policy.discountKopecks(subtotalKopecks: 100000), 0);
    expect(
      policy.discountKopecks(subtotalKopecks: 100000, promoCode: 'UNKNOWN'),
      0,
    );
  });

  test('promo policy использует patterns для SAVE10 и SAVE500', () {
    final policy = PromoCodeDiscount();
    expect(
      policy.discountKopecks(subtotalKopecks: 100000, promoCode: ' save10 '),
      10000,
    );
    expect(
      policy.discountKopecks(subtotalKopecks: 40000, promoCode: 'SAVE500'),
      50000,
    );
  });

  test('checkout возвращает record с полной суммой', () {
    final service = createService();
    final actual = service.quote(const [
      (productId: 'coffee', quantity: 2),
      (productId: 'tea', quantity: 3),
    ], promoCode: 'SAVE10');
    expect(actual, (
      itemsCount: 5,
      subtotalKopecks: 61500,
      discountKopecks: 6150,
      totalKopecks: 55350,
    ));
  });

  test('checkout отклоняет неположительное количество', () {
    expect(
      () => createService().quote(const [(productId: 'tea', quantity: 0)]),
      throwsArgumentError,
    );
  });

  test('checkout сообщает о неизвестном товаре', () {
    expect(
      () => createService().quote(const [(productId: 'missing', quantity: 1)]),
      throwsStateError,
    );
  });

  test('checkout не изменяет входной список records', () {
    final items = <CartItem>[(productId: 'tea', quantity: 2)];
    final snapshot = List<CartItem>.of(items);
    createService().quote(items);
    expect(sameCart(items, snapshot), isTrue);
  });
}

CheckoutService createService() => CheckoutService(
  catalog: MemoryProductCatalog(const [coffee, tea]),
  discountPolicy: PromoCodeDiscount(),
);
