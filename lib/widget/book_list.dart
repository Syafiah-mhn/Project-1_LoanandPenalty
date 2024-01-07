/**
 * Author         : Nursyafiah binti Zahari
 * Program        : Loan and Penalty Application
 * Date Created   : 21 December 2023
 * Date Modifeid  : None
 * Purpose        : Widget to populate the list of books
 * Changes        : None
 */

import 'package:flutter/material.dart';
import 'package:loan_penalty/model/book.dart';
import 'package:loan_penalty/widget/book_details.dart';


List<String> titles = <String>[
  'In Progress',
  'Penalty',
  'Completed',
];

class bookList extends StatelessWidget {
  const bookList({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: const Color(0xff6750a4)),
        useMaterial3: true,
      ),
      home: const BookListState(),
    );
  }
}

class BookListState extends StatelessWidget {
  const BookListState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    const int tabsCount = 3;

    return DefaultTabController(
      initialIndex: 1,
      length: tabsCount,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Book List'),
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: const Icon(Icons.assignment_outlined),
                text: titles[0],
              ),
              Tab(
                 icon: const Icon(Icons.assignment_late_outlined),
                text: titles[1],
              ),
              Tab(
                icon: const Icon(Icons.assignment_turned_in_outlined),
                text: titles[2],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            BookList(data: titles[0], oddItemColor: oddItemColor, evenItemColor: evenItemColor),
            BookList(data: titles[1], oddItemColor: oddItemColor, evenItemColor: evenItemColor),
            BookList(data: titles[2], oddItemColor: oddItemColor, evenItemColor: evenItemColor),
          ],
        ),
      ),
    );
  }
}

class BookList extends StatelessWidget {
  final String data;
  final Color oddItemColor;
  final Color evenItemColor;

  BookList({
    Key? key,
    required this.data,
    required this.oddItemColor,
    required this.evenItemColor,
  }) : super(key: key);

  List<Book> getBooksForCategory(String category) {
    // Logic to get books based on category
    // For example, dummy data:
    DateTime now = DateTime.now();
    List<Book> books = [
      Book(
        id: 1,
        title: 'Meniti Impian', 
        author: 'Author 1',
        borrowDate: DateTime(2024, 1, 5), 
        isReturned: false
        ),
      Book(
        id: 2,
        title: 'The Son of Mad Mat Lela', 
        author: 'Author 2',
        borrowDate: DateTime(2023, 12, 5), //YY MM DD
        isReturned: false
        ),
      Book(
        id: 3,
        title: 'The Power Of Positive Thinking', 
        author: 'Author 3',
        borrowDate: DateTime(2023, 12, 31),
        isReturned: true,
        ),
      Book(
        id: 4,
        title: 'The Mind of the Leader', 
        author: 'Author 4',
        borrowDate: DateTime(2024, 1, 1 ),
        isReturned: false,
        ),
      Book(
        id: 5,
        title: 'Think And Grow Rich', 
        author: 'Author 5',
        borrowDate: DateTime(2023, 12, 1 ), 
        isReturned: false,
      ),
      Book(
        id: 6,
        title: 'Music and My Friends', 
        author: 'Author 6',
        borrowDate: DateTime(2023, 12, 16 ),
        isReturned: true,
       ),
    ];

    if (category == 'In Progress') {
    return books
        .where((book) => !book.isReturned && now.difference(book.borrowDate).inDays <= 14)
        .toList();
  } else if (category == 'Penalty') {
    return books
        .where((book) => !book.isReturned && now.difference(book.borrowDate).inDays > 14)
        .toList();
  } else {
    return books.where((book) => book.isReturned).toList();
  }
  }

  String getDaysLeft(DateTime borrowDate) {  //betulkan logic
    DateTime now = DateTime.now();

    int daysDifference = now.difference(borrowDate).inDays - 14;
    return daysDifference >= 14  //ternary operator
    ? 'Due $daysDifference days ago' 
    : 'Due in ${daysDifference.abs()} days';
  }

  @override
  Widget build(BuildContext context) {
    List<Book> books = getBooksForCategory(data);

    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (BuildContext cext, int index) {
        Book book = books[index];

        String daysLeft = '';
        if (data == 'In Progress' || data == 'Penalty') {  //display day left
          daysLeft = getDaysLeft(book.borrowDate);
        }

        

        return ListTile(
          tileColor: index.isOdd ? oddItemColor : evenItemColor,
          title: Text('${book.title} - $daysLeft'),
          onTap: () {

            bool hasPenalty = data == 'Penalty'; // Determine if the book has a penalty
            double penaltyFee = 0.0;

            if (hasPenalty) {
                DateTime now = DateTime.now();
                int daysOverdue = now.difference(book.borrowDate).inDays - 14;
                if (daysOverdue > 0) {
                penaltyFee = daysOverdue * 0.20;
              }
            }
            String formattedPenaltyFee = penaltyFee.toStringAsFixed(
              penaltyFee.truncateToDouble() == penaltyFee ? 0 : 2
            );
   
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetails(
                  book: book, // Provide the Book object
                  hasPenalty: hasPenalty, // Example: Provide the hasPenalty value
                  penaltyFee: double.parse(formattedPenaltyFee),
                ),
                          
              ),
            );
          }
        );
      },
    );
  }
}