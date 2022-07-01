import 'package:flutter/material.dart';

import '../../style/color.dart';

class AboutThisAppPage extends StatelessWidget {
  const AboutThisAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QTankColor.white,
      appBar: AppBar(
        title: const Text('このアプリについて'),
        backgroundColor: QTankColor.grey,
        centerTitle: true,
        elevation: 0,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Center(
          child: Text('このアプリについて'),
        ),
      ),
    );
  }
}
