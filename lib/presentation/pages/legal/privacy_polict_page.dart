import 'package:flutter/material.dart';

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
      body: const SizedBox.expand(
        child: Center(
          child: Text('プライバシーポリシー'),
        ),
      ),
    );
  }
}
