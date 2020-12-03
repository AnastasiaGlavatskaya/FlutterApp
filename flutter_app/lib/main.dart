import 'package:flutter/material.dart';
import 'reading_list_screen.dart';
import 'add_item_screen.dart';
import 'books_to_read_screen.dart';

void main() {
  runApp(ReadingListApp());
}

class ReadingListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reading List',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: ReadingListScreen(),
      routes: {
        AddItemScreen.routeName: (context) => AddItemScreen(),
        BooksToReadScreen.routeName: (context) => BooksToReadScreen(),
      },
    );
  }
}