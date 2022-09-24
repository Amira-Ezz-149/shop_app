


import 'package:sssssssshop_app/models/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialStatus extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopLoginAndSettingsModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorStatus extends ShopLoginStates {
  final String error;

  ShopLoginErrorStatus(this.error);
}

class IseyeShow extends ShopLoginStates {}