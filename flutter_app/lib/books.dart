
final String table = 'Books';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnAuthor = 'author';
final String columnMark = 'mark';

class Book {
  int id;
  String title;
  String author;
  String mark;

  Book(int id, String title, String author, String mark) {
    this.id = id;
    this.title = title;
    this.author = author;
    this.mark = mark;
  }

  Map<String, dynamic> toMap() {
    return<String, dynamic>{
      columnId : id,
      columnTitle : title,
      columnAuthor : author,
      columnMark : mark
    };
}

  Book.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    author = map[columnAuthor];
    mark = map[columnMark];
  }

  sortBy(String field) {
    if (field == 'date') return this.id;
    if (field == 'title') return this.title;
    if (field == 'author') return this.author;
    if (field == 'mark') {
      if (this.mark == 'to read')
        return '0';
      else
        return this.mark;
    }
  }

}