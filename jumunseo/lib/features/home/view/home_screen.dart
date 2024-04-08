import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumunseo/core/logger.dart';
import 'package:jumunseo/features/home/cubit/home_cubit.dart';
import 'package:jumunseo/features/home/view/community_menu.dart';
import 'package:jumunseo/features/home/view/dilema_menu.dart';
import 'package:jumunseo/features/home/view/wizard_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<String> homeWidgets;

  @override
  Widget build(BuildContext context) {
    logger.d('HomeScreen build');

    homeWidgets = context.read<HomeCubit>().getHomeList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('홈'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ReorderableListView(
          onReorder: ((oldIndex, newIndex) {
            String tmp = homeWidgets.removeAt(oldIndex);
            homeWidgets.insert(newIndex, tmp);
            context.read<HomeCubit>().putHomeList(homeWidgets);
            setState(() {});
          }),
          children: homeWidgets.map((e) => 
            Padding(
              key: Key(e),
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: (e == '마법사')? 
                GestureDetector(
                  onTapUp: (details) => context.read<HomeCubit>().homeToWizard(context),
                  child: const WizardMenu()
                ): (e == '딜레마')? 
                GestureDetector(
                  onTapUp: (details) => context.read<HomeCubit>().homeToDilema(context),
                  child: const DilemaMenu()
                ): 
                const CommunityMenu(),
            )).toList(),
          ),
      ),
    );
  }
}