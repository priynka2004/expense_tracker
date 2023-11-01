import 'package:expense_tracker/model/expense_info_model.dart';
import 'package:expense_tracker/screens/add_expense_screen.dart';
import 'package:expense_tracker/service/shared_pref_service.dart';
import 'package:expense_tracker/util/colors_const.dart';
import 'package:expense_tracker/util/strings_const.dart';
import 'package:flutter/material.dart';

class ShowExpenseScreen extends StatefulWidget {
  const ShowExpenseScreen({super.key});

  @override
  State<ShowExpenseScreen> createState() => _ShowExpenseScreenState();
}

class _ShowExpenseScreenState extends State<ShowExpenseScreen> {
  List<ExpenseInfo> expList = [];

  @override
  void initState() {
    showExpense();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsConst.showTitleText),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return const AddExpenseScreen();
              }));
            },
            icon: const Icon(Icons.add),
          ),
        ],
        backgroundColor: ColorsConst.showAppBarBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: expList.length,
          itemBuilder: (context, index) {
            ExpenseInfo expenseInfo = expList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(StringsConst.showNameText),
                      const SizedBox(width: 100),
                      Text(expenseInfo.name),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(StringsConst.showPriceText),
                      const SizedBox(width: 100),
                      Text(expenseInfo.price.toString()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(StringsConst.showDescriptionText),
                      const SizedBox(width: 100),
                      Text(expenseInfo.description),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(StringsConst.showCategoryText),
                      const SizedBox(width: 100),
                      Text(expenseInfo.category),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(
                    color: ColorsConst.dividerColor,
                    indent: 15,
                    endIndent: 15,
                    thickness: 2,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> showExpense() async {
    List<ExpenseInfo> expenses = await ExpenseService.getExpenses();
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // List<String> list = sharedPreferences.getStringList('ExpenseData') ?? [];
    // for (int i = 0; i < list.length; i++) {
    //   String showExp = list[i];
    //   Map<String, dynamic> map = jsonDecode(showExp); // Use jsonDecode
    //   ExpenseInfo expenseInfo = ExpenseInfo.fromMap(map);
    //   expList.add(expenseInfo);
    // }
    setState(() {
      expList = expenses;
    });
  }
}
