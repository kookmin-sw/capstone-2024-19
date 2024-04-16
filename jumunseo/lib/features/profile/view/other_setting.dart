import 'package:jumunseo/core/blank.dart';
import 'package:jumunseo/features/wizard/chat/chat.dart';
import 'package:jumunseo/shared/gradient_icon.dart';

class OtherSetting extends StatefulWidget {
  const OtherSetting({super.key});

  @override
  State<OtherSetting> createState() => _OtherSettingState();
}

class _OtherSettingState extends State<OtherSetting> {

  List<Widget> iconList = [const GradientIcon(child: Icon(Icons.privacy_tip_outlined)), 
                        const GradientIcon(child: Icon(Icons.settings_outlined))];
  List<String> accountList = ["Privacy Policy", "Settings",];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Text("Account", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),
            ),
            ListView(
              shrinkWrap: true,
              children: List.generate(iconList.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      iconList[index],
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(accountList[index], style: const TextStyle(color: Colors.grey, fontSize: 12),),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios, size: 18,),
                    ],
                  ),
                );
              }),
            ),
            const Blank(0, 15),
          ],
        ),
      ),
    );
  }
}