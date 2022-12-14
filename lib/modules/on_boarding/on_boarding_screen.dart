import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sssssssshop_app/modules/login/login.dart';
import 'package:sssssssshop_app/shared/constants/components.dart';
import 'package:sssssssshop_app/shared/network/local/cache_helper.dart';
import 'package:sssssssshop_app/shared/styles/colors.dart';

class BoardingModel {
  String? image, title, body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatelessWidget {
  var boardingController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/on_boarding1.png',
        title: 'Explore',
        body: 'choose the product you want through easy way using Salla app'),
    BoardingModel(
        image: 'assets/images/love.png',
        title: 'Favorite',
        body: 'If you love any product to buy it in the future you can save it to the wish list'),
    BoardingModel(
        image: 'assets/images/search.png',
        title: 'Search',
        body: 'You can search on any product you want'),
  ];

  bool? isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () {
                //TODO put the same code as login button
                navigateAndFinish(context, ShopLoginScreen());

              },
              child: const Text('SKIP')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StatefulBuilder(
                builder: (context, setState) {
                  return PageView.builder(
                    onPageChanged: (int index) {
                      setState(() {
                        if (index == boarding.length - 1) {
                          isLast = true;

                          print('last');
                        } else {
                          isLast = false;
                        }
                      });
                    },
                    controller: boardingController,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        buildBoardingItem(model: boarding[index]),
                    itemCount: boarding.length,
                  );
                },
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boarding.length,
                  effect:  const ExpandingDotsEffect(
                      activeDotColor: defaultColor,
                      dotColor: Colors.grey,
                      dotHeight: 10.0,
                      dotWidth: 10.0,
                      spacing: 5.0,
                      expansionFactor: 5.0),
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: defaultColor,
                  onPressed: () {
                    if (isLast!) {
                      CacheHelper.saveData(key: 'onBoarding', value: true)
                          .then((value) {
                        if (value) {
                          navigateAndFinish(context, ShopLoginScreen());
                        }
                      });
                    } else {
                      boardingController.nextPage(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_sharp),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem({required BoardingModel model}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image(image: AssetImage('${model.image}'))),
        const SizedBox(height: 30.0),
        Text(
          '${model.title}',
          style: const TextStyle(fontSize: 26.0, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 15.0),
        Text(
          '${model.body}',
          style: const TextStyle(fontSize: 20.0, color: grey),
        ),
      ],
    );
  }
}
