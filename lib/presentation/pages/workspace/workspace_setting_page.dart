import 'package:flutter/material.dart';
import 'package:qtank_mobile/presentation/style/color.dart';

class WorkSpaceSettingPage extends StatelessWidget {
  const WorkSpaceSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        title: const Text('ワークスペース設定'),
        elevation: 0,
        backgroundColor: QTankColor.grey,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: const Center(child: Text('ワークスペース設定')),
        ),
      ),
    );
  }
}
