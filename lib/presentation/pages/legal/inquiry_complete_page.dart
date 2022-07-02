import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qtank_mobile/presentation/style/color.dart';
import 'package:qtank_mobile/presentation/style/style.dart';

class InquiryCompletePage extends StatelessWidget {
  const InquiryCompletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QTankColor.white,
      appBar: AppBar(
        backgroundColor: QTankColor.grey,
        title: const Text('お問い合わせ完了'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'お問合せいただきありがとうございました。\n後日運営からご連絡させて頂きます。\n\nお問合せいただいた内容は、今後のアプリケーション改善のために活用させていただきます。',
              style: QTankTextStyle.miniTitleBlack,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                context.go('/');
              },
              child: const Text('ホームへ戻る'),
            ),
          ],
        ),
      ),
    );
  }
}
