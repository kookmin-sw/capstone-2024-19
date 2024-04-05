import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jumunseo/features/community/community_screen.dart';
import 'package:jumunseo/features/dilemma/dilemma_screen.dart';
import 'package:jumunseo/features/home/home_screen.dart';
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
      routes: [
        GoRoute(
          path: 'category',
          builder: (context, state) {
            return const CategoryView();
          }
        ),
        GoRoute(
          path: 'chat',
          builder: (context, state) {
            return const ChatView();
          }
        ),
        GoRoute(
          path: 'chat_set',
          builder: (context, state) {
            return const SettingView();
          }
        ),
        //육하원칙 뷰들
        GoRoute(
          path: 'when',
          builder: (context, state) {
            return const WhenView();
          }
        ),
        GoRoute(
          path: 'who',
          builder: (context, state) {
            return const WhoView();
          }
        ),
        GoRoute(
          path: 'where',
          builder: (context, state) {
            return const WhereView();
          }
        ),
        GoRoute(
          path: 'how',
          builder: (context, state) {
            return const HowView();
          }
        ),
        GoRoute(
          path: 'plus_info',
          builder: (context, state) {
            return const PlusInfoView();
          }
        ),
        GoRoute(
          path: 'what',
          builder: (context, state) {
            return const WhatView();
          }
        ),
        GoRoute(
          path: 'why',
          builder: (context, state) {
            return const WhyView();
          }
        ),
      ],
    ),
    GoRoute(
        path: '/community',
        builder: (context, state) {
          return const CommunityScreen();
        }),
  ],
);
