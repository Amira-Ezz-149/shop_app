

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sssssssshop_app/models/login_model.dart';
import 'package:sssssssshop_app/network/end_points.dart';
import 'package:sssssssshop_app/shared/login_bloc/states.dart';
import 'package:sssssssshop_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialStatus());
  ShopLoginModel? userModel;

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      userModel = ShopLoginModel.formjson(value.data);
      emit(ShopLoginSuccessState(userModel!));
    }).catchError((error) {
      print('  الايرور هنا  .........');
      print(error);
      emit(ShopLoginErrorStatus(error.toString()));
    });
  }

  IconData iconData = Icons.visibility_outlined;

  bool isoscureShow = true;

  void changePasswordVisibility() {
    iconData = isoscureShow
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    isoscureShow = !isoscureShow;
    emit(IseyeShow());
  }
}