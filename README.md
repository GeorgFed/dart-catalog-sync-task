# Синхронизация каталога на Dart 3

## Зачем это делаем

Приложение хранит локальный каталог товаров и периодически получает новую версию с бэкенда. Нужно понять, какие товары добавились, исчезли или изменились, чтобы обновить только нужные карточки.

## Что нужно сделать

Последовательно реализуйте четыре TODO в `lib/catalog.dart`:

1. Сравнение двух `Product` через `operator ==` и `hashCode`.
2. Глубокое сравнение двух `List<Product>`.
3. Индекс каталога `Map<String, Product>` с проверкой дублей и логированием.
4. Множество `Set<String>` с id изменившихся товаров.

В обязательной части нет records, patterns, async, Flutter и сложной архитектуры.

## Быстрый старт

```bash
dart pub get
dart analyze
dart test
dart run bin/demo.dart
```

Тесты в starter изначально падают: они описывают ожидаемое поведение.

## Подсказки и референсы

- [Equality operators](https://dart.dev/language/operators#equality-and-relational-operators)
- [Object.hash](https://api.dart.dev/dart-core/Object/hash.html)
- [Map](https://dart.dev/language/collections#maps)
- [Set](https://dart.dev/language/collections#sets)
- [collection: equality](https://pub.dev/documentation/collection/latest/collection/DeepCollectionEquality-class.html)
- Сначала читайте соответствующий тест, затем реализуйте только один TODO.

## Обработка ошибки и логирование

`indexById` — единственное место с обязательной ошибкой: повторяющийся `Product.id` означает некорректный каталог. Перед `FormatException` запишите сообщение через необязательный `log` callback. После успешного индексирования и после сравнения каталогов также оставьте короткий лог.

## Оценка

- **0 баллов:** проект не собирается, проходят меньше 4 из 8 тестов или студент не может объяснить решение.
- **1 балл:** проходят 4–7 тестов; модель сравнивается и работает хотя бы одна из структур `Map`/`Set`; студент объясняет реализованную часть.
- **2 балла:** проходят все 8 тестов и `dart analyze`; студент объясняет equality/hashCode, deep equality, Map, Set, обработку дубля и назначение логов.

## Мегаопционально

После обязательной части можно вернуть подробный diff как record:

```dart
({Set<String> added, Set<String> removed, Set<String> updated})
```

Для обхода `Map.entries` можно попробовать object pattern. Эта часть не нужна для 2 баллов.
