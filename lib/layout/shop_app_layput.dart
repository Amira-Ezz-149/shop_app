
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sssssssshop_app/shared/app_bloc/shop_app_cubit.dart';
import 'package:sssssssshop_app/shared/app_bloc/shop_app_states.dart';
import 'package:sssssssshop_app/shared/styles/colors.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1.0,
            titleSpacing: 10,
            title: Row(
              children: const [
                Image(
                  image: AssetImage('assets/images/image4.png'),
                  width: 40,
                  height: 40,
                ),
                Text(
                  'Salla',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart_outlined,
                    color: Colors.black),
              ),
              IconButton(
                onPressed: () {
                  // PushToNextScreen(context, SearchScreen());
                },
                icon: const Icon(Icons.search, color: Colors.black),
              ),                           
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: defaultColor,
            unselectedItemColor: grey,
            onTap: (int index) {
              cubit.changeBottom(index);

            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
          body: cubit.Screens[cubit.currentIndex],
        );
      },
    );
  }
}