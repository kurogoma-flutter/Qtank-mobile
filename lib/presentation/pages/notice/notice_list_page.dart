import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtank_mobile/presentation/style/color.dart';
import 'package:qtank_mobile/presentation/style/style.dart';

class NoticeListPage extends ConsumerWidget {
  const NoticeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        title: const Text(
          '通知一覧',
          style: QTankTextStyle.titleBlack,
        ),
        backgroundColor: Colors.grey,
        centerTitle: true,
        elevation: 0,
      ),
      body: const Center(child: Text('通知一覧')),
    );
  }
}
