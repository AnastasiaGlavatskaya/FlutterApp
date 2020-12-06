import 'package:flutter/material.dart';
import 'package:flutter_app/database_provider.dart';
import 'books.dart';
import 'add_item_screen.dart';
import 'books_to_read_screen.dart';
import 'edit_item_screen.dart';


class ReadingListScreen extends StatefulWidget {
  @override
  _ReadingListScreenState createState() => _ReadingListScreenState();
}

class _ReadingListScreenState extends State<ReadingListScreen> {
  List<Book> _books;

  @override
  void initState(){
    super.initState();

    _books = new List<Book>();

    DatabaseProvider().openBooksDatabase().then((_) {
      DatabaseProvider().getList().then((items) {
        setState(() {
          _books = items;
        });
      });
    });

    //_books.add(new Book(1, 'Ninth House','Leigh Bardugo','5'));
    //_books.add(new Book(2, 'The Goldfinch','Donna Tartt','4'));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reading List"),
      ),
      body: Container(
        child: Column(
          children: [
            new Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 0),
                  itemCount: _books.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                         // color : true ? Colors.black12 : Colors.transparent,
                          child: Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    '${_books[index].title}',
                                    style: TextStyle(
                                      fontSize: 20.0
                                    ),
                                  ),
                                  subtitle: Text(
                                      '${_books[index].author}',
                                    style: TextStyle(
                                        fontSize: 16.0
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                 var item = await
                                  Navigator.pushNamed(context, EditItemScreen.routeName,
                                      arguments: ScreenArguments(
                                          _books[index]
                                      ));
                                 if (item!=null) {
                                   Book editedBook = item;
                                   setState(() {
                                     _books[index] = editedBook;
                                     DatabaseProvider().update(editedBook);
                                   });
                                 };
                                },
                                child: Icon(Icons.edit_outlined),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                   builder: (context) {
                                      return AlertDialog(
                                        title: Text('Are you sure?'),
                                        actions: [
                                          TextButton(
                                            onPressed : () {
                                              Navigator.pop(context);
                                            },
                                            child:  Text('No'),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                DatabaseProvider().delete(_books[index].id);
                                                setState(() {
                                                  _books.removeAt(index);
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Text('Yes')
                                          )
                                        ]
                                      );
                                   }
                                  );
                                },
                                child: Icon(Icons.delete),
                              )
                            ],
                          ),
                        ),
                         Row(
                           children: [
                             Padding(
                               padding: const EdgeInsets.fromLTRB(10.0, 0, 2.0, 0),
                               child: Icon(Icons.star),
                             ),
                             Expanded(
                             child: Text(
                               '${_books[index].mark}',
                               style: TextStyle(
                                   fontSize: 20.0
                               ),
                             ),
                             )
                           ],
                         ),
                      ],
                    );
                  },
                )
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed : () {
                  Navigator.pushNamed(context, BooksToReadScreen.routeName);
                },
                child: Text ('Books to read'),
              ),
            )
          ]
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed:  (){
          Navigator.pushNamed(context, AddItemScreen.routeName).then((newBook) => {

              setState(() {
                Book book = newBook;
                book.id = _books.length+1;
                _books.add(book);
            DatabaseProvider().saveTable(book);
          })

          });
          },//addItem,
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}