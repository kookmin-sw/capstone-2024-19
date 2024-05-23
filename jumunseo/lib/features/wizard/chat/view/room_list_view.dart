import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumunseo/config/theme/app_color.dart';
import 'package:jumunseo/core/blank.dart';
import 'package:jumunseo/core/logger.dart';
import 'package:jumunseo/features/auth/auth.dart';
import 'package:jumunseo/features/auth/data/repository/auth_repository.dart';
import '../chat.dart';

class RoomListView extends StatefulWidget{
  const RoomListView({super.key});

  @override
  State<RoomListView> createState() => _RoomListViewState();
}

class _RoomListViewState extends State<RoomListView> {
  final baseOptions = BaseOptions(
    baseUrl: 'http://10.0.2.2:8081',
    contentType: Headers.jsonContentType,
    validateStatus: (int? status) {
      return status != null;
    },
  );

  late WizardRepository repo;
  late AuthRepository aRepo;
  late Dio dio;
  ValueNotifier<bool> internet = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    dio = Dio(baseOptions);

    dio.interceptors.addAll(
      [
        const Interceptor(),
        CookieManager(context.read<AuthCubit>().getCookie()),
      ]
    );

    repo = WizardRepository(dio);
    aRepo = AuthRepository(dio);
  }

  @override
  Widget build(BuildContext context) {
    context.read<WizardCubit>().internetAccessOk(context).then((value) {
      if(value) {
        internet.value = true;
      }
    },);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
            "마 법 사",
            style: TextStyle(
              color: ColorStyles.mainColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: ValueListenableBuilder<bool>(
        builder: (context, value, child) {
          if(value) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 19.0, horizontal: 30.0),
                  child: Text("진행중인 대화", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),)
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: FutureBuilder(
                      future: repo.getRooms(context.read<AuthCubit>().getAcessToken()),
                      initialData: [],
                      builder: (_, AsyncSnapshot snapshot) {
                        logger.d(snapshot);
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
          
                        ChatModel chats = snapshot.data;
          
                        if(chats.code == "FAIL" && chats.message == "토큰이 유효하지 않습니다.") {
                          setState(() {
                            context.read<WizardCubit>().roomCheck(context, aRepo, chats);
                          });
                          return Blank(0, 0);
                        }
          
                        return ListView(
                          padding: const EdgeInsets.symmetric(vertical: 19.0),
                          clipBehavior: Clip.none,
                          shrinkWrap: true,
                          children: List.generate(chats.data.length, (index) {
                            return GestureDetector(
                              onTapUp: (details) {
                                context.read<WizardCubit>().setRoom(chats.data[index].room_id);
                                context.read<WizardCubit>().toChat(context, null); 
                              },
                              child: Room(chats.data[index])
                            );
                          })
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 35.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GradientButton(
                          child: TextButton(
                          onPressed: () {
                            context.read<WizardCubit>().setRoom("-1");
                            context.read<WizardCubit>().toCategory(context); 
                          },
                          child: const Text('새로운 방 생성', style: TextStyle(color: Colors.white),),
                        ),),
                      ),
                    ]
                  ),
                ),
              ]
            );
          }
          else {
            return Container();
          }
        }, valueListenable: internet,
      ),
    );
  }
}