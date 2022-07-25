import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qtank_mobile/presentation/style/color.dart';
import 'package:qtank_mobile/presentation/style/style.dart';

import '../../../data/utility/logger/logger.dart';
import '../../../data/view_model/user_page_view_model.dart';
import '../common_components/dialog.dart';

class UserProfileEditPage extends ConsumerWidget {
  const UserProfileEditPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(userPageViewModelProvider);
    final future = ref.watch(usersFutureProvider);
    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        title: const Text('プロフィール編集'),
        backgroundColor: QTankColor.grey,
        elevation: 0,
        centerTitle: true,
      ),
      body: future.when(
        data: (user) {
          if (!user.exists) {
            context.go('/auth/login');
          }

          final userData = user.data()!;
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  _UserIconWithText(iconPath: userData['imageUrl']),
                  _UserProfileForm(
                    label: 'ユーザー名',
                    initialValue: userData['name'],
                    onChange: (value) {
                      viewModel.setUserName(value);
                    },
                    enabled: true,
                  ),
                  _UserProfileForm(
                    label: 'メールアドレス',
                    initialValue: userData['email'],
                    onChange: null,
                    enabled: false,
                  ),
                  _UserProfileForm(
                    label: '所属',
                    initialValue: userData['belong'],
                    onChange: (value) {
                      viewModel.setBelong(value);
                    },
                    enabled: true,
                  ),
                  _UserProfileForm(
                    label: '役職',
                    initialValue: userData['position'],
                    onChange: (value) {
                      viewModel.setPosition(value);
                    },
                    enabled: true,
                  ),
                  _UserProfileForm(
                    label: '登録日時',
                    initialValue: userData['createdAt'].toDate().toString(),
                    onChange: null,
                    enabled: false,
                  ),
                  _UserProfileForm(
                    label: '最終更新日時',
                    initialValue: userData['updatedAt'].toDate().toString(),
                    onChange: null,
                    enabled: false,
                  ),
                  const SizedBox(height: 20),
                  const _SubmitButton(),
                ],
              ),
            ),
          );
        },
        error: (err, stack) => Center(child: Text('Error: $err')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _UserProfileForm extends StatelessWidget {
  const _UserProfileForm({
    Key? key,
    required this.label,
    required this.initialValue,
    required this.onChange,
    required this.enabled,
  }) : super(key: key);

  final String label;
  final String initialValue;
  final ValueChanged<String>? onChange;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: TextFormField(
        initialValue: initialValue,
        style: QTankTextStyle.subtitle,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: QTankColor.white,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: QTankColor.white,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: QTankColor.white,
            ),
          ),
        ),
        onChanged: onChange,
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        var dialogResult = await showDialog<bool>(
          context: context,
          builder: (_) {
            return const ConfirmationDialog(
              dialogMessage: '入力した内容で変更しますか？',
            );
          },
        );

        if (dialogResult != null && dialogResult) {
          logger.d('変更処理');
        }
      },
      style: ElevatedButton.styleFrom(
        primary: QTankColor.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: Text(
          '編集する',
          style: QTankTextStyle.subtitleBlack,
        ),
      ),
    );
  }
}

class _UserIconWithText extends StatelessWidget {
  const _UserIconWithText({
    Key? key,
    required this.iconPath,
  }) : super(key: key);

  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: SizedBox(
              height: 80,
              width: 80,
              child: Image.asset(
                'assets/dammy_icon_4.png',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'タップして画像を変更',
          style: QTankTextStyle.subtitle,
        ),
      ],
    );
  }
}
