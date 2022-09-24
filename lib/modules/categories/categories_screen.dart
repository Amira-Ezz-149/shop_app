import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sssssssshop_app/models/categories_model.dart';
import 'package:sssssssshop_app/shared/cubit/shop_app_cubit.dart';
import 'package:sssssssshop_app/shared/cubit/shop_app_states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        ShopCubit cubit = ShopCubit.get(context);
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildCatItem(cubit.categoriesModel!.data!.data![index]),
            separatorBuilder: (context, index) => const Divider(
                height: 1.0,
                thickness: 1.0,
                indent: 20.0,
                endIndent: 20.0),
            itemCount: cubit.categoriesModel!.data!.data!.length);
      },
    );

  }

  Widget buildCatItem(DataModel? model) => Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
        Image(image: NetworkImage(model!.image!),
          height: 100,
          width: 100,
        ),
        const SizedBox(width: 20.0,),
        Text(model.name!, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
        const Spacer(),
        IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios))
      ],),
  );
}
