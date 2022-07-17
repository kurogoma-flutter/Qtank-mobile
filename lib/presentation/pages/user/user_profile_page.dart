import 'package:flutter/material.dart';
import 'package:qtank_mobile/data/utility/logger/logger.dart';
import 'package:qtank_mobile/presentation/style/color.dart';

import '../../style/style.dart';
import '../common_components/dialog.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        title: const Text('ユーザープロフィール'),
        backgroundColor: QTankColor.grey,
        elevation: 0,
        centerTitle: false,
      ),
      body: SizedBox(
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
            const Text(
              'ユーザー名',
              style: QTankTextStyle.largeTitle,
            ),
            const _TitleLabelWithBoldText(label: 'ID', text: '@VdPA53GW4g6BW'),
            const _TitleLabelWithBoldText(
                label: 'Email', text: 'dammy@example.com'),
            const _TitleLabelWithBoldText(label: '所属', text: 'ソリューション事業部 第二課'),
            const _TitleLabelWithBoldText(label: '役職', text: '人事部長補佐'),
            const SizedBox(),
            const _TitleLabelWithText(label: '最終更新', text: '2022/02/02'),
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
