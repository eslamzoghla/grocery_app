import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:grocery/shared/components/components.dart';
import 'package:grocery/shared/components/custom_button.dart';
import 'package:grocery/shared/styles/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class AddItem extends StatefulWidget {
  const AddItem({Key? key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  List<Uint8List?> list = [];
  var product_name = TextEditingController();
  var product_amount = TextEditingController();
  var product_brand = TextEditingController();
  /*
  File? _image;
  final _picker = ImagePicker();

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        list.add(_image!);
        print(_image);
      });
    }
  }
  */

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();

      setState(() {
        list.add(imageBytes);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Add an item',
          style: TextStyle(
            color: semiBlack,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 18,
          left: 16,
          right: 16,
          bottom: 34,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                itemField(
                  control: product_name,
                  hint: 'Product Name',
                  prefix: (Icons.shopping_basket_outlined),
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the product name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.0),
                itemField(
                  control: product_amount,
                  hint: 'Amount',
                  prefix: (Icons.production_quantity_limits_outlined),
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the amount';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.0),
                itemField(
                  control: product_brand,
                  hint: 'Brand (Optional)',
                  prefix: (Icons.label_outline),
                ),
                const SizedBox(
                  height: 26,
                ),
                for (int i = 0; i < list.length; i++) Card(i),
                DottedBorder(
                  color: semiBlack,
                  dashPattern: const [5, 5],
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      color: const Color(0xffF0F1F2),
                      width: width - 40,
                      height: 181,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_a_photo_outlined,
                            size: 62,
                          ),
                          SizedBox(
                            height: 23,
                          ),
                          Text(
                            'Upload Images here',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: semiBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                (list.isEmpty)
                    ? SizedBox(
                        height: height - 690,
                      )
                    : const SizedBox(
                        height: 56,
                      ),
                CustomButtom(
                  text: 'Next',
                  icon: const Icon(Icons.arrow_forward),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushNamed(context, 'ItemCategory', arguments: {
                        'prod_name': product_name.text,
                        'prod_amount': product_amount.text,
                        'prod_brand': product_brand.text,
                        'product_images': list
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Card(int i) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 26),
          child: ClipRRect(
            child: Image.memory(list[i]!),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              setState(() {
                list.removeAt(i);
              });
            },
            icon: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(255, 85, 82, 0.14),
              ),
              child: const Icon(
                Icons.close_sharp,
                color: Color(0xffFF5552),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
