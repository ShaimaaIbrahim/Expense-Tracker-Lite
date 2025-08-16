import 'dart:io';

import 'package:expense_tracker_lite/core/constants/app_colors.dart';
import 'package:expense_tracker_lite/core/network/api_endpoints.dart';
import 'package:expense_tracker_lite/core/network/network_manager.dart';
import 'package:expense_tracker_lite/core/ui/custom_button.dart';
import 'package:expense_tracker_lite/core/ui/custom_dropdown.dart';
import 'package:expense_tracker_lite/data/data_source/remote/currency_conversion_data_source.dart';
import 'package:expense_tracker_lite/data/repositories/currency_repository.dart';
import 'package:expense_tracker_lite/domain/repository/currency_repository.dart';
import 'package:expense_tracker_lite/features/add_expense/views/widgets/category_card.dart';
import 'package:expense_tracker_lite/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/ui/custom_text.dart';
import '../../../../core/ui/custom_text_form_field.dart';
import '../../../../core/ui/space.dart';
import '../../../../data/models/category_model.dart';
import '../../../../domain/entities/expence.dart';
import '../../view_models/expense_bloc.dart';
import '../../view_models/expense_event.dart';
import '../../view_models/expense_stata.dart';
import 'package:uuid/uuid.dart';

class AddExpenseScreen extends HookWidget {
   AddExpenseScreen({super.key});
   
   final ImagePicker _picker = ImagePicker();
   final _formKey = GlobalKey<FormState>();
   final _amountController = TextEditingController();

   @override
  Widget build(BuildContext context) {
    var isLoading= useState(false); 
    var category = useState(Category.predefinedCategories[0]);
    var selected = useState(-1);
    
    var currency = useState("USD");
    
    var catName = useState(Category.predefinedCategories[0].name);
    final selectedDate = useState(DateTime.now());
    final imageFile = useState(File(""));
    Future<void> pickImage(ImageSource source) async {
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
          maxWidth: 1800,
          maxHeight: 1800,
        );

        if (pickedFile != null) {
          imageFile.value = File(pickedFile.path);
        }
      } catch (e) {
        print("Image picker error: $e");
      }
    }
    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (picked != null && picked != selectedDate) {
        selectedDate.value = picked;
      }
    }
     return Scaffold(
       appBar: AppBar(title: const Text('Add Expense'),
           backgroundColor: Colors.transparent,
           elevation: 0.0,
           titleTextStyle: TextStyle(fontWeight: FontWeight.bold, color: AppColors.darkBackground, fontSize: 20)
       ),
       body: SingleChildScrollView(
         padding: const EdgeInsets.all(16),
         child: Form(
           key: _formKey,
           child: BlocListener<ExpenseBloc, ExpenseState>(
             listener: (ctx, state){
               if (state is ExpenseError) {
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text(state.message)),
                 );
               } else if (state is ExpenseLoaded) {
                 Navigator.pop(context, true);
               }
             },
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 // Dropdown Currencies Section
                 CustomText(
                   'Categories',
                   letterSpacing: 1.5,
                   height: 1.8,
                   fontWeight: FontWeight.bold,
                   fontSize: 18,
                 ),
                 const SizedBox(height: 5),
                 CustomDropdown<String>(
                     items: Category.predefinedCategories.map((Category cat) => cat.name).toList(),
                     onChanged: (category){
                       catName.value = category ?? "";
                     },
                     value: Category.predefinedCategories[0].name,
                     fillColor: AppColors.categoryBackground),
                 Space(height: 10),
                 CustomText(
                   'Currencies',
                   letterSpacing: 1.5,
                   height: 1.8,
                   fontWeight: FontWeight.bold,
                   fontSize: 18,
                 ),
                 const SizedBox(height: 5),
                 CustomDropdown<String>(
                     items: ["EUR", "USD", "GBP", "JPY", "AUD"],
                     onChanged: (cur){
                       currency.value = cur ?? "";
                     },
                     value: currency.value,
                     fillColor: AppColors.categoryBackground),
                 Space(height: 10),
                 // TextFiled Amount Section
                 CustomText(
                   'Amount',
                   letterSpacing: 1.5,
                   height: 1.8,
                   fontWeight: FontWeight.bold,
                   fontSize: 18,
                 ),
                 const SizedBox(height: 5),
                 CustomTextField(
                     hintText: "\$50,000",
                     fillColor: AppColors.categoryBackground,
                     controller: _amountController),
                 Space(height: 10),
                 // TextFiled Amount Section
                 CustomText(
                   'Date',
                   letterSpacing: 1.5,
                   height: 1.8,
                   fontWeight: FontWeight.bold,
                   fontSize: 18,
                 ),
                 const SizedBox(height: 5),
                 CustomTextField(
                     hintText: "${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}",
                     readOnly: true,
                     suffixIcon: InkWell(
                       onTap: () {
                         selectDate(context);
                       },
                       child: const Icon(Icons.calendar_today, color: Colors.black),
                     ),
                     enabled: true),
                 Space(height: 10),
                 // TextFiled Attach Receiept
                 CustomText(
                   'Attach Receiept',
                   letterSpacing: 1.5,
                   height: 1.8,
                   fontWeight: FontWeight.bold,
                   fontSize: 18,
                 ),
                 const SizedBox(height: 5),
                 CustomTextField(
                     hintText: "Upload Image",
                     readOnly: true,
                     suffixIcon: InkWell(
                       onTap: () {
                         pickImage(ImageSource.gallery);
                       },
                       child: const Icon(Icons.upload_file, color: Colors.black),
                     )
                 ),
                 const SizedBox(height: 16),
                 //Categories Section
                 CustomText(
                   'Categories',
                   letterSpacing: 1.5,
                   height: 1.8,
                   fontWeight: FontWeight.bold,
                   fontSize: 20,
                 ),
                 //const SizedBox(height: 16),
                 SizedBox(
                     height: 190,
                     child: GridView.builder(
                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 4,
                         ),
                         itemCount: Category.predefinedCategories.length,
                         itemBuilder: (BuildContext context, int index) {
                           return InkWell(
                               onTap: (){
                                 category.value = Category.predefinedCategories[index];
                                 selected.value = index;
                                 },
                               child: CategoryCard(
                                 selected: selected.value == index,
                                 icon: Category.predefinedCategories[index].icon,
                                 bg: index== Category.predefinedCategories.length-1 ? null: Category.predefinedCategories[index].color,
                                 text: Category.predefinedCategories[index].name,
                                 iconColor: Category.predefinedCategories[index].iconColor,
                               )
                           );
                         }
                     )
                 ),
                 Space(height: 10),
                 // Save Button
                 BlocBuilder<ExpenseBloc, ExpenseState>(
                     builder: (context, state) {
                       return isLoading.value ? Center(child: CircularProgressIndicator()) :CustomButton(
                         text: "Save",
                         color: AppColors.primaryColor,
                         textSize: 20,
                         onPressed: () {
                           if (_formKey.currentState!.validate()) {
                             isLoading.value = true;
                             final expense = Expense(
                               id: Uuid().v4(),
                               category: category.value,
                               amount: double.parse(_amountController.text),
                               date: selectedDate.value,
                               receiptPath: imageFile.value.path,
                             );
                             final remoteDataSource = CurrencyRemoteDataSourceImp(NetworkManager(baseUrl: ApiEndpoints.baseUrl));
                             final repository = CurrencyRepositoryImp(remoteDataSource: remoteDataSource);
                             repository.convertCurrency(currency.value, _amountController.text).then((data){
                               expense.originalAmount = double.parse(_amountController.text);
                               expense.convertedAmount = data.result["USD"];
                               context.read<ExpenseBloc>().add(AddExpenseEvent(expense));
                               isLoading.value = false;
                             }).onError((_, __){
                                isLoading.value = false;
                             });
                           }
                         },
                       );
                     })
               ],
             )
           ),
         )
       ),
     );
  }
}

