import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sssssssshop_app/shared/app_bloc/shop_app_cubit.dart';
import 'package:sssssssshop_app/shared/app_bloc/shop_app_states.dart';
import 'package:sssssssshop_app/shared/constants/components.dart';
import 'package:sssssssshop_app/shared/constants/constants.dart';
import 'package:sssssssshop_app/shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        
        ShopCubit cubit = ShopCubit.get(context);
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilder(condition: cubit.userModel != null,
            builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        if(state is ShopLoadingUpdateUserState) const LinearProgressIndicator(),
                        const SizedBox(height: 20.0),
                        defaultFormField(
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) 'Name must be not empty';
                            return null;
                          },
                          label: 'Name',
                          prefix: Icons.person,
                          controller: nameController,
                        ),
                        const SizedBox(height: 20.0,),
                        defaultFormField(
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) 'Email must be not empty';
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email,
                          controller: emailController,
                        ),
                        const SizedBox(height: 20.0,),

                        defaultFormField(
                          type: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) 'Phone must be not empty';
                            return null;
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                          controller: phoneController,
                        ),
                        const SizedBox(height: 20.0,),
                        defaultButton(
                            width: double.infinity,
                            height: 50.0,
                            color: defaultColor,
                            onpressed: () {
                              if (formKey.currentState!.validate()) {
                                ShopCubit.get(context).updateUserData(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text);
                              }
                            },
                            text: 'UPDATE'),
                        const SizedBox(height: 20.0,),
                        defaultButton(
                            width: double.infinity,
                            height: 50.0,
                            color: defaultColor,
                            onpressed: () {
                              signOut(context);
                            },
                            text: 'LOGOUT'),
                      ],
                    ),
                  ),
                ),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }
}
