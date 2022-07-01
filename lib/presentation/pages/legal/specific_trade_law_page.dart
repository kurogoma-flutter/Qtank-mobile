import 'package:flutter/material.dart';

import '../../style/color.dart';

class SpecificTradeLawPage extends StatelessWidget {
  const SpecificTradeLawPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QTankColor.white,
      appBar: AppBar(
        title: const Text('特定商取引法に基づく表示'),
        backgroundColor: QTankColor.grey,
        centerTitle: true,
        elevation: 0,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Center(
          child: Text('特定商取引法に基づく表示'),
        ),
      ),
    );
  }
}
