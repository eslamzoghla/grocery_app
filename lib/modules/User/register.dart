import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/grocery_cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import 'package:grocery/models/helperClass.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = GroceryCubit.get(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return BlocConsumer<GroceryCubit, GroceryState>(
      listener: (context, state) {
        if (state is changeIcon) {
          print('icon changed');
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            toolbarHeight: 0.0,
            elevation: 0.0,
            backgroundColor: white.withOpacity(1),
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: white, systemNavigationBarColor: white),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: cubit.formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    // buildSizedBox(height/20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 64, color: semiBlack.withOpacity(0.6)),
                        ),
                      ],
                    ),
                    Container(
                      width: width / 1.5,
                      height: height / 4,
                      child: const Image(
                          image: AssetImage('assets/images/register.png'),
                          fit: BoxFit.contain),
                    ),
                    buildSizedBox(height),
                    itemField(
                      hint: 'Username',
                      prefix: Icons.email,
                      keyboard: TextInputType.emailAddress,
                      control: cubit.userNameController,
                      validate: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!)) {
                          return 'Enter a valid Email';
                        }
                        return null;
                      },
                    ),
                    buildSizedBox(height / 1.5),
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
                    buildSizedBox(height / 1.5),
                    itemField(
                      hint: 'Full name',
                      prefix: Icons.person,
                      keyboard: TextInputType.text,
                      control: cubit.fullName,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Your name must not be empty';
                        }
                        return null;
                      },
                    ),
                    buildSizedBox(height / 1.5),
                    itemField(
                      hint: 'Phone number',
                      prefix: Icons.phone,
                      keyboard: TextInputType.phone,
                      control: cubit.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'phone must not be empty';
                        }
                        if (value!.length != 11) {
                          return 'phone must be 11 number';
                        }
                        return null;
                      },
                    ),
                    buildSizedBox(height),
                    Button1(
                      text: 'Register',
                      pressButton: () async {
                        if (cubit.formKey.currentState!.validate()) {
                          int response = await Helper.userRegister(
                              user_username: cubit.userNameController.text,
                              user_fullName: cubit.fullName.text,
                              user_password: cubit.passwordContrroller.text,
                              user_phoneNum: cubit.phone.text);
                            
                            if(response>0){
                              Navigator.pushNamed(context, 'MainPage');
                            }else{

                            }
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildSizedBox(double height) => SizedBox(
        height: height / 30,
      );
}
