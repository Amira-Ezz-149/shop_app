

import 'package:sssssssshop_app/models/change_favorites_model.dart';

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
class ShopSuccessUserDataState extends ShopStates {}

class ShopErrorUserDataState extends ShopStates {}
class ShopLoadingUserDataState extends ShopStates {}



