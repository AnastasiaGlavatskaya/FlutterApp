import 'package:flutter/material.dart';
import 'books.dart';

class Arguments {
  final List<Book>
  items;
  Arguments(this.items);
}

class BooksToReadScreen extends StatelessWidget {
  static const String routeName = 'books_to_read_list';
  final double text_size = 20.0;
  final List<Book> items;

  const BooksToReadScreen({
    Key key,
    @required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Books to read"),
      ),
      body: Container(
        child: Column(
            children: [
              new Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 0),
                    itemCount: (items != null) ? items.length : 0,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            color: ((index % 2) == 1) ? Colors.black12 : Colors.transparent,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      '${items[index].title}',
                                      style: TextStyle(
                                          fontSize: 20.0

                                      ),
                                    ),
                                    subtitle: Text(
                                      '${items[index].author}',
                                      style: TextStyle(
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                ),
                                //Icon(Icons.edit_outlined),
                               // Icon(Icons.delete),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  )
              ),
            ]
        ),
      ),
    );
  }
}