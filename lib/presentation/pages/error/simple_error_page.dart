import 'package:flutter/material.dart';
import 'package:qtank_mobile/presentation/style/style.dart';
import 'package:go_router/go_router.dart';

class SimpleErrorPage extends StatelessWidget {
  const SimpleErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text('エラー'),
        backgroundColor: Colors.red,
        elevation: 0,
        centerTitle: false,
      ),
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const Text(
                'エラーが発生しました。\nアプリを再起動するか管理者に問い合わせてください。',
                style: QTankTextStyle.title,
              ),
              TextButton(
                onPressed: () => context.go('/'),
                child: const Text('トップへ戻る'),
              ),
            ],
          )),
    );
  }
}
