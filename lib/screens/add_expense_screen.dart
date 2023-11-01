import 'package:expense_tracker/model/expense_info_model.dart';
import 'package:expense_tracker/screens/show_expense_screen.dart';
import 'package:expense_tracker/service/shared_pref_service.dart';
import 'package:expense_tracker/util/colors_const.dart';
import 'package:expense_tracker/util/strings_const.dart';
import 'package:expense_tracker/util/validators.dart';
import 'package:flutter/material.dart';

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
    // TODO: implement initState
    nameController = TextEditingController();
    categoryController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  String currentValue = StringsConst.currentValue;
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

  @override
  Widget build(BuildContext context) {
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
                        value: currentValue,
                        items: list.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (String? item) {
                          currentValue = item!;
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
                  // TextField(
                  //   controller: nameController,
                  //   decoration: InputDecoration(
                  //     label: const Text(StringsConst.labelNameText),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     hintText: StringsConst.hintTextName,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  // TextField(
                  //   controller: priceController,
                  //   keyboardType: TextInputType.number,
                  //   decoration: InputDecoration(
                  //     label: const Text(StringsConst.labelPriceText),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     hintText: StringsConst.hintTextPrice,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  // TextField(
                  //   controller: descriptionController,
                  //   decoration: InputDecoration(
                  //     label: const Text(StringsConst.labelDescriptionText),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     hintText: StringsConst.hintTextDescription,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
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

  // Future<void> addExpense() async {
  //   ExpenseInfo expenseInfo = ExpenseInfo(
  //     name: nameController.text,
  //     category: currentValue,
  //     price: int.parse(priceController.text),
  //     description: descriptionController.text,
  //   );
  //   nameController.clear();
  //   priceController.clear();
  //   descriptionController.clear();
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String addExp = jsonEncode(expenseInfo.toMap());
  //   List<String> expenseList =
  //       sharedPreferences.getStringList('ExpenseData') ?? [];
  //   expenseList.add(addExp);
  //   sharedPreferences.setStringList('ExpenseData', expenseList);
  // }

  Future<void> addExpense() async {
    ExpenseInfo expenseInfo = ExpenseInfo(
      name: nameController.text,
      category: currentValue,
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
