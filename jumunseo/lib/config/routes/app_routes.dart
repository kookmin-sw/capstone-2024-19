import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jumunseo/features/community/community_screen.dart';
import 'package:jumunseo/features/dilemma/dilemma_screen.dart';
import 'package:jumunseo/features/home/view/home_screen.dart';
import 'package:jumunseo/features/profile/view/profile_screen.dart';
import 'package:jumunseo/features/wizard/chat/view/category_view.dart';
import 'package:jumunseo/features/wizard/chat/view/chat_view.dart';
import 'package:jumunseo/features/wizard/chat/view/fwohView/how_view.dart';
import 'package:jumunseo/features/wizard/chat/view/fwohView/plus_info_view.dart';
import 'package:jumunseo/features/wizard/chat/view/fwohView/what_view.dart';
import 'package:jumunseo/features/wizard/chat/view/fwohView/when_view.dart';
import 'package:jumunseo/features/wizard/chat/view/fwohView/where_view.dart';
import 'package:jumunseo/features/wizard/chat/view/fwohView/who_view.dart';
import 'package:jumunseo/features/wizard/chat/view/fwohView/why_view.dart';
import 'package:jumunseo/features/wizard/chat/view/room_list_view.dart';
import 'package:jumunseo/features/wizard/chat/view/wizard_setting_view.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

const List<Widget> wizardDownRoutes = [CategoryView(), ChatView(), SettingView(), WhenView(),
                                      WhoView(), WhereView(), HowView(), PlusInfoView(), WhatView(), WhyView()];
const List<String> wizardDownRoutesPath = ['category', 'chat', 'chat_set', 'when', 'who', 'where', 'how', 'plus_info',
                                            'what', 'why'];

GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
        path: '/dilemma/:catagory/:id',
        builder: (context, state) {
          return const DilemmaScreen();
        }),
    GoRoute(
      path: '/wizard',
      builder: (context, state) {
        return const RoomListView();
      },
      routes: List.generate(wizardDownRoutes.length, ((index) {
        return GoRoute(
          path: wizardDownRoutesPath[index],
          builder: (context, state) {
            return wizardDownRoutes[index];
          }
        );
      }))
    ),
    GoRoute(
        path: '/community',
        builder: (context, state) {
          return const CommunityScreen();
        }),

    GoRoute(
        path: '/profile',
        builder: (context, state) {
          return const ProfileScreen();
        }),
  ],
);
