import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumunseo/config/theme/app_color.dart';
import 'package:jumunseo/features/wizard/chat/view/gradient_button.dart';
import 'package:jumunseo/features/wizard/chat/view/room_list_select.dart';
import 'package:jumunseo/features/wizard/data/repository/wizard_repository.dart';
import 'package:jumunseo/features/wizard/model/chat_model.dart';
import 'package:logger/logger.dart';

import '../cubit/wizard_cubit.dart';

class RoomListView extends StatefulWidget{
  const RoomListView({super.key});

  @override
  State<RoomListView> createState() => _RoomListViewState();
}

class _RoomListViewState extends State<RoomListView> {
  late WizardRepository repo;
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    repo = WizardRepository(dio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
            "마 법 사",
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 19.0, horizontal: 30.0),
            child: Text("진행중인 대화", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),)
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: FutureBuilder(
                future: repo.getRooms(context.read<WizardCubit>().getUserId()),
                initialData: [],
                builder: (_, AsyncSnapshot snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  ChatModel chats = snapshot.data;

                  return ListView(
                    padding: const EdgeInsets.symmetric(vertical: 19.0),
                    clipBehavior: Clip.none,
                    shrinkWrap: true,
                    children: List.generate(chats.chats.length, (index) {
                      return GestureDetector(
                        onTapUp: (details) {
                          Logger().d("선택");
                          context.read<WizardCubit>().setRoom(chats.chats[index].room_id);
                          context.read<WizardCubit>().toChat(context, null); 
                        },
                        child: Room(chats.chats[index])
                      );
                    })
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 35.0),
            child: Row(
              children: [
                Expanded(
                  child: GradientButton(
                    onButtonPress: () {
                      context.read<WizardCubit>().setRoom("-1");
                      context.read<WizardCubit>().toCategory(context); 
                    },
                    message: '새로 시작하기',
                  ),
                ),
              ]
            ),
          ),
        ]
      ),
    );
  }
}