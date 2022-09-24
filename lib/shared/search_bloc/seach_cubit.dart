import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sssssssshop_app/models/search_model.dart';
import 'package:sssssssshop_app/shared/constants/constants.dart';
import 'package:sssssssshop_app/shared/network/end_points.dart';
import 'package:sssssssshop_app/shared/network/remote/dio_helper.dart';

import 'search_states.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates>{
  ShopSearchCubit() : super(ShopInitialSearchState());
  static ShopSearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String? text) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(
      token: token,
      url: SEARCH,

      /// we put here the data in the body in the post man
      data: {'text': text},
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessState());
    }).catchError((error) {
      print('*********** error from search method ****************** $error');
      emit(ShopSearchErrorState());
    });
  }

}