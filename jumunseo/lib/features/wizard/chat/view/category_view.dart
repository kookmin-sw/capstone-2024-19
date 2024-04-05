import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumunseo/config/theme/app_color.dart';
import 'package:jumunseo/core/blank.dart';
import 'package:jumunseo/features/wizard/chat/view/category_select.dart';
import 'package:jumunseo/features/wizard/chat/view/gradient_button.dart';

import '../cubit/wizard_cubit.dart';

class CategoryView extends StatefulWidget{
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<String> images = ['assets/images/categories/1.png',
                        'assets/images/categories/2.png',
                        'assets/images/categories/3.png',
                        'assets/images/categories/4.png',
                        'assets/images/categories/5.png',
                        'assets/images/categories/6.png',];
  List<String> names = ['교통사고','돈','폭행','절도',
                        '성 문제','그 외'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "카테고리를 선택해주세요!",
          style: TextStyle(
            color: ColorStyles.mainColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24,right: 24, top: 20),
              child: GridView.builder(
                itemCount: images.length,
                clipBehavior: Clip.none,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 12.0, crossAxisCount: 2, crossAxisSpacing: 12.0, childAspectRatio: (158 / 90),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTapUp: (details) {
                      setState(() {
                        context.read<WizardCubit>().setCateogry(names[index]);
                      });
                    },
                    child: Category(images[index], names[index])
                  );
                })
              ),
            ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GradientButton(
                        onButtonPress: () {context.read<WizardCubit>().toWhen(context); },
                        message: 'Continue',
                      ),
                    ),
                  ]
                ),
              ),
              const Blank(0, 20),
            ],
          ),
        ]
      ),
    );
  }
}