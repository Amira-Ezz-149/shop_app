import 'package:flutter_bloc/flutter_bloc.dart';

import 'search_states.dart';

class ShopSearchCubit extends Cubit<SearchStates>{
  ShopSearchCubit() : super(ShopInitialSearchState());

}