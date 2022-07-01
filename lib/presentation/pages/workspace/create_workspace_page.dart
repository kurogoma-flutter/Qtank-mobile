import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qtank_mobile/presentation/style/style.dart';

import '../../style/color.dart';

class CreateWorkSpacePage extends StatelessWidget {
  const CreateWorkSpacePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        title: const Text('ワークスペースを作成'),
        backgroundColor: QTankColor.grey,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    counterText: '',
                    label: const Text('(例):株式会社QTank'),
                    labelStyle: QTankTextStyle.subtitle,
                    helperMaxLines: 5,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: QTankColor.lightBlue,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: QTankColor.lightBlue,
                      ),
                    ),
                  ),
                  maxLines: 1,
                  maxLength: 50,
                  style: QTankTextStyle.miniTitle,
                ),
                const SizedBox(height: 16),
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                        text: '「アプリ利用規約」',
                        style: const TextStyle(color: QTankColor.lightBlue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.push('/legal/app_term')),
                    const TextSpan(text: '及び', style: QTankTextStyle.subtitle),
                    TextSpan(
                        text: '「プライバシーポリシー」',
                        style: const TextStyle(color: QTankColor.lightBlue),
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () => context.push('/legal/privacy_policy')),
                    const TextSpan(
                        text:
                            'に同意をした上で作成をしてください。作成をすることで、各種ポリシーに同意したものとみなします。規約についての質問は',
                        style: QTankTextStyle.subtitle),
                    TextSpan(
                        text: '「お問合せ」',
                        style: const TextStyle(color: QTankColor.lightBlue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.push('/legal/inquiry')),
                    const TextSpan(
                        text: 'からお願いします。', style: QTankTextStyle.subtitle),
                  ],
                ))
              ],
            ),
            TextButton(
              onPressed: () => context.go('/'),
              child: const Text(
                'ホームへ戻る',
                style: QTankTextStyle.alertText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
