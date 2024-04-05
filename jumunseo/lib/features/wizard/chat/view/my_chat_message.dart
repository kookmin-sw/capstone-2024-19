import 'package:flutter/material.dart';
import 'package:jumunseo/config/theme/app_color.dart';

class MyChatMsg extends StatelessWidget {
  final String userName;
  final String content;
  final Animation<double> animation;

  const MyChatMsg(
    this.userName,
    this.content,
    this.animation,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: SizeTransition(
        sizeFactor: animation,
        axisAlignment: -1.0,
        child: FadeTransition(
          opacity: animation,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 250.0),
                    decoration: const BoxDecoration(
                      color: ColorStyles.mainColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0), 
                        bottomLeft: Radius.circular(16.0), 
                        bottomRight: Radius.circular(16.0)
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 5.0),
                      child: Text(content, style: const TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}