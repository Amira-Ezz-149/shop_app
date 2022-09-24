import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sssssssshop_app/layout/shop_app_layput.dart';
import 'package:sssssssshop_app/modules/register/register_screen.dart';
import 'package:sssssssshop_app/shared/constants/components.dart';
import 'package:sssssssshop_app/shared/constants/constants.dart';
import 'package:sssssssshop_app/shared/login_cubit/shop_login_cubit.dart';
import 'package:sssssssshop_app/shared/login_cubit/shop_login_states.dart';
import 'package:sssssssshop_app/shared/network/local/cache_helper.dart';
import 'package:sssssssshop_app/shared/styles/colors.dart';


class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      listener: (BuildContext context, state) {
        if (state is ShopLoginSuccessState) {
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
      builder: (BuildContext context, Object? state) {
        var cubit = ShopLoginCubit.get(context);
        return Scaffold(

          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child:Image(image: AssetImage('assets/images/login_logo.png')),
                    ),
                    Center(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            const Text(
                              'Login naw you browse our hot offers',
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            defaultTextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              label: 'Email Address',
                              prefix: Icons.email,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email is to Short';
                                }
                                return null;
                              },
                              onfiled: (value) {
                                print(value);
                              },
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            //TODO change this to defaultformfield which i add to the settings
                            defaultTextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.text,
                              label: 'Password',
                              prefix: Icons.lock,
                              suffix: cubit.iconData,
                              obscureText: cubit.isoscureShow,
                              suffixPressed: () {
                                cubit.changePasswordVisibility();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password is to Short';
                                }
                                return null;
                              },
                              onfiled: (value) {
                                print(value);
                              },
                              onSubmit: (value) {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! ShopLoginLoadingState,
                              builder: (BuildContext context) => defaultButton(
                                width: double.infinity,
                                height: 50,
                                color: defaultColor,
                                onpressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: 'Login',
                              ),
                              fallback: (BuildContext context) => const Center(
                                  child: CircularProgressIndicator()),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Don\'t Have an account yet ?',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                TextButton(
                                  onPressed: () {
                                     pushToNextScreen(context, ShopRegisterScreen());
                                  },
                                  child: const Text('Register'),
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
          ),
        );
      },
    );
  }
}