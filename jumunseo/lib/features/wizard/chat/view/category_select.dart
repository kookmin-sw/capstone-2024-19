import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumunseo/config/theme/app_color.dart';
import 'package:jumunseo/features/wizard/chat/chat.dart';

class Category extends StatefulWidget {
  final String imageName;
  final String categoryName;

  const Category(
    this.imageName,
    this.categoryName,
    {super.key}
  );

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        border: widget.categoryName == context.read<WizardCubit>().getCategory()?
          Border.all(color: ColorStyles.mainColor):null
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(backgroundImage: AssetImage(widget.imageName), radius: 24.0,)
          ),
          Text(widget.categoryName, style: const TextStyle(color: ColorStyles.mainColor, fontSize: 12.0, fontWeight: FontWeight.bold),),
      ],),
    );
  }
}