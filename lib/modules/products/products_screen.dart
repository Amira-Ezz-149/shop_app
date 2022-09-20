import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sssssssshop_app/models/categories_model.dart';
import 'package:sssssssshop_app/models/shop_app_model.dart';
import 'package:sssssssshop_app/shared/app_bloc/shop_app_cubit.dart';
import 'package:sssssssshop_app/shared/app_bloc/shop_app_states.dart';
import 'package:sssssssshop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.homeModel != null || cubit.categoriesModel != null ,
            builder: (context) => builderWidget(cubit.homeModel, cubit.categoriesModel),
            fallback: (context) =>
               const Center(child: CircularProgressIndicator()));
      },
    );
  }

  
  

  
  Widget builderWidget(HomeModel? model,CategoriesModel? categoriesModel) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model!.data!.banners
                    .map((e) => Image(
                          image: NetworkImage(e.image!),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 200.0,
                  viewportFraction: 1.0,
                  initialPage: 0,
                  reverse: false,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                )),
           const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Categories', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),),
                    const SizedBox(height: 10.0),

                    SizedBox(
                        height: 100.0,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => buildCategoryItem(categoriesModel!.data!.data![index]),
                            separatorBuilder: (context, index)=> const SizedBox(width: 10.0), itemCount: categoriesModel!.data!.data!.length)),
                    const SizedBox(height: 10.0),

                   const Text('New Products', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),),

                  ],
                ),
              ),
            Container(
              color: Colors.grey.shade300,

              /// te Grid view doesn't change in any phone
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,

                /// control top and bottom
                mainAxisSpacing: 1.0,

                /// control right and left
                crossAxisSpacing: 1.0,

                /// width / height
                childAspectRatio: 1/1.69,
                children: List.generate(
                    model.data!.products.length,
                    (index) =>
                        buildGridProduct(model: model.data!.products[index])),
              ),
            )
          ],
        ),
  );



  
  buildCategoryItem(DataModel? dataModel){
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(image: NetworkImage(dataModel!.image!),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          width: 100.0,
          color: black.withOpacity(0.8),
          child: Text(dataModel.name!,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: white),),)
      ],
    );
  }

  Widget buildGridProduct({required ProductModel model}) {
    return Container(
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image!),
                width: double.infinity,
                height: 200.0,
              ),

              if(model.discount != 0) Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                color: red,
                child: const Text('DISCOUNT',  style: TextStyle(color: white, fontSize: 10.0),),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.name!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    Text('${model.price!} \$',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 12.0, color: defaultColor),
                    ),
                    const SizedBox(width: 5.0,),
                    if(model.discount != 0) Text('${model.oldPrice!}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 10.0, color: grey, decoration: TextDecoration.lineThrough ),
                    ),
                    const Spacer(),
                    IconButton(
                       onPressed: (){}, icon: const Icon(
                      Icons.favorite_border, size: 20.0,))
                  ],
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
