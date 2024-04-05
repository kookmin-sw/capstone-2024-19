import 'package:flutter/material.dart';

class DilemmaScreen extends StatefulWidget {
  const DilemmaScreen({super.key});

  @override
  State<DilemmaScreen> createState() => _DilemmaScreenState();
}

class _DilemmaScreenState extends State<DilemmaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('토론방'),
      ),
      body: const Center(
        child: Text('토론방 화면'),
      ),
    );
  }
}
