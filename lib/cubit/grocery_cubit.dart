import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'dart:typed_data';

part 'grocery_state.dart';

class GroceryCubit extends Cubit<GroceryState> {
  GroceryCubit() : super(GroceryInitial());

  static GroceryCubit get(context) => BlocProvider.of(context);

  var userNameController = TextEditingController();
  var passwordContrroller = TextEditingController();
  var fullName = TextEditingController();
  var phone = TextEditingController();
  Uint8List? imageBytes;
  var formKey = GlobalKey<FormState>();
  bool press = true;
  var dateControler = TextEditingController();
  var timeControler = TextEditingController();
  var timeControler1 = TextEditingController();
  var formkey1 = GlobalKey<FormState>();

  void icon() {
    press = !press;
    emit(changeIcon());
  }
}
