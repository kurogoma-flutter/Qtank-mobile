import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qtank_mobile/data/utility/logger/logger.dart';
// import 'package:qtank_mobile/data/view_model/workspace_page_view_model.dart';
import 'package:qtank_mobile/presentation/style/color.dart';
import 'package:qtank_mobile/presentation/style/style.dart';

import '../common_components/dialog.dart';

class QTankListViewPage extends ConsumerWidget {
  const QTankListViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final viewModel = ref.watch(workspacePageViewModelProvider);

    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('ワークスペース'),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: 40,
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/dammy_icon_3.png'),
                ),
              ),
              onTap: () => context.push('/user_profile'),
            ),
          ],
        ),
        backgroundColor: QTankColor.grey,
        elevation: 0,
        centerTitle: false,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: const _QTankListItem(),
                    onTap: () => context.push('/workspace/XXXXXX'),
                  );
                },
              ),
            ),
            const Divider(color: QTankColor.greyWhite, height: 0.5),
            const _QTankActionMenuList(),
          ],
        ),
      ),
    );
  }
}

class _QTankListItem extends StatelessWidget {
  const _QTankListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Row(
        children: const <Widget>[
          _QTankListItemImage(),
          _QTankListItemInfo(),
          Spacer(),
          _QTankListItemAction(),
        ],
      ),
    );
  }
}

class _QTankListItemImage extends StatelessWidget {
  const _QTankListItemImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          width: 65,
          height: 65,
          color: Colors.transparent,
        ),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: QTankColor.grey, width: 2),
            color: QTankColor.white,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('assets/tank-only.png'),
          ),
        ),
        const Positioned(
          top: -1,
          right: -1,
          child: _NotReadIcon(),
        ),
      ],
    );
  }
}

class _NotReadIcon extends StatelessWidget {
  const _NotReadIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Visibility(
      visible: true,
      child: CircleAvatar(
        backgroundColor: QTankColor.black,
        maxRadius: 9,
        child: CircleAvatar(
          backgroundColor: QTankColor.orange,
          maxRadius: 6,
        ),
      ),
    );
  }
}

class _QTankListItemInfo extends StatelessWidget {
  const _QTankListItemInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('ワークスペースネーム', style: QTankTextStyle.miniTitle),
          Text('https://url.com', style: QTankTextStyle.subtitle),
        ],
      ),
    );
  }
}

class _QTankListItemAction extends StatelessWidget {
  const _QTankListItemAction({Key? key}) : super(key: key);

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const _BottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => displayBottomSheet(context),
      icon: const Icon(
        Icons.more_vert_rounded,
        color: QTankColor.white,
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  const _BottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Container(
        decoration: const BoxDecoration(
          color: QTankColor.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 35,
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: QTankColor.grey, width: 1),
                          color: QTankColor.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset('assets/tank-only.png'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text('ワークスペースの設定をする',
                          style: QTankTextStyle.miniTitleBlack),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  context.push('/workspace_setting');
                },
              ),
            ),
            const Divider(color: QTankColor.greyWhite, height: 0.2),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 35,
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.engineering_rounded,
                        color: QTankColor.black,
                      ),
                      SizedBox(width: 10),
                      Text('メンバーの設定をする', style: QTankTextStyle.miniTitleBlack),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  context.push('/workspace_member_list');
                },
              ),
            ),
            const Divider(color: QTankColor.greyWhite, height: 0.2),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 35,
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.logout_outlined,
                        color: QTankColor.red,
                      ),
                      SizedBox(width: 10),
                      Text('ワークスペースから退出する',
                          style: QTankTextStyle.alertTextBold),
                    ],
                  ),
                ),
                onTap: () async {
                  var dialogResult = await showDialog<bool>(
                    context: context,
                    builder: (_) {
                      return const ConfirmationDialog(
                        dialogMessage: 'ワークスペースから退出してもよろしいですか？',
                      );
                    },
                  );
                  if (dialogResult == true) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                    logger.i('退出処理');
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _QTankActionMenuList extends StatelessWidget {
  const _QTankActionMenuList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: QTankColor.black,
      height: 190,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: const _QTankActionMenuItem(
              icon: Icons.fiber_new,
              title: 'ワークスペースを新規追加',
            ),
            onTap: () {
              context.go('/create_workspace');
            },
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: const _QTankActionMenuItem(
              icon: Icons.settings_rounded,
              title: 'アプリの設定・規約',
            ),
            onTap: () {
              context.push('/setting_app_and_legal');
            },
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: const _QTankActionMenuItem(
              icon: Icons.question_mark_rounded,
              title: 'QAヘルプ・お問合せ',
            ),
            onTap: () {
              context.push('/legal/inquiry');
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _QTankActionMenuItem extends StatelessWidget {
  const _QTankActionMenuItem({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            CircleAvatar(
              maxRadius: 18,
              backgroundColor: QTankColor.grey,
              child: Icon(
                icon,
                color: QTankColor.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 20),
            Text(title, style: QTankTextStyle.miniTitle),
          ],
        ),
      ),
    );
  }
}
