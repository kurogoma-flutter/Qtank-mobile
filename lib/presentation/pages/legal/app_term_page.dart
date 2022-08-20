import 'package:flutter/material.dart';

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
      body: const SizedBox.expand(
        child: Center(
          child: Text('アプリ利用規約'),
        ),
      ),
    );
  }
}
