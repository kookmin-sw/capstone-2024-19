import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumunseo/config/theme/app_color.dart';
import 'package:jumunseo/features/wizard/chat/view/fwoh_select.dart';
import 'package:jumunseo/features/wizard/chat/view/gradient_button.dart';

import '../cubit/wizard_cubit.dart';

class FwohView extends StatefulWidget{
  const FwohView({super.key});

  @override
  State<FwohView> createState() => _FwohViewState();
}

class _FwohViewState extends State<FwohView> {
  List<String> fwohs = ["언제?", "왜?", "어디서?", "무엇을?", "어떻게?", "누구와?", "추가 상황 설명 해주세요!"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
            "내용을 자세하게 적어주세요.",
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
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView(
                clipBehavior: Clip.none,
                shrinkWrap: true,
                children: List.generate(fwohs.length+1, (index) {
                  if(index != fwohs.length) {
                    return Fwoh(fwohs[index]);
                  } else {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: GradientButton(
                                  onButtonPress: () {context.read<WizardCubit>().toWizardSet(context); },
                                  message: '주문서 봇 설정하기',
                                ),
                              ),
                            ]
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: GradientButton(
                                  onButtonPress: () {},//context.read<WizardCubit>().toChat(context, ); },
                                  message: 'Continue',
                                ),
                              ),
                            ]
                          ),
                        ),
                      ],
                    );
                  }
                })
              ),
            ),
          ),
        ]
      ),
    );
  }
}