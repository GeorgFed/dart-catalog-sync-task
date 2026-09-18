final class Product {
  final String id;
  final String name;
  final int priceKopecks;

  Product({
    required this.id,
    required this.name,
    required this.priceKopecks,
  }) {
    // TODO: id и name не должны быть пустыми, priceKopecks — отрицательным.
  }
}

final class CartLine {
  final Product product;
  final int quantity;

  CartLine({required this.product, required this.quantity}) {
    // TODO: quantity должен быть больше нуля.
  }

  int get lineTotalKopecks {
    // TODO: цена одной позиции с учётом количества.
    throw UnimplementedError();
  }
}

abstract interface class Discount {
  int applyTo(int subtotalKopecks);
}

final class PercentDiscount implements Discount {
  final int percent;

  PercentDiscount(this.percent) {
    // TODO: percent должен находиться в диапазоне 0..100.
  }

  @override
  int applyTo(int subtotalKopecks) {
    // TODO: верните итоговую сумму после скидки.
    throw UnimplementedError();
  }
}

final class FixedDiscount implements Discount {
  final int amountKopecks;

  FixedDiscount(this.amountKopecks) {
    // TODO: amountKopecks не может быть отрицательным.
  }

  @override
  int applyTo(int subtotalKopecks) {
    // TODO: итог не должен стать меньше нуля.
    throw UnimplementedError();
  }
}

List<CartLine> mergeLines(List<CartLine> source) {
  // TODO: объедините позиции с одинаковым product.id.
  // Сохраните порядок первого появления и не меняйте source.
  throw UnimplementedError();
}

final class Cart {
  final List<CartLine> _lines;

  Cart(List<CartLine> lines) : _lines = List.unmodifiable(mergeLines(lines));

  List<CartLine> get lines => _lines;

  int get subtotalKopecks {
    // TODO: сумма всех объединённых позиций.
    throw UnimplementedError();
  }

  int totalKopecks([Discount? discount]) {
    // TODO: без скидки верните subtotal, иначе примените discount.
    throw UnimplementedError();
  }
}

void check(String name, bool condition) {
  if (!condition) throw StateError('Не прошла проверка: $name');
  print('OK: $name');
}

bool throwsArgumentError(void Function() action) {
  try {
    action();
    return false;
  } on ArgumentError {
    return true;
  }
}

void main() {
  final coffee = Product(id: 'coffee', name: 'Кофе', priceKopecks: 15900);
  final tea = Product(id: 'tea', name: 'Чай', priceKopecks: 9900);
  final source = <CartLine>[
    CartLine(product: coffee, quantity: 1),
    CartLine(product: tea, quantity: 3),
    CartLine(product: coffee, quantity: 1),
  ];
  final sourceSnapshot = source.map((line) => line.quantity).toList();
  final cart = Cart(source);

  check('дубли объединены',
      cart.lines.length == 2 && cart.lines.first.quantity == 2);
  check('subtotal', cart.subtotalKopecks == 61500);
  check('скидка 10%',
      cart.totalKopecks(PercentDiscount(10)) == 55350);
  check('фиксированная скидка не уходит ниже нуля',
      cart.totalKopecks(FixedDiscount(70000)) == 0);
  check('нулевое количество запрещено',
      throwsArgumentError(() => CartLine(product: tea, quantity: 0)));
  check(
      'отрицательная цена запрещена',
      throwsArgumentError(
          () => Product(id: 'bad', name: 'Ошибка', priceKopecks: -1)));
  check('процент больше 100 запрещён',
      throwsArgumentError(() => PercentDiscount(101)));
  check('отрицательная фиксированная скидка запрещена',
      throwsArgumentError(() => FixedDiscount(-1)));
  check('исходный список не изменён',
      source.map((line) => line.quantity).join(',') ==
          sourceSnapshot.join(','));

  var linesAreReadOnly = false;
  try {
    cart.lines.add(CartLine(product: tea, quantity: 1));
  } on UnsupportedError {
    linesAreReadOnly = true;
  }
  check('позиции корзины доступны только для чтения', linesAreReadOnly);

  print('Все проверки пройдены');
}
