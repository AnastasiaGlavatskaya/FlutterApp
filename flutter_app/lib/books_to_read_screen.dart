import 'package:flutter/material.dart';
import 'books.dart';

class Arguments {
  final List<Book>
  items;
  Arguments(this.items);
}


class BooksToReadScreen extends StatefulWidget {
  static const String routeName = 'books_to_read_list';
  final List<Book> items;

  const BooksToReadScreen({
    Key key,
    @required this.items,
  }) : super(key: key);

  @override
  _BooksToReadScreen createState() => _BooksToReadScreen();
}
class _BooksToReadScreen extends State<BooksToReadScreen> {
  final double text_size = 20.0;
  String dropdownValue;

  @override
  void initState() {
    dropdownValue = 'date';
    super.initState();
  }

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
                    itemCount: (widget.items != null) ? widget.items.length : 0,
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
                                      '${widget.items[index].title}',
                                      style: TextStyle(
                                          fontSize: 20.0
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${widget.items[index].author}',
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
                            widget.items.sort((a, b) => a.sortBy(dropdownValue).compareTo(b.sortBy(dropdownValue)));
                          });
                        },
                        items: <String>['date', 'title', 'author']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                                value
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}