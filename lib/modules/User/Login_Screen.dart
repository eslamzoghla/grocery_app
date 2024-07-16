import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery/models/helperClass.dart';
import 'package:grocery/cubit/grocery_cubit.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  var formKey = GlobalKey<FormState>();

  var username = 'eslam';
  var password = 'eslam123';

  @override
  Widget build(BuildContext context) {
    var cubit = GroceryCubit.get(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: width,
                        child: Image.asset(
                          'assets/images/blur_login.png',
                          // width: width / 2,
                          height: height / 5,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xB737474F),
                            fontSize: 64,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Image.asset('assets/images/login.png'),
                  ),
                ],
              ),
              Container(
                height: 270,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Username',
                          prefixIcon: Icon(Icons.person),
                          prefixIconColor: Colors.grey,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          filled: true,
                          fillColor: Color(0xffF0F1F2)),
                      controller: cubit.userNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter your username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          prefixIconColor: Colors.grey,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: _obscureText
                                ? Icon(FontAwesomeIcons.eyeSlash)
                                : Icon(FontAwesomeIcons.eye),
                          ),
                          suffixIconColor: Colors.grey,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          filled: true,
                          fillColor: Color(0xffF0F1F2)),
                      controller: cubit.passwordContrroller,
                      obscureText: _obscureText,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter your password';
                        }
                        return null;
                      },
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: width,
                      height: 50,
                      child: TextButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            bool response = await Helper.login(
                                username: cubit.userNameController.text,
                                password: cubit.passwordContrroller.text);

                            // Valid Login
                            if (response) {
                              // Login as admin
                              if (cubit.userNameController.text
                                  .endsWith('@grocery.admin')) {
                                Map<String, dynamic> adminData =
                                    await Helper.fetchAdminData(
                                        cubit.userNameController.text);
                                print(adminData);

                                // Save data in the cubit
                                cubit.fullName.text = adminData['adm_fullName'];
                                cubit.phone.text = adminData['adm_phoneNum'];
                                if (adminData['adm_img'] != null) {
                                  cubit.imageBytes =
                                      base64Decode(adminData['adm_img']);
                                }

                                Navigator.pushNamed(context, 'AdminMainPage');
                              } else {
                                //Login as user
                                print('-------------');

                                // Get all user data by its username
                                Map<String, dynamic> userData =
                                    await Helper.fetchUserData(
                                        cubit.userNameController.text);
                                print(userData);

                                // Save data in the cubit
                                cubit.fullName.text = userData['user_fullName'];
                                cubit.phone.text = userData['user_phoneNum'];
                                if (userData['user_img'] != null) {
                                  cubit.imageBytes =
                                      base64Decode(userData['user_img']);
                                }

                                // To navigate to the main user page
                                Navigator.pushNamed(context, 'MainPage');
                              }
                            }
                            // Admin => AdminMainPage, User => MainPage
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xff5EC401),
                          foregroundColor: Color(0xffffffff),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                        child: Text('Login'),
                      ),
                    ),
                    Row(
                      children: [
                        Text('Don\'t have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, 'Register');
                          },
                          child: Text('Register now'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
