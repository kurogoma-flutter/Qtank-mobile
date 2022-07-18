import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qtank_mobile/presentation/style/color.dart';

import '../../../data/utility/logger/logger.dart';
import '../../../data/view_model/auth_page_view_model.dart';
import '../../../data/view_model/user_page_view_model.dart';
import '../../style/style.dart';
import '../common_components/dialog.dart';

class UserProfilePage extends ConsumerWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(authPageProvider);
    final future = ref.watch(usersFutureProvider);
    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        title: const Text('ユーザープロフィール'),
        backgroundColor: QTankColor.grey,
        elevation: 0,
        centerTitle: false,
      ),
      body: future.when(
        data: (user) {
          if (!user.exists) {
            context.go('/auth/login');
          }

          final userData = user.data();
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 48,
                  backgroundImage: AssetImage('assets/dammy_icon_3.png'),
                ),
                Text(
                  userData!['name'] ?? '未設定',
                  style: QTankTextStyle.largeTitle,
                ),
                _TitleLabelWithBoldText(
                    label: 'ID', text: '@${userData["uid"] ?? "未設定"}'),
                _TitleLabelWithBoldText(
                    label: 'Email', text: '${userData["email"] ?? "未設定"}'),
                _TitleLabelWithBoldText(
                    label: '所属', text: '${userData["belong"] ?? "未設定"}'),
                _TitleLabelWithBoldText(
                    label: '役職', text: '${userData["position"] ?? "未設定"}'),
                const SizedBox(),
                _TitleLabelWithText(
                    label: '最終更新',
                    text: userData["updatedAt"].toDate().toString()),
                ElevatedButton(
                  onPressed: () {
                    logger.i('プロフィール編集');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: QTankColor.orange,
                    onPrimary: QTankColor.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    child: Text(
                      'プロフィール編集',
                      style: QTankTextStyle.buttonText,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.logout_rounded,
                        color: QTankColor.red,
                      ),
                      TextButton(
                        onPressed: () async {
                          var dialogResult = await showDialog<bool>(
                            context: context,
                            builder: (_) {
                              return const ConfirmationDialog(
                                dialogMessage: 'ログアウトしてもよろしいですか？',
                              );
                            },
                          );
                          if (dialogResult == true) {
                            logger.i('サインアウト処理');
                            // ignore: use_build_context_synchronously
                            viewModel.signOut(context);
                          }
                        },
                        child: const Text(
                          'アプリからサインアウト',
                          style: QTankTextStyle.alertTextBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        error: (err, stack) => Text('Error: $err'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _TitleLabelWithText extends StatelessWidget {
  const _TitleLabelWithText({
    Key? key,
    required this.label,
    required this.text,
  }) : super(key: key);
  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$label: ',
          style: QTankTextStyle.subtitle,
        ),
        Text(
          text,
          style: QTankTextStyle.subtitle,
        ),
      ],
    );
  }
}

class _TitleLabelWithBoldText extends StatelessWidget {
  const _TitleLabelWithBoldText({
    Key? key,
    required this.label,
    required this.text,
  }) : super(key: key);
  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$label: ',
          style: QTankTextStyle.subtitleBold,
        ),
        Text(
          text,
          style: QTankTextStyle.subtitleBold,
        ),
      ],
    );
  }
}
