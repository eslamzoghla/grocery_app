part of 'grocery_cubit.dart';

@immutable
abstract class GroceryState {}

class GroceryInitial extends GroceryState {}

class changeIcon extends GroceryState {}

class EditProfileSuccess extends GroceryState {}
