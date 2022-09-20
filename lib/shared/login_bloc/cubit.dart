

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sssssssshop_app/models/login_model.dart';
import 'package:sssssssshop_app/network/end_points.dart';
import 'package:sssssssshop_app/shared/login_bloc/states.dart';
import 'package:sssssssshop_app/shared/network/remote/dio_helper.dart';

class ShopAppLogincubit extends Cubit<ShopLoginStates> {
  ShopAppLogincubit() : super(ShopLoginInitialStatus());
  ShopLoginModel? UserModel;

  static ShopAppLogincubit get(context) => BlocProvider.of(context);

  void UserLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.PostData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      UserModel = ShopLoginModel.formjson(value.data);
      emit(ShopLoginSuccessState(UserModel!));
    }).catchError((error) {
      print('  الايرور هنا  .........');
      print(error);
      emit(ShopLoginErrorStatus(error.toString()));
    });
  }

  IconData iconData = Icons.visibility_outlined;

  bool isoscureShow = true;

  void eyeisShow() {
    iconData = isoscureShow
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    isoscureShow = !isoscureShow;
    emit(IseyeShow());
  }
}