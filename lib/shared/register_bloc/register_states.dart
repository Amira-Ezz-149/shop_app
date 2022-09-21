



import 'package:sssssssshop_app/models/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialStatus extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopLoginAndSettingsModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorStatus extends ShopRegisterStates {
  final String error;

  ShopRegisterErrorStatus(this.error);
}

class ShopRegisterChangePasswordVisibility extends ShopRegisterStates {}