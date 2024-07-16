import 'package:flutter/material.dart';
import 'package:grocery/models/categories.dart';
import 'package:grocery/shared/components/components.dart';
import 'package:grocery/shared/components/custom_button.dart';
import 'package:grocery/shared/styles/colors.dart';
import 'package:grocery/models/helperClass.dart';

class ItemCategory extends StatefulWidget {
  const ItemCategory({Key? key});

  @override
  State<ItemCategory> createState() => _ItemCategoryState();
}

class _ItemCategoryState extends State<ItemCategory> {
  final _formKey = GlobalKey<FormState>();
  var old_price = TextEditingController();
  var new_price = TextEditingController();
  bool val = false;

  List<Categories> categories = [];

  List categories_db = [];

  Future readCategories() async {
    List response = await Helper.getCategory();
    categories_db.addAll(response);

    for (int i = 0; i < categories_db.length; i++) {
      categories.add(Categories(name: categories_db[i]['category']));
    }

    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Get data from the previous page
    final arg = ModalRoute.of(context)!.settings.arguments as Map;

    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          'Price',
          style: TextStyle(
            color: Color(0xff37474F),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.close,
              size: 24,
              color: Color(0xff37474F),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 170,
                      child: itemField(
                        control: old_price,
                        keyboard: TextInputType.number,
                        hint: 'Old Price',
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the old price';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 11,
                      height: 30,
                      child: Text(
                        '_',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: semiBlack,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 170,
                      child: itemField(
                        control: new_price,
                        hint: 'New Price',
                        keyboard: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 33,
                ),
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: semiBlack,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  height: height - 355,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) => Material(
                      color: const Color(0xffE5E5E5),
                      child: CheckboxListTile(
                        activeColor: green,
                        checkboxShape: const OvalBorder(),
                        shape: const UnderlineInputBorder(),
                        title: (!categories[index].check)
                            ? Text(categories[index].name)
                            : Text(
                                categories[index].name,
                                style: const TextStyle(
                                  color: Color(0xff5EC401),
                                ),
                              ),
                        value: categories[index].check,
                        onChanged: (bool? va) {
                          //print(categories_db[index]['cat_id']);
                          arg['cat_id'] = categories_db[index]['cat_id'];
                          arg['prod_old_price'] = old_price.text;
                          arg['prod_new_price'] = new_price.text;
                          print(arg['prod_old_price']);
                          print(arg['prod_new_price']);
                          categories[index].check = va!;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButtom(
                  text: 'Preview',
                  icon: const Icon(Icons.arrow_forward),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Perform the next step logic
                      Navigator.pushNamed(context, 'SaveScreen',
                          arguments: arg);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
