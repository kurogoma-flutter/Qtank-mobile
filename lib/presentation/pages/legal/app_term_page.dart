import 'package:flutter/material.dart';
import 'package:qtank_mobile/presentation/pages/legal/component/legal_text_widget.dart';

import '../../style/color.dart';

class AppTermPage extends StatelessWidget {
  const AppTermPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        title: const Text('アプリ利用規約'),
        backgroundColor: QTankColor.grey,
        centerTitle: true,
        elevation: 0,
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              LegalTitle(text: '第1条（適用）'),
              LegalText(
                text:
                    '本規約は、QTank（以下「当社」といいます。）が提供するQTankアプリ（以下「本アプリ」といいます。）の利用に関する条件を定めるものです。本アプリを利用するにあたり、本規約に同意するものとします。',
              ),
              LegalTitle(text: '第2条（利用登録）'),
              LegalText(
                text: '本アプリを利用するにあたり、利用者は、本規約に同意の上、当社の定める方法により利用登録を行うものとします。',
              ),
              LegalTitle(text: '第3条（利用登録の禁止）'),
              LegalText(
                text:
                    '利用者は、以下のいずれかに該当する事由がある場合には、事前に当社に通知することなく、本アプリの利用を禁止することができます。',
              ),
              LegalSubTitle(text: '1.利用登録に際して虚偽の事項を届け出た場合'),
              LegalText(
                text: '利用登録に際して虚偽の事項を届け出た場合',
              ),
              LegalSubTitle(text: '2.本規約のいずれかの条項に違反した場合'),
              LegalText(
                text: '本規約のいずれかの条項に違反した場合',
              ),
              LegalSubTitle(text: '3.その他、当社が利用登録を相当でないと判断した場合'),
              LegalText(
                text: 'その他、当社が利用登録を相当でないと判断した場合',
              ),
              LegalTitle(text: '第4条（利用登録の変更）'),
              LegalText(
                text: '利用者は、当社の定める手続きにより、利用登録を変更できるものとします。',
              ),
              LegalTitle(text: '第5条（利用登録の解除）'),
              LegalText(
                text: '利用者は、当社の定める手続きにより、利用登録を解除できるものとします。',
              ),
              LegalTitle(text: '第6条（プライバシーポリシー）'),
              LegalText(
                text:
                    '利用者は、本アプリに関して、当社が定めるプライバシーポリシーに従って、当社が定める方法により、プライバシー情報を取り扱うものとします。',
              ),
              LegalTitle(text: '第7条（免責事項）'),
              LegalText(text: '当社は、本アプリに関して、以下に定める事項を保証することができます。'),
              LegalSubTitle(text: '1.本アプリに関する一切の責任'),
              LegalText(
                text: '本アプリに関する一切の責任を負うものとします。',
              ),
              LegalSubTitle(text: '2.本アプリに関する一切の責任'),
              LegalText(
                text: '本アプリに関する一切の責任を負うものとします。',
              ),
              LegalTitle(text: '第8条（禁止事項）'),
              LegalText(
                text: '利用者は、本アプリを利用するにあたり、以下の行為をしてはならないものとします。',
              ),
              LegalSubTitle(text: '1.法令または公序良俗に違反する行為'),
              LegalText(
                text: '法令または公序良俗に違反する行為',
              ),
              LegalSubTitle(text: '2.犯罪行為に関連する行為'),
              LegalText(
                text: '犯罪行為に関連する行為',
              ),
              LegalSubTitle(text: '3.当社、本アプリのサーバ、ネットワークの機能を破壊したり、妨害したりする行為'),
              LegalText(
                text: '当社、本アプリのサーバ、ネットワークの機能を破壊したり、妨害したりする行為',
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
