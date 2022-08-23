import 'package:flutter/material.dart';
import 'package:qtank_mobile/presentation/pages/legal/component/legal_text_widget.dart';

import '../../style/color.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        title: const Text('プライバシーポリシー'),
        backgroundColor: QTankColor.grey,
        centerTitle: true,
        elevation: 0,
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              LegalTitle(text: '第1条（適用）'),
              LegalText(
                  text:
                      '本プライバシーポリシーは、QTank（以下「当社」といいます。）が運営するQTank（以下「本サービス」といいます。）の利用者に適用されるものです。'),
              LegalTitle(text: '第2条（個人情報）'),
              LegalText(
                  text:
                      '本サービスでは、利用者の個人情報を取得し、当社が利用者に対して提供するサービス（以下「本サービス」といいます。）において利用することができるものとします。'),
              LegalSubTitle(text: '1. 利用者の個人情報の取得について'),
              LegalText(
                  text:
                      '当社は、利用者の個人情報を取得するために、利用者に対して、利用者に関する情報を提供することができるものとします。'),
              LegalSubTitle(text: '2. 利用者の個人情報の利用について'),
              LegalText(
                  text:
                      '当社は、利用者の個人情報を取得した後、当社が利用者に対して提供するサービス（以下「本サービス」といいます。）において利用することができるものとします。'),
              LegalSubTitle(text: '3. 利用者の個人情報の利用目的について'),
              LegalText(
                  text:
                      '当社は、利用者の個人情報を取得した後、当社が利用者に対して提供するサービス（以下「本サービス」といいます。）において利用することができるものとします。'),
              LegalSubTitle(text: '4. 利用者の個人情報の取得方法について'),
              LegalText(
                  text:
                      '当社は、利用者の個人情報を取得するために、利用者に対して、利用者に関する情報を提供することができるものとします。'),
              LegalText(text: '第3条（個人情報の第三者への提供）'),
              LegalText(
                  text:
                      '当社は、利用者の個人情報を取得した後、当社が利用者に対して提供するサービス（以下「本サービス」といいます。）において利用することができるものとします。'),
            ],
          ),
        ),
      ),
    );
  }
}
