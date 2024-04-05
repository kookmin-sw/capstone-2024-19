import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumunseo/features/wizard/chat/view/room_list_view.dart';
import './chat/chat.dart';

class WizardScreen extends StatefulWidget {
  const WizardScreen({super.key});

  @override
  State<WizardScreen> createState() => _WizardScreenState();
}

class _WizardScreenState extends State<WizardScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WizardCubit(),
      child: const MaterialApp(home: RoomListView()),
    );
  }
}
