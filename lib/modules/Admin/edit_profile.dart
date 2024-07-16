import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/cubit/grocery_cubit.dart';
import 'package:grocery/shared/components/components.dart';
import 'package:grocery/shared/components/custom_button.dart';
import 'package:grocery/shared/styles/colors.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:grocery/models/helperClass.dart';

class AdminEditProfile extends StatefulWidget {
  AdminEditProfile({super.key});

  @override
  _AdminEditProfileState createState() => _AdminEditProfileState();
}

class _AdminEditProfileState extends State<AdminEditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String fullName = '';
  String password = '';
  String phoneNumber = '';
  bool showPassword = false;

  Uint8List? imageBytes; //To store image from image picker

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();

      setState(() {
        this.imageBytes = imageBytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var cubit = GroceryCubit.get(context);
    return BlocConsumer<GroceryCubit, GroceryState>(
      listener: (context, state) {
        if (state is changeIcon) {
          print('icon changed');
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Edit Profile',
              style: TextStyle(
                color: semiBlack,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: semiBlack,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(
              top: 11.0,
              bottom: 34,
              right: 16,
              left: 16,
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        if (cubit.imageBytes != null || imageBytes != null)
                          Container(
                            width: 175,
                            height: 175,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: MemoryImage(
                                    imageBytes ??= cubit.imageBytes!),
                              ),
                            ),
                          )
                        else
                          CircleAvatar(
                              radius: 87, backgroundColor: Colors.green),
                        Positioned(
                          top: 136,
                          left: 122,
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.deepOrange,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.photo_camera_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _pickImage();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    itemField(
                      hint: 'Full Name',
                      control: cubit.fullName,
                      prefix: Icons.account_circle_outlined,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                      onsave: (value) {
                        fullName = value!;
                      },
                    ),
                    SizedBox(height: 20.0),
                    itemField(
                      hint: 'Password',
                      prefix: Icons.lock,
                      keyboard: TextInputType.text,
                      control: cubit.passwordContrroller,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'password must not be empty';
                        }
                        if (value!.length < 8) {
                          return 'password is shorter than 8';
                        }
                        return null;
                      },
                      isobscure: cubit.press,
                      suffix: cubit.press
                          ? Icons.remove_red_eye
                          : Icons.visibility_off,
                      pressed: () {
                        cubit.icon();
                      },
                    ),
                    SizedBox(height: 20.0),
                    itemField(
                      hint: 'Phone Number',
                      control: cubit.phone,
                      keyboard:
                          TextInputType.phone, // Set keyboardType to phone
                      prefix: Icons.call_outlined,

                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (value.length < 11) {
                          return 'Invalid phone number';
                        }
                        return null;
                      },
                      onsave: (value) {
                        phoneNumber = value!;
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    CustomButtom(
                      text: 'Save',
                      icon: Icon(Icons.save_outlined),
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          // Apply changes
                          int response = await Helper.editAdminProfile(
                              adm_username: cubit.userNameController.text,
                              adm_fullName: cubit.fullName.text,
                              adm_password: cubit.passwordContrroller.text,
                              adm_phoneNum: cubit.phone.text,
                              imageBytes: imageBytes);

                          // Update cubic data if success
                          if (response > 0) {
                            cubit.imageBytes = this.imageBytes;
                            this.imageBytes = null;

                            Navigator.pushNamedAndRemoveUntil(
                                context, "AdminMoreScreen", (route) => true);
                            print('Successfuly updated');
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
