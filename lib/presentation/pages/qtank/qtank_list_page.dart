import 'package:flutter/material.dart';
import 'package:qtank_mobile/presentation/style/color.dart';
import 'package:qtank_mobile/presentation/style/style.dart';

class QTankListViewPage extends StatelessWidget {
  const QTankListViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        title: const Text('ワークスペース'),
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
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return const _QTankListItem();
                },
              ),
            ),
            const Divider(color: QTankColor.white, height: 1),
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
          child: CircleAvatar(
            backgroundColor: QTankColor.black,
            maxRadius: 9,
            child: CircleAvatar(
              backgroundColor: QTankColor.orange,
              maxRadius: 6,
            ),
          ),
        ),
      ],
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

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.more_vert_rounded,
        color: QTankColor.white,
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
      height: 180,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: const <Widget>[
          SizedBox(height: 10),
          _QTankActionMenuItem(
            icon: Icons.fiber_new,
            title: 'ワークスペースを新規追加',
          ),
          _QTankActionMenuItem(
            icon: Icons.settings_rounded,
            title: 'ワークスペースの設定',
          ),
          _QTankActionMenuItem(
            icon: Icons.question_mark_rounded,
            title: 'QAヘルプ',
          ),
          SizedBox(height: 10),
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
