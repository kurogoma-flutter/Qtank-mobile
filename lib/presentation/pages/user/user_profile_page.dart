import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qtank_mobile/data/model/user_model.dart';
import 'package:qtank_mobile/presentation/style/color.dart';

import '../../../data/view_model/auth_page_view_model.dart';
import '../../../data/view_model/user_page_view_model.dart';
import '../../style/style.dart';
import '../common_components/dialog.dart';

class UserProfilePage extends ConsumerWidget {
  const UserProfilePage({
    Key? key,
  }) : super(key: key);

  void displayBottomSheet(
    BuildContext context,
    AuthPageViewModel viewModel,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return _BottomSheet(viewModel: viewModel);
      },
    );
  }

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
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_open),
            onPressed: () => displayBottomSheet(context, viewModel),
          ),
        ],
      ),
      body: future.when(
        data: (user) {
          if (!user.exists) {
            context.go('/auth/login');
          }

          final userData = user.data()!;
          // ユーザー情報をセットする
          viewModel.setCurrentUserInfo(UserModel.fromMap(userData));

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
                  userData['name'] ?? '未設定',
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
                const Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 40),
                  child: _EditProfileButton(),
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

class _EditProfileButton extends StatelessWidget {
  const _EditProfileButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.push('/user_profile/edit');
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

class _BottomSheet extends StatelessWidget {
  const _BottomSheet({
    Key? key,
    required this.viewModel,
  }) : super(key: key);
  final AuthPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Container(
        decoration: const BoxDecoration(
          color: QTankColor.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 35,
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.logout_outlined,
                        color: QTankColor.black,
                      ),
                      SizedBox(width: 10),
                      Text('サインアウトする', style: QTankTextStyle.miniTitleBlack),
                    ],
                  ),
                ),
                onTap: () async {
                  var dialogResult = await showDialog<bool>(
                    context: context,
                    builder: (_) {
                      return const ConfirmationDialog(
                        dialogMessage: 'サインアウトしてもよろしいですか？',
                      );
                    },
                  );
                  if (dialogResult == true) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                    // ignore: use_build_context_synchronously
                    viewModel.signOut(context);
                  }
                },
              ),
            ),
            const Divider(color: QTankColor.greyWhite, height: 0.2),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 35,
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.password_rounded,
                        color: QTankColor.black,
                      ),
                      SizedBox(width: 10),
                      Text('パスワードを変更する', style: QTankTextStyle.miniTitleBlack),
                    ],
                  ),
                ),
                onTap: () async {
                  var dialogResult = await showDialog<bool>(
                    context: context,
                    builder: (_) {
                      return const ConfirmationDialog(
                        dialogMessage:
                            'パスワードの再設定を行いますか？\n「はい」を押すと再設定メールを送信します。',
                      );
                    },
                  );
                  if (dialogResult == true) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                    await viewModel
                        .sendPasswordResetEmail(viewModel.userInfo.email);
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
