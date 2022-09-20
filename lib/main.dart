
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sssssssshop_app/layout/shop_app_layput.dart';
import 'package:sssssssshop_app/modules/login/login.dart';
import 'package:sssssssshop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:sssssssshop_app/shared/app_bloc/shop_app_cubit.dart';
import 'package:sssssssshop_app/shared/constants/constants.dart';
import 'package:sssssssshop_app/shared/login_bloc/bloc_observer.dart';
import 'package:sssssssshop_app/shared/login_bloc/cubit.dart';
import 'package:sssssssshop_app/shared/network/remote/dio_helper.dart';

import 'shared/network/local/cache_helper.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  dynamic onBoardingFinish = false;
  onBoardingFinish = CacheHelper.getData('ShowOnBoard');
  token = CacheHelper.getData('token');
  print(token);
  late Widget start;
  if (onBoardingFinish != null) {
    if (token == null) {
      start = ShopLoginScreen();
    } else {
      start = const ShopLayout();
    }
  } else {
    start = OnBoardingScreen();
  }

  runApp(MyApp(start));
}
// BlocOverrides.runZoned(
// () {
// // Use cubits...
// },
// blocObserver: MyBlocObserver(),
// );

class MyApp extends StatelessWidget {
  Widget startApp;

  MyApp(this.startApp);

  // his widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopAppLogincubit()),
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()..getCategories()),

      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: startApp,
      ),
    );
  }
}