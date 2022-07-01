import 'package:flutter/material.dart';

import '../../style/color.dart';

class AppTermPage extends StatelessWidget {
  const AppTermPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('アプリ利用規約'),
          backgroundColor: QTankColor.grey,
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: QTankColor.white,
          child: const Center(
            child: Text('アプリ利用規約'),
          ),
        ),
      ),
    );
  }
}
