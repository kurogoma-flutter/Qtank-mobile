import 'package:flutter/material.dart';

import '../../style/color.dart';

class WorkSpaceMemberListPage extends StatelessWidget {
  const WorkSpaceMemberListPage({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        title: const Text('メンバー管理'),
        elevation: 0,
        backgroundColor: QTankColor.grey,
      ),
      body: const SingleChildScrollView(
        child: SizedBox.expand(
          child: Center(child: Text('メンバー管理')),
        ),
      ),
    );
  }
}
