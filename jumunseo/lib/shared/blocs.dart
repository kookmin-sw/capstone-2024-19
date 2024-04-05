import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumunseo/features/wizard/chat/chat.dart';

class BlocWidget extends StatelessWidget {
  const BlocWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WizardCubit>(
          create: (BuildContext context) => WizardCubit(),
        ),
      ],
      child: child,
    );
  }
}