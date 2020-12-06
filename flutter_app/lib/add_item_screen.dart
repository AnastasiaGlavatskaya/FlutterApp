import 'package:flutter/material.dart';
import 'books.dart';

class AddItemScreen extends StatefulWidget {
  static const String routeName = 'add_book';
  @override
  _AddItemScreen createState() => _AddItemScreen();
}

class _AddItemScreen extends State<AddItemScreen> {
  final double text_size = 20.0;
  String dropdownValue;
  TextEditingController _titleController;
  TextEditingController _authorController;

  @override
  void initState() {
    dropdownValue = 'to read';
    _titleController = TextEditingController();
    _authorController = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Book"),
      ),
      body: Container(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: ListView(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Title:',
                  style: TextStyle(
                    fontSize: text_size
                  ),
                ),
              ),
              TextField(
                style: TextStyle(
                    fontSize: text_size
                ),
                decoration: InputDecoration(
                  hintText: 'Enter a title',
                ),
                controller : _titleController,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Author:',
                    style: TextStyle(
                        fontSize: text_size
                    ),
                  ),
                ),
              ),
              TextField(
                style: TextStyle(
                    fontSize: text_size
                ),
                decoration: InputDecoration(
                    hintText: 'Enter author name'
                ),
                controller : _authorController,
              ),
            Row(
              children: [
                Icon(Icons.star),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0.0),
                  child: DropdownButton<String>(
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
                      });
                    },
                    items: <String>['to read', '1', '2', '3', '4', '5']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                            value
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
              //MyStatefulWidget(),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      onPressed : () {
                        if (_titleController.text == '') {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    title: Text('Enter a title'),
                                    actions: [
                                      TextButton(
                                        onPressed : () {
                                          Navigator.pop(context);
                                        },
                                        child:  Text('Cancel'),
                                      ),
                                    ]
                                );
                              }
                          );
                        }
                        else {
                          if (_authorController.text == '') {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      title: Text('Enter an author'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel'),
                                        ),
                                      ]
                                  );
                                }
                            );
                          }
                          else {
                            Book book = new Book(
                                0, _titleController.text, _authorController.text,
                                dropdownValue);
                            Navigator.pop(context, book);
                          }
                        }
                      },
                      child: Text ('Add book'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
