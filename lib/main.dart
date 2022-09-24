
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sssssssshop_app/layout/shop_app_layput.dart';
import 'package:sssssssshop_app/modules/login/login.dart';
import 'package:sssssssshop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:sssssssshop_app/shared/app_bloc/shop_app_cubit.dart';
import 'package:sssssssshop_app/shared/constants/constants.dart';
import 'package:sssssssshop_app/shared/login_bloc/bloc_observer.dart';
import 'package:sssssssshop_app/shared/login_bloc/shop_login_cubit.dart';
import 'package:sssssssshop_app/shared/network/remote/dio_helper.dart';
import 'package:sssssssshop_app/shared/styles/colors.dart';

import 'shared/network/local/cache_helper.dart';

/*
email : amira.ezz@gmail.com
pass : 123456

email : asmaa11@gmail.com
pass : 123456
*/
Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  dynamic onBoardingFinish = false;
  onBoardingFinish = CacheHelper.getData('ShowOnBoard');
  token = CacheHelper.getData('token');
  /// token = RwRmZdDS1T7YBr6bKw3RAFwLFJH8xuBOKZIOf0uZWJma5z3EGBjt8Y97BXDNSAApaESMPA
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

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
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
        BlocProvider(create: (context) => ShopLoginCubit()),
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()..getCategories()..getFavorites()..getUserData()..getFAQS()),

      ],
      child: MaterialApp(
        theme: ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(onPrimary: defaultColor,
      primary: defaultColor
    ),
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: startApp,
      ),
    );
  }
}