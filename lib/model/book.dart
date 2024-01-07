class Book {
  //final Book book;
  final int id;
  final String title;
  final String author;
  final DateTime borrowDate;
  final bool isReturned;

  Book({
    //required this.book,
    required this.id,
    required this.title,
    required this.author,
    required this.borrowDate,
    required this.isReturned,
  });
}
