import 'package:expense_tracker/model/expense_info_model.dart';
import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:expense_tracker/screens/show_expense_screen.dart';
import 'package:expense_tracker/service/shared_pref_service.dart';
import 'package:expense_tracker/util/colors_const.dart';
import 'package:expense_tracker/util/strings_const.dart';
import 'package:expense_tracker/util/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {

  late TextEditingController nameController;
  late TextEditingController categoryController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController = TextEditingController();
    categoryController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ExpenseProvider provider = Provider.of<ExpenseProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsConst.addTitleText),
        backgroundColor: ColorsConst.addBackgroundColor,
      ),
      body:  Form(
    key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(StringsConst.addDropdownText),
                      DropdownButton(
                        value:provider.currentValue,
                        items: provider.list.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (String? item) {
                         provider.updateCurrentValue(item!);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    validator: (String? value) {
                      return Validators.nameValidator(value);
                    },
                    controller: nameController,
                    decoration: const InputDecoration(
                      label: Text("Name"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    validator: (String? value) {
                      return Validators.nameValidator(value);
                    },
                    controller: priceController,
                    decoration: const InputDecoration(
                      label: Text("Price"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    validator: (String? value) {
                      return Validators.nameValidator(value);
                    },
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      label: Text("Description"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(1000, 50)),
                    ),
                    onPressed: () {
                      addExpense();
                    },
                    child: const Text(
                      StringsConst.elevatedButtonText,
                      style: TextStyle(color: ColorsConst.addTextButtonColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addExpense() async {
    ExpenseProvider provider = Provider.of<ExpenseProvider>(context,listen: false);
    ExpenseInfo expenseInfo = ExpenseInfo(
      name: nameController.text,
      category: provider.currentValue,
      price: int.parse(priceController.text),
      description: descriptionController.text,
    );
    nameController.clear();
    priceController.clear();
    descriptionController.clear();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const ShowExpenseScreen();
    }));
    await ExpenseService.addExpense(expenseInfo);
  }
}
