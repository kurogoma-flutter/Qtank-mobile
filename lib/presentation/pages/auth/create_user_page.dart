import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/utility/logger/logger.dart';
import '../../style/color.dart';
import '../../style/style.dart';

class CreateUserPage extends ConsumerWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              children: const <Widget>[
                SizedBox(height: 20),
                _UserIcon(),
                _UserNameForm(),
                _EmailForm(),
                _PasswordField(),
                _BelongForm(),
                _PositionForm(),
                SizedBox(height: 20),
                _CreateButton(),
                SizedBox(height: 20),
                _NavigateCreatePageButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UserIcon extends StatelessWidget {
  const _UserIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            logger.i('image picker');
          },
          child: SizedBox(
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/tank-solo.png',
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
  }) : super(key: key);

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
              logger.i(value);
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
  }) : super(key: key);

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
              logger.i(value);
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
  }) : super(key: key);

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
              logger.i(value);
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
  }) : super(key: key);

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
              logger.i(value);
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
  }) : super(key: key);

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
              logger.i(value);
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
  const _CreateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        logger.d('登録処理');
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
      onPressed: () => context.push('/auth/login'),
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
