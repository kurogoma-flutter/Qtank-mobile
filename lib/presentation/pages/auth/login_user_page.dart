import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qtank_mobile/data/view_model/auth_page_view_model.dart';

import '../../../data/utility/logger/logger.dart';
import '../../style/color.dart';
import '../../style/style.dart';
import '../common_components/dialog.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(authPageProvider);
    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        title: const Text('ログイン'),
        backgroundColor: QTankColor.grey,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const SizedBox(),
            _EmailForm(viewModel: viewModel),
            _PasswordField(viewModel: viewModel),
            _LoginButton(viewModel: viewModel),
            const _NavigateCreatePageButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailForm extends StatelessWidget {
  const _EmailForm({
    Key? key,
    required this.viewModel,
  }) : super(key: key);
  final AuthPageViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('メールアドレス', style: QTankTextStyle.subtitle),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: TextField(
            onChanged: (value) {
              viewModel.setEmail(value);
            },
            style: QTankTextStyle.subtitle,
            decoration: const InputDecoration(
              hintText: 'qtank@gmail.com',
              hintStyle: QTankTextStyle.subtitle,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: QTankColor.orange),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: QTankColor.orange),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    Key? key,
    required this.viewModel,
  }) : super(key: key);
  final AuthPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('パスワード', style: QTankTextStyle.subtitle),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: TextField(
            onChanged: (value) {
              viewModel.setPassword(value);
            },
            obscureText: true,
            style: QTankTextStyle.subtitle,
            decoration: InputDecoration(
              hintText: 'password',
              hintStyle: QTankTextStyle.subtitle,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: QTankColor.orange),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: QTankColor.orange),
              ),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.remove_red_eye,
                  color: QTankColor.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
    required this.viewModel,
  }) : super(key: key);
  final AuthPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        logger.d('ログイン処理');
        final validateResult = viewModel.validateLoginText();
        if (validateResult.isNotEmpty) {
          showDialog(
            context: context,
            builder: (context) => ConfirmationDialog(
              dialogMessage: validateResult,
            ),
          );
        } else {
          viewModel.loginWithEmail(context);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: QTankColor.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Text(
          'ログインする',
          style: QTankTextStyle.buttonText,
        ),
      ),
    );
  }
}

class _NavigateCreatePageButton extends StatelessWidget {
  const _NavigateCreatePageButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.go('/auth/create'),
      child: const Text('新規登録はこちら'),
    );
  }
}
