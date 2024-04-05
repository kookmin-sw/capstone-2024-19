import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class OtherChatMsg extends StatelessWidget {
  final String userName;
  final String content;
  final Animation<double> animation;

  const OtherChatMsg(
    this.userName,
    this.content,
    this.animation,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      //사이즈가 커지는 애니메이션 위젯
      child: SizeTransition(
        sizeFactor: animation,
        axisAlignment: -1.0,
        child: FadeTransition(
          opacity: animation,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: ExtendedImage.asset('assets/images/mage.png', width: 26, height: 26,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 250.0),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(0xff, 0xee, 0xee, 0xee),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.0), 
                      topLeft: Radius.circular(16.0), 
                      bottomRight: Radius.circular(16.0)
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 5.0),
                    child: Text(content),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}