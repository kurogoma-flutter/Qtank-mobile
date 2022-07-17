import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtank_mobile/presentation/pages/auth/login_user_page.dart';

import '../workspace/workspace_list_page.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 取得中はローディング
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // 認証情報の有無によりページを切り替える
        if (snapshot.hasData) {
          return const QTankListViewPage();
        }

        return const LoginPage();
      },
    );
  }
}
