# Checkout на Dart 3

Практика на 1 час 10 минут: небольшой production-like расчёт корзины без Flutter.

Нужно реализовать TODO в `lib/cart.dart`. Готовые тесты проверяют:

- `const` и nullable-поле;
- value equality для `Product`, включая глубокое сравнение `tags`;
- deep equality двух списков records;
- `late final` при создании in-memory каталога;
- два интерфейса: `ProductCatalog` и `DiscountPolicy`;
- records и patterns в расчёте checkout;
- nullable promo code;
- ошибки количества и неизвестного товара;
- отсутствие изменений во входном списке.

## Быстрый старт

```bash
dart pub get
dart analyze
dart test
dart run bin/demo.dart
```

Тесты в starter изначально падают: они являются исполняемой спецификацией решения.

## Структура

- `lib/cart.dart` — код с TODO;
- `test/cart_test.dart` — 10 готовых тестов;
- `bin/demo.dart` — пример запуска и pattern destructuring результата.

## Оценка

- **0 баллов:** проект не собирается, проходит меньше 5 тестов или студент не может объяснить решение.
- **1 балл:** проходят 5–9 тестов, включая основной расчёт checkout; студент объясняет реализованную часть.
- **2 балла:** проходят все 10 тестов и `dart analyze`; студент объясняет `late`, `const`, `==/hashCode`, deep equality, nullable promo code, records, patterns и реализацию интерфейсов.

Нельзя удалять или ослаблять проверки. Дополнительный код не повышает оценку выше 2 баллов.
