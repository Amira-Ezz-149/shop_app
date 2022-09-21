import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sssssssshop_app/models/favorites_model.dart';
import 'package:sssssssshop_app/shared/app_bloc/shop_app_cubit.dart';
import 'package:sssssssshop_app/shared/app_bloc/shop_app_states.dart';
import 'package:sssssssshop_app/shared/styles/colors.dart';

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
              itemBuilder: (context, index) => buildFavItem(cubit.favoritesModel!.data!.data![index], context),
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
  Widget buildFavItem(FavoritesData? model, context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: SizedBox(
      height: 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model!.product!.image!),
                width: 120.0,
                height: 120.0,
              ),

              if(model.product!.discount! != 0) Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                color: red,
                child: const Text('DISCOUNT',  style: TextStyle(color: white, fontSize: 10.0),),
              )
            ],
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.product!.name!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Spacer(),
                Row(
                  children: [
                    Text('${model.product!.price!}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 12.0, color: defaultColor),
                    ),
                    const SizedBox(width: 5.0,),
                    if(model.product!.discount! != 0) Text('${model.product!.oldPrice!}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 10.0, color: grey, decoration: TextDecoration.lineThrough ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: ShopCubit.get(context).favorites[model.product!.id]! ? defaultColor: grey,
                      child: IconButton(
                          onPressed: (){
                             ShopCubit.get(context).changeFavorites(model.product!.id);
                          }, icon: const Icon(
                        Icons.favorite_border,
                        size: 20.0,
                        color: white,
                      )),
                    )
                  ],
                ),

              ],
            ),
          ),

        ],
      ),
    ),
  );
}
