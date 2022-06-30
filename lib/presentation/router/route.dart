// ルーティング設定用ファイル
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qtank_mobile/presentation/pages/legal/app_term_page.dart';
import 'package:qtank_mobile/presentation/pages/legal/inquiry_page.dart';
import 'package:qtank_mobile/presentation/pages/legal/privacy_polict_page.dart';

import '../pages/error/simple_error_page.dart';
import '../pages/workspace/create_workspace_page.dart';
import '../pages/setting/component/app_setting_page.dart';
import '../pages/workspace/qtank_workspace_list_page.dart';
import '../pages/workspace/qtank_workspace_home_page.dart';
import '../pages/user/component/user_profile_page.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const QTankListViewPage(),
    ),
    GoRoute(
      path: '/workspace/:workspaceId',
      builder: (BuildContext context, GoRouterState state) {
        String workspaceId = state.params['workspaceId']!;
        return QTankWorkSpaceHomePage(workspaceId: workspaceId);
      },
    ),
    GoRoute(
      path: '/user_profile',
      builder: (BuildContext context, GoRouterState state) =>
          const UserProfilePage(),
    ),
    GoRoute(
      path: '/setting_app_and_legal',
      builder: (BuildContext context, GoRouterState state) =>
          const SettingAppAndLegalPage(),
    ),
    GoRoute(
      path: '/create_workspace',
      builder: (BuildContext context, GoRouterState state) =>
          const CreateWorkSpacePage(),
    ),
    GoRoute(
      path: '/legal/privacy_policy',
      builder: (BuildContext context, GoRouterState state) =>
          const PrivacyPolicyPage(),
    ),
    GoRoute(
      path: '/legal/app_term',
      builder: (BuildContext context, GoRouterState state) =>
          const AppTermPage(),
    ),
    GoRoute(
      path: '/legal/inquiry',
      builder: (BuildContext context, GoRouterState state) =>
          const InquiryPage(),
    ),
  ],
  initialLocation: '/',
  errorBuilder: (context, state) => const SimpleErrorPage(),
);
