import 'package:flutter/material.dart';
import 'package:qtank_mobile/presentation/style/color.dart';
import 'package:qtank_mobile/presentation/style/style.dart';
import 'package:go_router/go_router.dart';

class SimpleErrorPage extends StatelessWidget {
  const SimpleErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QTankColor.white,
      appBar: AppBar(
        title: const Text('エラー'),
        backgroundColor: QTankColor.black,
        elevation: 0,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox.expand(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'エラーが発生しました。\nアプリを再起動するか管理者に問い合わせてください。',
              style: QTankTextStyle.alertTextBold,
            ),
            const SizedBox(height: 40),
            TextButton(
              onPressed: () => context.go('/'),
              child: const Text('トップへ戻る'),
            ),
          ],
        )),
      ),
    );
  }
}
