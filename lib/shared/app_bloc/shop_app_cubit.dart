

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sssssssshop_app/models/categories_model.dart';
import 'package:sssssssshop_app/models/shop_app_model.dart';
import 'package:sssssssshop_app/modules/categories/categories_screen.dart';
import 'package:sssssssshop_app/modules/favorites/favorites_screen.dart';
import 'package:sssssssshop_app/modules/products/products_screen.dart';
import 'package:sssssssshop_app/modules/settings/settings_screen.dart';
import 'package:sssssssshop_app/network/end_points.dart';
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

/*
  bool? Icontogel;

  // Bottom nav bar Icons theme
  final iconData = [
    const Icon(
      Icons.home,
      size: 30.0,
      color: Colors.black,
    ),
    const Icon(
      Icons.category,
      size: 30.0,
      color: Colors.black,
    ),
    const Icon(
      Icons.favorite,
      size: 30.0,
      color: Colors.black,
    ),
    const Icon(
      Icons.settings,
      size: 30.0,
      color: Colors.black,
    ),
  ];
*/

  // App Screens
  List<Widget> Screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  // // method get home Data
  // IconData? FavIcon;
  // Map<int, bool> favorite = {};
  // Map<int, bool> InCart = {};


  HomeModel? homeModel;

  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);
      print('===== *************************** ======');
      print('from home model the value is ${value.data}');

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
      print('===== ********************************** ======');
      print('from categories model the value is ${value.toString()}');
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }




}
