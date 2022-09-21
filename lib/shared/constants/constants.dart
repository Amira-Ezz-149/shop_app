import 'package:flutter/material.dart';
import 'package:sssssssshop_app/modules/login/login.dart';
import 'package:sssssssshop_app/shared/app_bloc/shop_app_cubit.dart';
import 'package:sssssssshop_app/shared/constants/components.dart';
import 'package:sssssssshop_app/shared/network/local/cache_helper.dart';

dynamic token = '';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}