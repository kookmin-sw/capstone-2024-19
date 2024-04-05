import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumunseo/features/wizard/chat/view/room_list_view.dart';

import '../chat.dart';
// import 'chat_view.dart';

class WizardScreen extends StatelessWidget {
  const WizardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WizardCubit(),
      child: const MaterialApp(
        home: RoomListView(),
      ),
    );
  }
}
