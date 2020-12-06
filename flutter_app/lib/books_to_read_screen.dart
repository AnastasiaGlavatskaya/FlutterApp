import 'package:flutter/material.dart';
import 'books.dart';


class BooksToReadScreen extends StatelessWidget {
  static const String routeName = 'books_to_read_list';
  final double text_size = 20.0;

  final List<Book> _books_to_read = [
    new Book(1, 'Ninth House','Leigh Bardugo','5'),
    new Book(2, 'The Goldfinch','Donna Tartt','4')
  ];

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
                    itemCount: _books_to_read.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    '${_books_to_read[index].title}',
                                    style: TextStyle(
                                        fontSize: 20.0

                                    ),
                                  ),
                                  subtitle: Text(
                                    '${_books_to_read[index].author}',
                                    style: TextStyle(
                                        fontSize: 16.0
                                    ),
                                  ),
                                ),
                              ),

                              Icon(Icons.edit_outlined),
                              Icon(Icons.delete),
                            ],
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