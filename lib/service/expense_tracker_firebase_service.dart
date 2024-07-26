import 'package:expense_tracker/model/expense_info_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class ExpenseTrackerFirebaseService {
  final DatabaseReference _reference = FirebaseDatabase.instance.ref()
      .child('');

  Future<void> addExpenseTracker(ExpenseInfo expenseInfo) async {
    try {
      await _reference.push().set(expenseInfo.toJSON());
    } catch (error) {
      if (kDebugMode) {
        print('Error adding expenseInfo: $error');
      }
      rethrow;
    }
  }
}