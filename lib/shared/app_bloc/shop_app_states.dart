

import 'package:sssssssshop_app/models/change_favorites_model.dart';
import 'package:sssssssshop_app/models/login_model.dart';
import 'package:sssssssshop_app/shared/login_bloc/shop_login_states.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class EditPressedState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}
class ShopSuccessHomeDataState extends ShopStates {}
class ShopErrorHomeDataState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}



///=============== categories =========================
class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}


///=============== favorites =========================
class ShopChangeFavoritesState extends ShopStates {}
class ShopSuccessChangeFavoritesState extends ShopStates {
   ChangeFavoritesModel? model;

   ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorFavoritesState extends ShopStates {}

///=============== FavoritesModel [get] =========================
class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}
class ShopLoadingGetFavoritesState extends ShopStates {}



///===============  user Model [get] =========================
class ShopSuccessUserDataState extends ShopStates {
   ShopLoginAndSettingsModel? loginModel;

   ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates {}
class ShopLoadingUserDataState extends ShopStates {}


///===============  update profile [put] =========================
class ShopSuccessUpdateUserState extends ShopStates {
   ShopLoginAndSettingsModel? loginModel;

   ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopStates {}
class ShopLoadingUpdateUserState extends ShopStates {}

///=============== FAQSModel [get] =========================
class ShopSuccessFAQSState extends ShopStates {}
class ShopErrorFAQSState extends ShopStates {}
class ShopLoadingFAQSState extends ShopStates {}




