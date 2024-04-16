import '../../chat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumunseo/config/theme/app_color.dart';

class WhoView extends StatefulWidget{
  const WhoView({super.key});

  @override
  State<WhoView> createState() => _WhoViewState();
}

class _WhoViewState extends State<WhoView> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text("누가?", style: TextStyle(color: Color.fromARGB(0xff, 0x59, 0x59, 0x59), fontSize: 14.0),)
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
            child: TextField(
              controller: textEditingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Text",
                hintStyle: TextStyle(color: Color.fromARGB(0xff, 0xab, 0xab, 0xab), fontSize: 12.0),
              ),
              onSubmitted: (String text){},
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 33.0),
            child: Row(
              children: [
                Expanded(
                  child: GradientButton(
                    child: TextButton(
                    onPressed: () {context.read<WizardCubit>().toPlusInfo(context, textEditingController); },
                    child: const Text('Continue', style: TextStyle(color: Colors.white),),
                  ),),
                ),
              ]
            ),
          ),
        ]
      ),
    );
  }
}