import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtank_mobile/data/model/notification_model.dart';
import 'package:qtank_mobile/presentation/pages/notice/notice_list_page.dart';
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
    NotificationModel noticeDetail = dummyNotificationModelList[0];

    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        title: Text(
          noticeDetail.notificationTitle,
          style: QTankTextStyle.title,
        ),
        backgroundColor: QTankColor.grey,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          noticeDetail.notificationDetail,
          style: QTankTextStyle.subtitle,
          softWrap: true,
        ),
      ),
    );
  }
}
