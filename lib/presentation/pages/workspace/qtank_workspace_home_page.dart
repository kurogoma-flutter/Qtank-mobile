import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qtank_mobile/constants/emoji_data.dart';
import '../../../presentation/style/style.dart';
import '../../style/color.dart';

class QTankWorkSpaceHomePage extends StatelessWidget {
  const QTankWorkSpaceHomePage({Key? key, required this.workspaceId})
      : super(key: key);

  final String workspaceId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image.asset(
                  'assets/tank-only.png',
                  height: 36,
                  width: 36,
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () => context.pop(),
            ),
            const SizedBox(width: 12),
            const Text('ワークスペース名', style: QTankTextStyle.title),
            const Spacer(),
            const Icon(Icons.settings, color: QTankColor.white),
          ],
        ),
        backgroundColor: QTankColor.grey,
        elevation: 0,
        centerTitle: false,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: QTankColor.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _SearchBar(),
            Container(
              padding: const EdgeInsets.only(left: 18.0),
              height: MediaQuery.of(context).size.height - 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.add,
                            color: QTankColor.greyWhite,
                          ),
                          SizedBox(width: 16),
                          Text(
                            '新しいルームを追加する',
                            style: QTankTextStyle.subtitle,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      print('新しいルーム追加処理');
                    },
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.grading_rounded,
                            color: QTankColor.greyWhite,
                          ),
                          SizedBox(width: 16),
                          Text(
                            'ジャンル・ルームを管理する',
                            style: QTankTextStyle.subtitle,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      print('ジャンルを管理');
                    },
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.groups_rounded,
                            color: QTankColor.greyWhite,
                          ),
                          SizedBox(width: 16),
                          Text(
                            'メンバーを管理する',
                            style: QTankTextStyle.subtitle,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      print('メンバーを管理する');
                    },
                  ),
                  const Padding(
                    // leftのpaddingとrightのpaddingを同じにする
                    padding: EdgeInsets.only(right: 18.0, top: 16, bottom: 10),
                    child: Text(
                      'QAルーム一覧',
                      style: QTankTextStyle.subtitle,
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: const [
                        ExpansionTile(
                          initiallyExpanded: true,
                          iconColor: QTankColor.greyWhite,
                          title: _QTankRoomGenreTitle(),
                          children: [
                            _QTankRoomListItem(),
                            _QTankRoomListItem(),
                            _QTankRoomListItem(),
                            _QTankRoomListItem(),
                          ],
                        ),
                        ExpansionTile(
                          initiallyExpanded: false,
                          iconColor: QTankColor.greyWhite,
                          title: _QTankRoomGenreTitle(),
                          children: [
                            _QTankRoomListItem(),
                            _QTankRoomListItem(),
                            _QTankRoomListItem(),
                            _QTankRoomListItem(),
                          ],
                        ),
                        ExpansionTile(
                          initiallyExpanded: false,
                          iconColor: QTankColor.greyWhite,
                          title: _QTankRoomGenreTitle(),
                          children: [
                            _QTankRoomListItem(),
                            _QTankRoomListItem(),
                            _QTankRoomListItem(),
                            _QTankRoomListItem(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ルーム名のタイトル
class _QTankRoomListItem extends StatelessWidget {
  const _QTankRoomListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        children: const [
          Text('#', style: QTankTextStyle.subtitle),
          SizedBox(width: 6),
          Text('ルーム名', style: QTankTextStyle.subtitle),
        ],
      ),
    );
  }
}

// ジャンルのタイトル
class _QTankRoomGenreTitle extends StatelessWidget {
  const _QTankRoomGenreTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text('ジャンル名', style: QTankTextStyle.miniTitle),
        const SizedBox(width: 10),
        Text(
          emojiData[22],
          style: QTankTextStyle.miniTitle,
        ),
      ],
    );
  }
}

// 検索バー
class _SearchBar extends StatelessWidget {
  const _SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.only(top: 5),
      child: TextFormField(
        decoration: InputDecoration(
          suffixIcon: const Icon(
            Icons.search_rounded,
            color: QTankColor.white,
            size: 20,
          ),
          hintText: 'QA ルーム 検索',
          hintStyle: const TextStyle(fontSize: 12, color: QTankColor.white),
          fillColor: QTankColor.greyBlack,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: QTankColor.black,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
