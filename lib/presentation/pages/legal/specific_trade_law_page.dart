import 'package:flutter/material.dart';
import 'package:qtank_mobile/presentation/pages/legal/component/legal_text_widget.dart';

import '../../style/color.dart';

class SpecificTradeLawPage extends StatelessWidget {
  const SpecificTradeLawPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        title: const Text('特定商取引法に基づく表示'),
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
              LegalText(text: '本規約は、本サービスを利用するすべての方に適用されるものとします。'),
              LegalTitle(text: '第2条（本規約の変更）'),
              LegalText(text: '当社は、必要に応じて本規約を変更することができるものとします。'),
              LegalTitle(text: '第3条（本サービスの利用）'),
              LegalText(text: '本サービスを利用するには、本規約に同意する必要があります。'),
            ],
          ),
        ),
      ),
    );
  }
}
