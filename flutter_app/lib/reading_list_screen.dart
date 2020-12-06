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
  String dropdownValue = 'date';

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
                          color : ((index % 2) == 1) ? Colors.black12 : Colors.transparent,
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
                         Container(
                           color : ((index % 2) == 1) ? Colors.black12 : Colors.transparent,
                           child: Row(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(40.0, 0, 2.0, 0),
                                 child: Icon(Icons.star),
                               ),
                               Expanded(
                               child: Text(
                                 '${_books[index].mark}',
                                 style: TextStyle(
                                     fontSize: 18.0
                                 ),
                               ),
                               )
                             ],
                           ),
                         ),
                      ],
                    );
                  },
                )
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Row(
                  children: [
                     Padding(
                       padding: const EdgeInsets.all(6.0),
                       child: Text (
                           'Sort by',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                         ),
                       ),
                     ),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                          _books.sort((a, b) => a.sortBy(dropdownValue).compareTo(b.sortBy(dropdownValue)));
                        });
                      },
                      items: <String>['date', 'title', 'author', 'mark']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                              value
                          ),
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40.0, 10.0, 0.0, 10.0),
                      child: ElevatedButton(
                        onPressed : () {
                          List<Book> to_read = new List<Book>();
                          for (var item in _books) {
                            if (item.mark == 'to read') {
                              to_read.add(item);
                            }
                          }
                          to_read.sort((a, b) => a.sortBy('date').compareTo(b.sortBy('date')));
                          Navigator.pushNamed(context, BooksToReadScreen.routeName,
                              arguments: Arguments(to_read));
                        },
                        child: Text ('Books to read'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                _books.sort((a, b) => a.sortBy(dropdownValue).compareTo(b.sortBy(dropdownValue)));
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