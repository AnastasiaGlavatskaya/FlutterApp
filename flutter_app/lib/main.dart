import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/book_model.dart';
import 'reading_list_screen.dart';
import 'edit_item_screen.dart';
import 'add_item_screen.dart';
import 'books_to_read_screen.dart';
import 'books.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => BookModel(),
      child: ReadingListApp(),
  ));
}

class ReadingListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: missing_return
      onGenerateRoute: (settings) {
        if (settings.name == EditItemScreen.routeName) {
          final ScreenArguments args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return EditItemScreen(
                item: args.item,
              );
            },
          );
        }
        else
        if (settings.name == BooksToReadScreen.routeName) {
          final Arguments args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return BooksToReadScreen(
                items: args.items,
              );
            },
          );
        }
      },

      title: 'Reading List',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: ReadingListScreen(),
      routes: {
    AddItemScreen.routeName: (context) => AddItemScreen(),
   // BooksToReadScreen.routeName: (context) => BooksToReadScreen(),
   // EditItemScreen.routeName: (context) => EditItemScreen(),

    },

    );
  }
}