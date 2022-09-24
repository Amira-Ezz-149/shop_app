

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sssssssshop_app/models/categories_model.dart';
import 'package:sssssssshop_app/models/change_favorites_model.dart';
import 'package:sssssssshop_app/models/faqs_model.dart';
import 'package:sssssssshop_app/models/faqs_model.dart';
import 'package:sssssssshop_app/models/faqs_model.dart';
import 'package:sssssssshop_app/models/favorites_model.dart';
import 'package:sssssssshop_app/models/login_model.dart';
import 'package:sssssssshop_app/models/shop_app_model.dart';
import 'package:sssssssshop_app/modules/categories/categories_screen.dart';
import 'package:sssssssshop_app/modules/favorites/favorites_screen.dart';
import 'package:sssssssshop_app/modules/products/products_screen.dart';
import 'package:sssssssshop_app/modules/settings/settings_screen.dart';
import 'package:sssssssshop_app/shared/network/end_points.dart';
import 'package:sssssssshop_app/shared/app_bloc/shop_app_states.dart';
import 'package:sssssssshop_app/shared/constants/constants.dart';
import 'package:sssssssshop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  //change Bottom nav bar
  int currentIndex = 0;
  // Color? color = Colors.grey[300];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }


  // App Screens
  List<Widget> Screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data!.products) {
        favorites.addAll({element.id : element.infavorites});
      }
      // print('===== *************************** ======');
      //  print('from home model the value is ${favorites.toString()}');

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState());
    });
  }

///=============================== categories model ==========================
///============================================================================
  CategoriesModel? categoriesModel;

  void getCategories()
  {
    DioHelper.getData(
      url: GET_CATEGORIES,
      // token: token,
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // print('===== ********************************** ======');
      // print('from categories model the value is ${value.toString()}');
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }


///=============================== favorites model [post] ==========================
///============================================================================

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int? productId) {
    favorites[productId!] != favorites[productId];
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
            url: FAVORITES,

            /// data is a map that is found in the body on post man
            data: {
            'product_id': productId},
            token: token,
    )
        .then((value) {
          changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
          if(!changeFavoritesModel!.status!){
            favorites[productId] != favorites[productId];
          }else{
            getFavorites();
          }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] != favorites[productId];
      emit(ShopErrorFavoritesState());
    });
  }

  ///=============================== favorites model [get] ==========================
  ///============================================================================


  FavoritesModel? favoritesModel;
  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
       token: token,
    ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value.data);
      // print('===== ************************************************************************ ======');
      // print('from get Favorites model the value is ${value.data.toString()}');
      // print('===== ************************************************************************ ======');
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }


  ///=============================== settings model [get] ==========================
  ///============================================================================


  ShopLoginAndSettingsModel? userModel;
  void getUserData()
  {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
       token: token,
    ).then((value)
    {
      userModel = ShopLoginAndSettingsModel.fromJson(value.data);
      // print('===== ************************************************************************ ======');
      // print('from get Favorites model the value is ${userModel!.data!.name}');
      // print('===== ************************************************************************ ======');
      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  ///=============================== update user data [put] ==========================
  ///============================================================================

  void updateUserData({
        required String? name,
        required String? phone,
        required String? email}) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data: {
          'name' : name,
          'email' : email,
          'phone' : phone
        }
    ).then((value) {
      userModel = ShopLoginAndSettingsModel.fromJson(value.data);
      // print(
      //     '===== ************************************************************************ ======');
      // print('from put update the value is ${userModel!.data!.name}');
      // print(
      //     '===== ************************************************************************ ======');
      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }

  ///=============================== FAQS model [get] ==========================
  ///============================================================================

  FAQSModel? faqsModel;

  void getFAQS()
  {
    emit(ShopLoadingFAQSState());
    DioHelper.getData(
      url: FAQS,
      token: token,
    ).then((value)
    {
      faqsModel = FAQSModel.fromJson(value.data);
      print('===== ************************************************************************ ======');
      print('from get FAQS model the value is ${value.toString()}');
      print('===== ************************************************************************ ======');
      emit(ShopSuccessFAQSState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorFAQSState());
    });
  }


}
