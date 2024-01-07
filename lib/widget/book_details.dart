/**
 * Author         : Nursyafiah binti Zahari
 * Program        : Loan and Penalty Application
 * Date Created   : 21 December 2023
 * Date Modifeid  : None
 * Purpose        : Widget for to populate the details about the book.
 * Changes        : None
 */

import 'package:flutter/material.dart';
import 'package:loan_penalty/model/book.dart';
import 'package:intl/intl.dart';

class BookDetails extends StatelessWidget {
  final Book book;
  final bool hasPenalty;
  final double penaltyFee;

  const BookDetails({
    required this.book,
    required this.hasPenalty,
    required this.penaltyFee,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(
              'Title', book.title
              ),
            _buildDetailRow(
              'Author', book.author
              ),
            _buildDetailRow(
              'Borrowed Date',
              DateFormat('yyyy-MM-dd').format(book.borrowDate),
            ),
            _buildDetailRow(
              'Has Penalty',
              hasPenalty ? 'Yes' : 'No',
            ),
            if (hasPenalty) _buildDetailRow('Penalty Fee', '\RM $penaltyFee'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 16), // Adjust the width as needed for spacing
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
