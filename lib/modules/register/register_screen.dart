import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sssssssshop_app/layout/shop_app_layput.dart';
import 'package:sssssssshop_app/modules/login/login.dart';
import 'package:sssssssshop_app/shared/constants/components.dart';
import 'package:sssssssshop_app/shared/constants/constants.dart';
import 'package:sssssssshop_app/shared/login_bloc/shop_login_cubit.dart';
import 'package:sssssssshop_app/shared/network/local/cache_helper.dart';
import 'package:sssssssshop_app/shared/register_bloc/register_cubit.dart';
import 'package:sssssssshop_app/shared/register_bloc/register_states.dart';

class ShopRegisterScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state){
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status == true) {
              Fluttertoast.showToast(
                  msg: state.loginModel.message.toString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              CacheHelper.saveData(
                  key: 'token', value: state.loginModel.data?.token)
                  .then((value) {
                token = state.loginModel.data!.token!;
                token = state.loginModel.data?.token;
                navigateAndFinish(context, const ShopLayout());
              }).catchError((error) {});
            } else {
              Fluttertoast.showToast(
                  msg: state.loginModel.message.toString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }

        },
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child: FlutterLogo(size: 200.0)),
                    Center(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'ٌRegister',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            const Text(
                              'Register now to browse our hot offers',
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 40.0),
                            defulteditTextx(
                              Controlar: nameController,
                              keyboardType: TextInputType.name,
                              Lable: 'Name',
                              prefix: Icons.person,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              onfiled: (value) {
                                print(value);
                              },
                            ),
                            const SizedBox(height: 30.0),
                            defulteditTextx(
                              Controlar: emailController,
                              keyboardType: TextInputType.emailAddress,
                              Lable: 'Email Address',
                              prefix: Icons.email,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email address';
                                }
                                return null;
                              },
                              onfiled: (value) {
                                print(value);
                              },
                            ),
                            const SizedBox(height: 30.0),
                            defulteditTextx(
                              Controlar: phoneController,
                              keyboardType: TextInputType.phone,
                              Lable: 'Phone',
                              prefix: Icons.phone,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your phone';
                                }
                                return null;
                              },
                              onfiled: (value) {
                                print(value);
                              },
                            ),
                            const SizedBox(height: 30.0),
                            //TODO change this to defaultformfield which i add to the settings
                            defulteditTextx(
                              Controlar: passwordController,
                              keyboardType: TextInputType.text,
                              Lable: 'Password',
                              prefix: Icons.lock,
                              sufix: ShopRegisterCubit.get(context).iconData,
                              obscureText: ShopRegisterCubit.get(context).isPassword,
                              suffixPressed: () {
                                ShopRegisterCubit.get(context)
                                    .changeRegisterPasswordVisibility();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              onfiled: (value) {
                                print(value);
                              },

                            ),
                            const SizedBox(height: 30.0),
                            ConditionalBuilder(
                              condition: state is !ShopRegisterLoadingState,
                              builder: (BuildContext context) => defaultButton(
                                width: double.infinity,
                                height: 50,
                                color: Colors.deepOrange,
                                onpressed: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: 'REGISTER',
                              ),
                              fallback: (BuildContext context) =>
                              const Center(child: CircularProgressIndicator()),
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'If you have an account',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                TextButton(
                                  onPressed: () {
                                    PushToNextScreen(context, ShopLoginScreen());
                                  },
                                  child: const Text('LOGIN'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
}
