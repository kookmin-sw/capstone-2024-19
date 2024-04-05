import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jumunseo/core/logger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    logger.d('HomeScreen build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: SizedBox(
                                  height: 100,
                                  child: Material(
                                      //color: Colors.red.shade200,
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          context.push('/wizard');
                                        },
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons.add, size: 50),
                                            Text("마법사"),
                                          ],
                                        ),
                                      )))),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: SizedBox(
                                  height: 100,
                                  child: Material(
                                      //color: Colors.orange.shade200,
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          context.push('/dilemma/1/1');
                                        },
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons.add, size: 50),
                                            Text("딜레마 해결 서비스"),
                                          ],
                                        ),
                                      )))),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        const Text("게시판"),
                        const Spacer(),
                        Material(
                            child: InkWell(
                                onTap: () {
                                  context.push('/community');
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Colors.blue.shade200,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("더보기"),
                                    )))),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                height: 100,
                                color: const Color.fromARGB(190, 35, 20, 235),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
