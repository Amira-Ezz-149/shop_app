

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sssssssshop_app/models/login_model.dart';
import 'package:sssssssshop_app/shared/network/end_points.dart';
import 'package:sssssssshop_app/shared/login_bloc/shop_login_states.dart';
import 'package:sssssssshop_app/shared/network/remote/dio_helper.dart';
import 'package:sssssssshop_app/shared/register_bloc/register_states.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialStatus());
  ShopLoginAndSettingsModel? userModel;

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    }).then((value) {
      userModel = ShopLoginAndSettingsModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(userModel!));
    }).catchError((error) {
      print('  الايرور هنا  .........');
      print(error);
      emit(ShopRegisterErrorStatus(error.toString()));
    });
  }

  IconData iconData = Icons.visibility_outlined;

  bool isPassword = true;

   void changeRegisterPasswordVisibility() {
    iconData = isPassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    isPassword = !isPassword;
    emit(ShopRegisterChangePasswordVisibility());
  }
}