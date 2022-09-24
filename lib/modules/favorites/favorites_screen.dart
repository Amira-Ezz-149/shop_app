import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sssssssshop_app/shared/cubit/shop_app_cubit.dart';
import 'package:sssssssshop_app/shared/cubit/shop_app_states.dart';
import 'package:sssssssshop_app/shared/constants/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is !ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildListProduct(cubit.favoritesModel!.data!.data![index].product, context),
              separatorBuilder: (context, index) => const Divider(
                  height: 1.0,
                  thickness: 1.0,
                  indent: 20.0,
                  endIndent: 20.0),
              itemCount: cubit.favoritesModel!.data!.data!.length),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
