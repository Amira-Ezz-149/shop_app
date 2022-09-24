import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sssssssshop_app/shared/cubit/shop_app_cubit.dart';
import 'package:sssssssshop_app/shared/cubit/shop_app_states.dart';
import 'package:sssssssshop_app/shared/styles/colors.dart';

class FAQSScreen extends StatelessWidget {
  const FAQSScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
            appBar: AppBar(
                title: const Text(
                  'FAQS',
                  style: TextStyle(color: white),
                ),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: white,))),
            body: ListView.builder(
                itemCount: cubit.faqsModel!.data!.data.length,
                itemBuilder: (context, index) {
                  return FAQSItem(
                    title: cubit.faqsModel!.data!.data[index].question,
                    subTitle: cubit.faqsModel!.data!.data[index].answer,
                  );
                }));
      },
    );
  }
}

class FAQSItem extends StatelessWidget {
  String? title;
  String? subTitle;

  FAQSItem({required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title!,
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15.0),
            Text(subTitle!,
                style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black45)),
          ],
        ),
      ),
    );
  }
}
