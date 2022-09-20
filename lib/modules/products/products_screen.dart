import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            condition: cubit.homeModel != null,
            builder: (context) => builderWidget(cubit.homeModel),
            fallback: (context) =>
                Center(child: const CircularProgressIndicator()));
      },
    );
  }

  
  

  
  Widget builderWidget(HomeModel? model) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
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
                    Text('Categories', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),),
                    const SizedBox(height: 10.0),

                    SizedBox(
                        height: 100.0,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => buildCategoryItem(), separatorBuilder: (context, index)=> SizedBox(width: 10.0), itemCount: 10)),
                    const SizedBox(height: 10.0),

                    Text('New Products', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),),

                  ],
                ),
              ),
            Container(
              color: Colors.grey.shade300,

              /// te Grid view doesn't change in any phone
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
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



  
  buildCategoryItem(){
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(image: NetworkImage('https://student.valuxapps.com/storage/uploads/categories/16301438353uCFh.29118.jpg'),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          width: 100.0,
          color: black.withOpacity(0.8),
          child: Text('Electronics',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: white),),)
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
                padding: EdgeInsets.symmetric(horizontal: 5.0),
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
                    if(model.discount != 0) Text('${model.old_price!}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 10.0, color: grey, decoration: TextDecoration.lineThrough ),
                    ),
                    const Spacer(),
                    IconButton(
                       onPressed: (){}, icon: Icon(

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
