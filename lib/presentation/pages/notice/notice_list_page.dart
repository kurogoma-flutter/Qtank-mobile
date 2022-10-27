import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtank_mobile/data/model/notification_model.dart';
import 'package:qtank_mobile/presentation/style/color.dart';
import 'package:qtank_mobile/presentation/style/style.dart';

final dummyNotificationModelList = <NotificationModel>[
  NotificationModel(
    notificationId: 'xxxx001',
    targetUserId: 'user0001',
    summary: '通知概要通知概要',
    notificationTitle: '通知タイトル通知タイトル',
    notificationDetail: '通知本文通知本文',
    isRead: true,
    createdAt: Timestamp.now(),
  ),
  NotificationModel(
    notificationId: 'xxxx002',
    targetUserId: 'user0001',
    summary: '新規リリース通知について',
    notificationTitle: 'りリースしたよ！',
    notificationDetail: '機能概要機能概要',
    isRead: true,
    createdAt: Timestamp.now(),
  ),
  NotificationModel(
    notificationId: 'xxxx003',
    targetUserId: 'user0001',
    summary: 'ワークスペースにメンバーが参加しました',
    notificationTitle: 'ワークスペースにメンバーが参加しました',
    notificationDetail: '〇〇さんが来た。よろしく。',
    isRead: true,
    createdAt: Timestamp.now(),
  ),
  NotificationModel(
    notificationId: 'xxxx004',
    targetUserId: 'user0001',
    summary: 'アプリバグレポート',
    notificationTitle: 'バグ報告バグ報告',
    notificationDetail: 'バグですバグです',
    isRead: true,
    createdAt: Timestamp.now(),
  ),
  NotificationModel(
    notificationId: 'xxxx005',
    targetUserId: 'user0001',
    summary: '通知概要通知概要',
    notificationTitle: '通知タイトル通知タイトル',
    notificationDetail: '通知本文通知本文',
    isRead: true,
    createdAt: Timestamp.now(),
  ),
];

class NoticeListPage extends ConsumerWidget {
  const NoticeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        title: const Text(
          '通知一覧',
          style: QTankTextStyle.title,
        ),
        backgroundColor: QTankColor.grey,
        centerTitle: true,
        elevation: 0,
      ),
      body: dummyNotificationModelList.isNotEmpty
          ? ListView.separated(
              itemCount: dummyNotificationModelList.length,
              separatorBuilder: (context, index) => const Divider(
                color: QTankColor.white,
                height: 0,
              ),
              itemBuilder: (context, index) {
                final notificationModel = dummyNotificationModelList[index];
                return ListTile(
                  title: Text(
                    notificationModel.summary,
                    style: QTankTextStyle.miniTitle,
                  ),
                  subtitle: Text(
                    notificationModel.notificationTitle,
                    style: QTankTextStyle.planeWhiteText,
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: QTankColor.white,
                  ),
                  onTap: () {
                    // TODO: 通知詳細画面へ遷移
                  },
                );
              },
            )
          : const Center(
              child: Text(
                '通知はありません',
                style: QTankTextStyle.planeWhiteText,
              ),
            ),
    );
  }
}
