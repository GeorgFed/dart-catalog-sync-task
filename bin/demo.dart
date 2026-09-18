import 'package:dart_shopping_cart_task/cart.dart';

void main() {
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

  final service = CheckoutService(
    catalog: MemoryProductCatalog(const [coffee, tea]),
    discountPolicy: PromoCodeDiscount(),
  );

  final total = service.quote(const [
    (productId: 'coffee', quantity: 2),
    (productId: 'tea', quantity: 3),
  ], promoCode: 'SAVE10');

  final (:itemsCount, :subtotalKopecks, :discountKopecks, :totalKopecks) =
      total;

  print('Товаров: $itemsCount');
  print('До скидки: $subtotalKopecks коп.');
  print('Скидка: $discountKopecks коп.');
  print('Итого: $totalKopecks коп.');
}
