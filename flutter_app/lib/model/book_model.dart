import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/books.dart';

import '../database_provider.dart';

class BookModel extends ChangeNotifier {
  final List<Book> _items = [];

  BookModel() {
    DatabaseProvider().openBooksDatabase().then((_) {
      DatabaseProvider().getList().then((items) {
          addAll(items);
      });
    });
  }

  UnmodifiableListView<Book> get items => UnmodifiableListView(_items);

  void addAll(List<Book> items) {
    _items.addAll(items);
    notifyListeners();
  }

  void add(Book item) {
    _items.add(item);
    DatabaseProvider().saveTable(item);
    notifyListeners();
  }

  void removeAt(int index) {
    DatabaseProvider().delete(_items[index].id);
    _items.removeAt(index);
    notifyListeners();
  }

  void update(int index, Book item) {
    _items[index] = item;
    DatabaseProvider().update(item);
    notifyListeners();
  }

  void sort(String value) {
    if (value == 'mark') {
      _items.sort((b, a) => a.sortBy(value).compareTo(b.sortBy(value)));
    }
    else {
      _items.sort((a, b) => a.sortBy(value).compareTo(b.sortBy(value)));
    }
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }


}