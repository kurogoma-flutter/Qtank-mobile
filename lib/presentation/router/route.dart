// ルーティング設定用ファイル
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qtank_mobile/presentation/pages/auth/auth_gate_page.dart';
import 'package:qtank_mobile/presentation/pages/auth/create_user_page.dart';
import 'package:qtank_mobile/presentation/pages/auth/login_user_page.dart';
import 'package:qtank_mobile/presentation/pages/genre/genre_list_page.dart';
import 'package:qtank_mobile/presentation/pages/legal/about_this_app_page.dart';
import 'package:qtank_mobile/presentation/pages/legal/app_term_page.dart';
import 'package:qtank_mobile/presentation/pages/legal/inquiry_page.dart';
import 'package:qtank_mobile/presentation/pages/legal/privacy_polict_page.dart';
import 'package:qtank_mobile/presentation/pages/legal/qa_list_page.dart';
import 'package:qtank_mobile/presentation/pages/legal/specific_trade_law_page.dart';
import 'package:qtank_mobile/presentation/pages/workspace/workspace_member_list.dart';
import 'package:qtank_mobile/presentation/pages/workspace/workspace_setting_page.dart';

import '../pages/error/simple_error_page.dart';
import '../pages/legal/inquiry_complete_page.dart';
import '../pages/setting/app_setting_page.dart';
import '../pages/user/user_profile_edit_page.dart';
import '../pages/user/user_profile_page.dart';
import '../pages/workspace/create_workspace_page.dart';
import '../pages/workspace/workspace_home_page.dart';
import '../pages/workspace/workspace_list_page.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const AuthGate(),
    ),
    GoRoute(
      path: '/workspace/list',
      builder: (BuildContext context, GoRouterState state) =>
          const QTankListViewPage(),
    ),
    GoRoute(
      path: '/workspace/:workspaceId/:workspaceName',
      builder: (BuildContext context, GoRouterState state) {
        String workspaceId = state.params['workspaceId']!;
        String workspaceName = state.params['workspaceName']!;
        return QTankWorkSpaceHomePage(
          workspaceId: workspaceId,
          workspaceName: workspaceName,
        );
      },
    ),
    GoRoute(
      path: '/user_profile',
      builder: (BuildContext context, GoRouterState state) =>
          const UserProfilePage(),
    ),
    GoRoute(
      path: '/user_profile/edit',
      builder: (BuildContext context, GoRouterState state) =>
          const UserProfileEditPage(),
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
        path: '/workspace_setting/:workspaceId',
        builder: (BuildContext context, GoRouterState state) {
          String workspaceId = state.params['workspaceId']!;
          return WorkSpaceSettingPage(
            workspaceId: workspaceId,
          );
        }),
    GoRoute(
      path: '/workspace_member_list',
      builder: (BuildContext context, GoRouterState state) =>
          const WorkSpaceMemberListPage(),
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
    GoRoute(
      path: '/legal/inquiry/complete',
      builder: (BuildContext context, GoRouterState state) =>
          const InquiryCompletePage(),
    ),
    GoRoute(
      path: '/legal/about_app',
      builder: (BuildContext context, GoRouterState state) =>
          const AboutThisAppPage(),
    ),
    GoRoute(
      path: '/legal/specific_trade_law',
      builder: (BuildContext context, GoRouterState state) =>
          const SpecificTradeLawPage(),
    ),
    GoRoute(
      path: '/legal/qa_page',
      builder: (BuildContext context, GoRouterState state) => const QAPage(),
    ),
    GoRoute(
      path: '/no_connection',
      builder: (BuildContext context, GoRouterState state) =>
          const SpecificTradeLawPage(),
    ),
    GoRoute(
      path: '/auth/login',
      builder: (BuildContext context, GoRouterState state) => const LoginPage(),
    ),
    GoRoute(
      path: '/auth/create',
      builder: (BuildContext context, GoRouterState state) =>
          const CreateUserPage(),
    ),
    GoRoute(
      path: '/genre',
      builder: (BuildContext context, GoRouterState state) => const SizedBox(),
      routes: [
        GoRoute(
          path: 'list/:workspaceId',
          builder: (BuildContext context, GoRouterState state) {
            String workspaceId = state.params['workspaceId']!;
            return GenreListPage(workspaceId: workspaceId);
          },
        ),
      ],
    ),
  ],
  initialLocation: '/',
  errorBuilder: (context, state) => const SimpleErrorPage(),
);
