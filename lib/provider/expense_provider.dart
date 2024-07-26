import 'package:expense_tracker/model/expense_info_model.dart';
import 'package:expense_tracker/service/shared_pref_service.dart';
import 'package:expense_tracker/util/strings_const.dart';
import 'package:flutter/cupertino.dart';

class ExpenseProvider extends ChangeNotifier{
  List<ExpenseInfo> expList = [];

  List<String> list = [
    StringsConst.list,
    StringsConst.list1,
    StringsConst.list2,
    StringsConst.list3,
    StringsConst.list4,
    StringsConst.list5,
    StringsConst.list6,
    StringsConst.list7,
  ];

  String currentValue = StringsConst.currentValue;

  void updateCurrentValue(String value) {
    currentValue = value;
    notifyListeners();
  }

  late List<ExpenseInfo> expenses;

  Future<void> fetchExpenses() async {
     expenses = await ExpenseService.getExpenses();
    expList = expenses;
    notifyListeners();
  }
}