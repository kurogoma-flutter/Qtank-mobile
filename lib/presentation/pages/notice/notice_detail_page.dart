import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtank_mobile/presentation/style/color.dart';

import '../../style/style.dart';

class NoticeDetailPage extends ConsumerWidget {
  const NoticeDetailPage({
    Key? key,
    required this.noticeId,
  }) : super(key: key);

  final String noticeId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        title: const Text(
          '通知タイトル',
          style: QTankTextStyle.titleBlack,
        ),
        backgroundColor: Colors.grey,
        centerTitle: true,
        elevation: 0,
      ),
      body: const Center(child: Text('通知詳細')),
    );
  }
}
