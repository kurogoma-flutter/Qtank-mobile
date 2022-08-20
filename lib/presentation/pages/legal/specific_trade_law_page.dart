import 'package:flutter/material.dart';

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
      body: const SizedBox.expand(
        child: Center(
          child: Text('特定商取引法に基づく表示'),
        ),
      ),
    );
  }
}
