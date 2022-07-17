import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/utility/logger/logger.dart';
import '../../../data/view_model/auth_page_view_model.dart';
import '../../style/color.dart';
import '../../style/style.dart';
import '../common_components/dialog.dart';

class CreateUserPage extends ConsumerWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(authPageProvider);
    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        title: const Text('新規登録'),
        backgroundColor: QTankColor.grey,
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const SizedBox(height: 20),
                _UserIcon(viewModel: viewModel),
                _UserNameForm(viewModel: viewModel),
                _EmailForm(viewModel: viewModel),
                _PasswordField(viewModel: viewModel),
                _BelongForm(viewModel: viewModel),
                _PositionForm(viewModel: viewModel),
                const SizedBox(height: 20),
                _CreateButton(viewModel: viewModel),
                const SizedBox(height: 20),
                const _NavigateCreatePageButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UserIcon extends StatelessWidget {
  const _UserIcon({
    Key? key,
    required this.viewModel,
  }) : super(key: key);
  final AuthPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            logger.i('image picker');
            await viewModel.pickAndStoreImage();
          },
          child: SizedBox(
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: viewModel.userImagePath.isEmpty
                  ? Image.asset(
                      'assets/tank-solo.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error);
                      },
                    )
                  : Image.network(
                      viewModel.userImagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error);
                      },
                    ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            '画像をタップして変更',
            style: TextStyle(
              color: QTankColor.white,
              fontSize: 10,
            ),
          ),
        )
      ],
    );
  }
}

class _UserNameForm extends StatelessWidget {
  const _UserNameForm({
    Key? key,
    required this.viewModel,
  }) : super(key: key);
  final AuthPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text('ユーザー名', style: QTankTextStyle.subtitle),
            _RequiredLabel(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: TextField(
            onChanged: (value) {
              viewModel.setUserName(value);
            },
            style: QTankTextStyle.subtitle,
            decoration: const InputDecoration(
              hintText: 'QTank太郎',
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
        Row(
          children: const [
            Text('メールアドレス', style: QTankTextStyle.subtitle),
            _RequiredLabel(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: TextField(
            onChanged: (value) {
              viewModel.setEmail(value);
            },
            style: QTankTextStyle.subtitle,
            decoration: const InputDecoration(
              hintText: 'q-tank@gmail.com',
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
        Row(
          children: const [
            Text('パスワード', style: QTankTextStyle.subtitle),
            _RequiredLabel(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: TextField(
            onChanged: (value) {
              viewModel.setPassword(value);
            },
            obscureText: true,
            style: QTankTextStyle.subtitle,
            decoration: InputDecoration(
              hintText: 'passeord',
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

class _BelongForm extends StatelessWidget {
  const _BelongForm({
    Key? key,
    required this.viewModel,
  }) : super(key: key);
  final AuthPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text('所属', style: QTankTextStyle.subtitle),
            _OptionalLabel(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: TextField(
            onChanged: (value) {
              viewModel.setBelong(value);
            },
            style: QTankTextStyle.subtitle,
            decoration: const InputDecoration(
              hintText: '所属',
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

class _PositionForm extends StatelessWidget {
  const _PositionForm({
    Key? key,
    required this.viewModel,
  }) : super(key: key);
  final AuthPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text('役職', style: QTankTextStyle.subtitle),
            _OptionalLabel(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: TextField(
            onChanged: (value) {
              viewModel.setPosition(value);
            },
            style: QTankTextStyle.subtitle,
            decoration: const InputDecoration(
              hintText: '役職',
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

class _CreateButton extends StatelessWidget {
  const _CreateButton({
    Key? key,
    required this.viewModel,
  }) : super(key: key);
  final AuthPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        var dialogResult = await showDialog<bool>(
          context: context,
          builder: (_) {
            return const ConfirmationDialog(
              dialogMessage: '入力した内容で登録しますか？',
            );
          },
        );
        if (dialogResult == true) {
          logger.i('新規登録処理');
          // ignore: use_build_context_synchronously
          viewModel.signUp(context);
        }
      },
      style: ElevatedButton.styleFrom(
        primary: QTankColor.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Text(
          '新規登録する',
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
      onPressed: () => context.go('/auth/login'),
      child: const Text('ログインはこちら'),
    );
  }
}

class _RequiredLabel extends StatelessWidget {
  const _RequiredLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: QTankColor.red,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
        child: Text(
          '必須',
          style: TextStyle(
            color: QTankColor.red,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}

class _OptionalLabel extends StatelessWidget {
  const _OptionalLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: QTankColor.orange,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
        child: Text(
          '任意',
          style: TextStyle(
            color: QTankColor.orange,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
