
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sssssssshop_app/modules/search/search_screen.dart';
import 'package:sssssssshop_app/shared/cubit/shop_app_cubit.dart';
import 'package:sssssssshop_app/shared/cubit/shop_app_states.dart';
import 'package:sssssssshop_app/shared/constants/components.dart';
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
            backgroundColor: defaultColor,
            elevation: 1.0,
            titleSpacing: 10,
            title: Row(
              children: const [
                Text(
                  'Salla',
                  style: TextStyle(color: white),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                   navigateTo(context, SearchScreen());
                },
                icon: const Icon(Icons.search, color: white),
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
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Home'),
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