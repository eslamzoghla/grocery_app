import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/models/helperClass.dart';
import 'package:grocery/shared/components/constants.dart';
import '../../cubit/grocery_cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class AdminCategory extends StatefulWidget {
  const AdminCategory({Key? key}) : super(key: key);

  @override
  State<AdminCategory> createState() => _CategoriesState();
}

class _CategoriesState extends State<AdminCategory> {
  var category = TextEditingController();

  List categories = [];

  Future readCategories() async {
    List response = await Helper.getCategory();
    categories.addAll(response);

    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readCategories();
    super.initState();
  }

  //dialog
  @override
  Widget build(BuildContext context) {
    // var cubit = GroceryCubit.get(context);
    var height = MediaQuery.sizeOf(context).height;

    return BlocConsumer<GroceryCubit, GroceryState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            titleSpacing: 5,
            // toolbarHeight: 0.0,
            elevation: 0.0,
            backgroundColor: white,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: white, systemNavigationBarColor: white),
            leading: Icon(
              Icons.arrow_back,
              color: black,
            ),
            title: Text(
              'Categories',
              style: TextStyle(
                  color: semiBlack, fontSize: 20, fontWeight: Semi_bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                SizedBox(
                  height: height / 30,
                ),
                SingleChildScrollView(
                  child: Container(
                    height: height / 1.4,
                    child: ListView.separated(
                        // physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => buildRow(
                              category_name: categories[index]['category'],
                              width: MediaQuery.sizeOf(context).width,
                              function: () => _delete(context, index),
                              function2: () =>
                                  open_updateCategory(context, index),
                            ),
                        separatorBuilder: (context, index) => Column(
                              children: [
                                SizedBox(
                                  height: height / 30,
                                ),
                                Divider(
                                  color: black.withOpacity(0.3),
                                ),
                                SizedBox(
                                  height: height / 30,
                                ),
                              ],
                            ),
                        itemCount: categories.length),
                  ),
                ),
                SizedBox(
                  height: height / 30,
                ),
                Button1(
                    text: 'Add New Category',
                    icon: Icons.add,
                    pressButton: () {
                      return open_AddNewCategory(context);
                    }),
                SizedBox(
                  height: height / 60,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ////dialog/////////
  void _delete(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to remove the category?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () async {
                    //Yes
                    int response = await Helper.deleteCategory(
                        cat_id: categories[index]['cat_id']);
                    if (response > 0) {
                      categories = [];
                      readCategories();
                    }

                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }

  //add new category
  void open_AddNewCategory(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              height: 450,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                        key: GroceryCubit.get(context).formKey,
                        child: itemField(
                          hint: 'Enter category name',
                          control: category,
                          keyboard: TextInputType.text,
                          prefix: Icons.fastfood_rounded,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'category name must not be empty';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: 200,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (GroceryCubit.get(context)
                                .formKey
                                .currentState!
                                .validate()) {
                              int respnse = await Helper.addCategory(
                                  category: category.text);
                              if (respnse > 0) {
                                category.text = '';
                                categories = [];
                                readCategories();
                                _successMessage(context);
                              }
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: green,
                          ),
                          child: Text(
                            'save',
                            style: TextStyle(fontSize: 20, color: white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  //add new category
  void open_updateCategory(BuildContext ctx, int index) {
    category.text = categories[index]['category'];
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              height: 450,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                        key: GroceryCubit.get(context).formKey,
                        child: itemField(
                          hint: 'Enter category name',
                          control: category,
                          keyboard: TextInputType.text,
                          prefix: Icons.fastfood_rounded,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'category name must not be empty';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: 200,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (GroceryCubit.get(context)
                                .formKey
                                .currentState!
                                .validate()) {
                              int respnse = await Helper.updateCategory(
                                  cat_id: categories[index]['cat_id'],
                                  category: category.text);
                              if (respnse > 0) {
                                category.text = '';
                                categories = [];
                                readCategories();
                                _successMessage(context);
                              }
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: green,
                          ),
                          child: Text(
                            'save',
                            style: TextStyle(fontSize: 20, color: white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  _successMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.check_circle,
                    color: green,
                    size: 40,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Categories updated successfully",
                        style: TextStyle(fontSize: 18, color: white),
                      ),
                    ],
                  ))
                ],
              ),
              height: 80,
              decoration: BoxDecoration(
                  color: semiBlack, borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 3,
    ));
  }
}
