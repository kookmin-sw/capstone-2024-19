import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumunseo/config/theme/app_color.dart';
import 'package:jumunseo/features/wizard/chat/chat.dart';

class WizardSet extends StatefulWidget {
  final String imageName;
  final String setName;
  final List<String> setList;

  const WizardSet(
    this.imageName,
    this.setName,
    this.setList,
    {super.key}
  );

  @override
  State<WizardSet> createState() => _WizardSetState();
}

class _WizardSetState extends State<WizardSet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Column(
            children: [
              ExtendedImage.asset(widget.imageName, width: 24.0, height: 24.0,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  widget.setName,
                  style: const TextStyle(
                    color: Color.fromARGB(0xff, 0x3f, 0x3f, 0x3f),
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView(
          clipBehavior: Clip.none,
          shrinkWrap: true,
          children: List.generate(widget.setList.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 29.0, vertical: 4.0),
              child: GestureDetector(
                onTapUp: (details) {
                  if(widget.setName == 'Explain') {
                    setState(() {
                      context.read<WizardCubit>().setExplain(widget.setList[index]);
                    });
                  }
                  else if(widget.setName == 'Write & edit') {
                    setState(() {
                      context.read<WizardCubit>().setEdit(widget.setList[index]);
                    });
                  }
                  else if(widget.setName == 'Translate') {
                    setState(() {
                      context.read<WizardCubit>().setTranslate(widget.setList[index]);
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(0xff, 0xf4, 0xf4, 0xf4),
                    borderRadius: BorderRadius.circular(20.0),
                    border: 
                      (widget.setName == 'Explain')?
                        (context.read<WizardCubit>().getExplain()==widget.setList[index])?Border.all(color: ColorStyles.mainColor):null:
                      (widget.setName == 'Write & edit')?
                        (context.read<WizardCubit>().getEdit()==widget.setList[index])?Border.all(color: ColorStyles.mainColor):null:
                      (widget.setName == 'Translate')?
                        (context.read<WizardCubit>().getTranslate()==widget.setList[index])?Border.all(color: ColorStyles.mainColor):null:null
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.5),
                      child: Text(
                        widget.setList[index],
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        )
    ],);
  }
}