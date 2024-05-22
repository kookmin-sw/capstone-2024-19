import 'package:extended_image/extended_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumunseo/core/login_status.dart';
import 'package:jumunseo/features/profile/cubit/profile_cubit.dart';
import 'package:jumunseo/features/profile/view/account_setting.dart';
// import 'package:jumunseo/features/profile/view/notification_setting.dart';
import 'package:jumunseo/features/profile/view/other_setting.dart';
import 'package:jumunseo/features/wizard/chat/chat.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Widget> settingViewList = [const AccountSetting(), const OtherSetting()];//const NotificationSetting(), const OtherSetting()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              centerTitle: true,
              title: const Text("Profile", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {},
                ),
              ],
            ),
          ]
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LoginStatus.isGeust? CircleAvatar(
                      backgroundImage: ExtendedImage.asset('assets/icons/profile.png').image,
                    ):ValueListenableBuilder<String>(
                      valueListenable: LoginStatus.imageUrl,
                      builder: (context, value, child) {
                        if(value == '' || value == '기본사진'){
                          return GestureDetector(
                            onTap: () {
                              context.read<ProfileCubit>().profilechangeMethod(context);
                            },
                            child: CircleAvatar(
                              backgroundImage: ExtendedImage.asset('assets/icons/profile.png').image,
                            ),
                          );
                        }
                        else {
                          return GestureDetector(
                            onTap: () {
                              context.read<ProfileCubit>().profilechangeMethod(context);
                            },
                            child: CircleAvatar(
                              backgroundImage: ExtendedImage.network(value).image,
                            ),
                          );
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: LoginStatus.isGeust? const Text(
                        'Guest',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      ):ValueListenableBuilder<String>(
                        valueListenable: LoginStatus.name,
                        builder: (context, value, child) {
                          return Text(
                            value,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          );
                        }
                      ),
                    ),
                    const Spacer(),
                    SizedBox(width: 80, height: 30, child: GradientButton(
                      child: TextButton(
                        child : const Text('Edit', style: TextStyle(color: Colors.white, fontSize: 12),),
                        onPressed: () {
                          if(!LoginStatus.isGeust) {
                            context.read<ProfileCubit>().toEditProfile(context);
                          }
                        },
                      )
                    )),
                  ],
                ),
              ),
              ListView(
                shrinkWrap: true,
                children: List.generate(settingViewList.length, (index) {
                  return Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: settingViewList[index]);
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}