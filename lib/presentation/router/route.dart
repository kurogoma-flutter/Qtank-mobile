// ルーティング設定用ファイル
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qtank_mobile/presentation/pages/error/simple_error_page.dart';

import '../pages/qtank/qtank_workspace_list_page.dart';
import '../pages/qtank/qtank_workspace_home_page.dart';

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
        }),
  ],
  initialLocation: '/',
  errorBuilder: (context, state) => const SimpleErrorPage(),
);
