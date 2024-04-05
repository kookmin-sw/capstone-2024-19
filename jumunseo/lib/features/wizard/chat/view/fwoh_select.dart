import 'package:flutter/material.dart';

class Fwoh extends StatelessWidget {
  final String fwohName;

  const Fwoh(
    this.fwohName,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(fwohName, style: const TextStyle(color: Color.fromARGB(0xff, 0x59, 0x59, 0x59), fontSize: 12.0),),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Container(
              height: 40.0,
              child: TextField(
                controller: textEditingController,
                maxLines: 1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Text",
                  hintStyle: TextStyle(color: Color.fromARGB(0xff, 0xab, 0xab, 0xab), fontSize: 12.0),
                ),
                onSubmitted: (String text){},
              ),
            ),
          ),
      ],),
    );
  }
}