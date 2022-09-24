import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sssssssshop_app/shared/cubit/shop_app_cubit.dart';
import 'package:sssssssshop_app/shared/constants/components.dart';
import 'package:sssssssshop_app/shared/search_cubit/seach_cubit.dart';
import 'package:sssssssshop_app/shared/search_cubit/search_states.dart';
import 'package:sssssssshop_app/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopSearchCubit cubit = ShopSearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(backgroundColor: defaultColor,),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'enter text to search';
                        }
                        return null;
                      },
                      onSubmit: (String? text) {
                        cubit.search(text);
                      },
                      label: 'Search',
                      prefix: Icons.search,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),

                    const SizedBox(
                      height: 20.0),
                    if(state is ShopSearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildSearchItem(cubit.model!.data!.data![index], context),
                          separatorBuilder: (context, index) => const Divider(
                              height: 1.0,
                              thickness: 1.0,
                              indent: 20.0,
                              endIndent: 20.0),
                          itemCount: cubit.model!.data!.data!.length),
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchItem( model, context) => Padding(
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
                image: NetworkImage(model!.image!),
                width: 120.0,
                height: 120.0,
              ),

              if(model.discount != 0) Container(
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
                Text(model.name!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const Spacer(),
                Row(
                  children: [
                    Text('${model.price!}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 12.0, color: defaultColor),
                    ),
                    const SizedBox(width: 5.0,),
                    // if(model.discount! != 0) Text('${model.oldPrice!}',
                    //   overflow: TextOverflow.ellipsis,
                    //   maxLines: 2,
                    //   style: const TextStyle(fontSize: 10.0, color: grey, decoration: TextDecoration.lineThrough ),
                    // ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defaultColor: grey,
                      child: IconButton(
                          onPressed: (){
                            ShopCubit.get(context).changeFavorites(model.id);
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
