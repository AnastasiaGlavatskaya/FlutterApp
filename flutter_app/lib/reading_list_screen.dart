import 'package:flutter/material.dart';
import 'package:flutter_app/model/book_model.dart';
import 'books.dart';
import 'add_item_screen.dart';
import 'books_to_read_screen.dart';
import 'edit_item_screen.dart';
import 'package:provider/provider.dart';


class ReadingListScreen extends StatefulWidget {
  @override
  _ReadingListScreenState createState() => _ReadingListScreenState();
}

class _ReadingListScreenState extends State<ReadingListScreen> {

  String dropdownValue = 'date';

  @override
  void initState(){
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final BookModel model = context.watch<BookModel>();
    //model.sort(dropdownValue);
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
                  itemCount: model.items.length,
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
                                    '${ model.items[index].title}',
                                    style: TextStyle(
                                      fontSize: 20.0
                                    ),
                                  ),
                                  subtitle: Text(
                                      '${ model.items[index].author}',
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
                                          model.items[index]
                                      ));
                                 if (item!=null) {
                                   Book editedBook = item;
                                     model.update(index, editedBook);
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
                                                  model.removeAt(index);
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
                                 '${ model.items[index].mark}',
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
                          dropdownValue = newValue;
                          model.sort(dropdownValue);
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
                          for (var item in  model.items) {
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
          Navigator.pushNamed(context, AddItemScreen.routeName);
          },//addItem,
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}