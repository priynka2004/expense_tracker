import 'package:expense_tracker/model/expense_info_model.dart';
import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:expense_tracker/screens/add_expense_screen.dart';
import 'package:expense_tracker/service/shared_pref_service.dart';
import 'package:expense_tracker/util/colors_const.dart';
import 'package:expense_tracker/util/strings_const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowExpenseScreen extends StatefulWidget {
  const ShowExpenseScreen({super.key});

  @override
  State<ShowExpenseScreen> createState() => _ShowExpenseScreenState();
}

class _ShowExpenseScreenState extends State<ShowExpenseScreen> {

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
        child: Consumer<ExpenseProvider>(
          builder: (BuildContext context, ExpenseProvider provider, Widget? child) {
            return ListView.builder(
              itemCount: provider.expList.length,
              itemBuilder: (context, index) {
                ExpenseInfo expenseInfo = provider.expList[index];
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
            );
          }
        ),
      ),
    );
  }

  Future<void> showExpense() async {
    ExpenseProvider provider = Provider.of<ExpenseProvider>(context,listen: false);
    List<ExpenseInfo> expenses = await ExpenseService.getExpenses();
    setState(() {
     provider.expList = expenses;
    });
  }
}



// import 'package:flutter/material.dart';
// import 'package:expense_tracker/model/expense_info_model.dart';
// import 'package:expense_tracker/screens/add_expense_screen.dart';
// import 'package:expense_tracker/service/shared_pref_service.dart';
// import 'package:expense_tracker/util/colors_const.dart';
// import 'package:expense_tracker/util/strings_const.dart';
//
// class ShowExpenseScreen extends StatefulWidget {
//   const ShowExpenseScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ShowExpenseScreen> createState() => _ShowExpenseScreenState();
// }
//
// class _ShowExpenseScreenState extends State<ShowExpenseScreen> {
//   List<ExpenseInfo> expList = [];
//
//   @override
//   void initState() {
//     showExpense();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(StringsConst.showTitleText),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                 return const AddExpenseScreen();
//               }));
//             },
//             icon: const Icon(Icons.add),
//           ),
//         ],
//         backgroundColor: ColorsConst.showAppBarBackgroundColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: _buildCategoryList(),
//       ),
//     );
//   }
//
//   Widget _buildCategoryList() {
//     Map<String, int> categoryTotals = calculateCategoryTotals(expList);
//     int grandTotal = calculateGrandTotal(categoryTotals);
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Card(
//           color: Colors.white,
//           elevation: 4,
//           child: ListTile(
//             title: const Text(
//               'Grand Total:',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//             subtitle: Text(
//               '$grandTotal',
//               style: const TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 16),
//         Expanded(
//           child: ListView.builder(
//             itemCount: categoryTotals.length,
//             itemBuilder: (context, index) {
//               String category = categoryTotals.keys.elementAt(index);
//               int total = categoryTotals[category] ?? 0;
//
//               return Card(
//                 color: Colors.white,
//                 elevation: 4,
//                 child: ListTile(
//                   title: Text(
//                     '$category:',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                   subtitle: Text(
//                     'Total: $total',
//                     style: const TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Map<String, int> calculateCategoryTotals(List<ExpenseInfo> expenses) {
//     Map<String, int> categoryTotals = {};
//
//     for (ExpenseInfo expense in expenses) {
//       categoryTotals.update(
//         expense.category,
//             (value) => value + expense.price,
//         ifAbsent: () => expense.price,
//       );
//     }
//
//     return categoryTotals;
//   }
//
//   int calculateGrandTotal(Map<String, int> categoryTotals) {
//     return categoryTotals.values.fold(0, (sum, value) => sum + value);
//   }
//
//   Future<void> showExpense() async {
//     List<ExpenseInfo> expenses = await ExpenseService.getExpenses();
//     setState(() {
//       expList = expenses;
//     });
//   }
// }






