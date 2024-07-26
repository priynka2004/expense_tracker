import 'package:expense_tracker/model/expense_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ExpenseService {
  static const String expenseKey = 'ExpenseData';

  static Future<void> addExpense(ExpenseInfo expenseInfo) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> expenseList =
        sharedPreferences.getStringList(expenseKey) ?? [];
    String addExp = jsonEncode(expenseInfo.toMap());
    expenseList.add(addExp);
    sharedPreferences.setStringList(expenseKey, expenseList);
  }

  static Future<List<ExpenseInfo>> getExpenses() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> list = sharedPreferences.getStringList(expenseKey) ?? [];
    List<ExpenseInfo> expList = [];
    for (int i = 0; i < list.length; i++) {
      String showExp = list[i];
      Map<String, dynamic> map = jsonDecode(showExp);
      ExpenseInfo expenseInfo = ExpenseInfo.fromMap(map);
      expList.add(expenseInfo);
    }
    return expList;
  }
}
