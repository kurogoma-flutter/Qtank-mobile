import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qtank_mobile/data/model/genre_model.dart';
import 'package:qtank_mobile/data/utility/logger/logger.dart';
import 'package:qtank_mobile/data/view_model/workspace_page_view_model.dart';
import '../../../presentation/style/style.dart';
import '../../style/color.dart';

class QTankWorkSpaceHomePage extends StatelessWidget {
  const QTankWorkSpaceHomePage({
    Key? key,
    required this.workspaceId,
    required this.workspaceName,
  }) : super(key: key);

  final String workspaceId;
  final String workspaceName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              child: SizedBox(
                width: 36,
                height: 36,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    'https://user-images.githubusercontent.com/67848399/179694155-db2690b3-8dc3-4c54-84f8-be156c3e0d4b.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      logger.e(error, stackTrace);
                      return Image.asset('assets/tank-only.png');
                    },
                  ),
                ),
              ),
              onTap: () => context.go('/'),
            ),
            const SizedBox(width: 12),
            Text(workspaceName, style: QTankTextStyle.title),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.settings, color: QTankColor.white),
              onPressed: () {
                context.push('/workspace_setting/$workspaceId');
              },
            ),
          ],
        ),
        backgroundColor: QTankColor.grey,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
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
                        logger.i('新しいルーム追加処理');
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
                        logger.i('ジャンルを管理');
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
                        context.push('/workspace_member_list');
                      },
                    ),
                    const Padding(
                      // leftのpaddingとrightのpaddingを同じにする
                      padding:
                          EdgeInsets.only(right: 18.0, top: 16, bottom: 10),
                      child: Text(
                        'QAルーム一覧',
                        style: QTankTextStyle.subtitle,
                      ),
                    ),
                    _GenreAndRoomList(workspaceId: workspaceId),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GenreAndRoomList extends StatelessWidget {
  const _GenreAndRoomList({
    Key? key,
    required this.workspaceId,
  }) : super(key: key);

  final String workspaceId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer(builder: (context, ref, child) {
        final future = ref.watch(workspaceGenreFutureProvider(workspaceId));
        return ListView(
          children: <Widget>[
            future.when(
              data: ((genre) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: genre.length,
                    itemBuilder: (context, index) {
                      return _GenreAndRoomExpansionTile(
                        genre: genre[index],
                        index: index,
                        ref: ref,
                      );
                    });
              }),
              error: ((error, stackTrace) {
                return const Center(
                  child: Text('エラーが発生しました。'),
                );
              }),
              loading: () => const SizedBox(),
            )
          ],
        );
      }),
    );
  }
}

class _GenreAndRoomExpansionTile extends StatelessWidget {
  const _GenreAndRoomExpansionTile({
    Key? key,
    required this.ref,
    required this.genre,
    required this.index,
  }) : super(key: key);

  final WidgetRef ref;
  final GenreModel genre;
  final int index;

  @override
  Widget build(BuildContext context) {
    final roomFuture = ref
        .watch(workspaceRoomFutureProvider([genre.genreId, genre.workspaceId]));
    return ExpansionTile(
      initiallyExpanded: index == 0, // １つ目だけオープンにする
      iconColor: QTankColor.greyWhite,
      title: _QTankRoomGenreTitle(
        genreName: genre.genreName,
        genreId: genre.genreId,
        icon: genre.icon,
      ),
      children: [
        roomFuture.when(data: (room) {
          return SizedBox(
            height: 50.0 * room.length,
            child: ListView.builder(
              itemCount: room.length,
              itemBuilder: ((context, index) {
                return SizedBox(
                  width: 200,
                  child: _QTankRoomListItem(
                    roomName: room[index].name,
                    roomId: room[index].roomId,
                  ),
                );
              }),
            ),
          );
        }, error: ((error, stackTrace) {
          logger.w('Future Error');
          return const Center(
            child: Text('エラーが発生しました。'),
          );
        }), loading: () {
          return const SizedBox();
        }),
      ],
    );
  }
}

/// ジャンルのタイトル
class _QTankRoomGenreTitle extends StatelessWidget {
  const _QTankRoomGenreTitle({
    Key? key,
    required this.genreName,
    required this.icon,
    required this.genreId,
  }) : super(key: key);

  final String genreName;
  final String icon;
  final String genreId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(genreName, style: QTankTextStyle.miniTitle),
        const SizedBox(width: 10),
        Text(
          icon,
          style: QTankTextStyle.miniTitle,
        ),
      ],
    );
  }
}

/// ルーム名のタイトル
class _QTankRoomListItem extends StatelessWidget {
  const _QTankRoomListItem({
    Key? key,
    required this.roomName,
    required this.roomId,
  }) : super(key: key);

  final String roomName;
  final String roomId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        children: [
          const Text('#', style: QTankTextStyle.subtitle),
          const SizedBox(width: 6),
          Text(roomName, style: QTankTextStyle.subtitle),
        ],
      ),
    );
  }
}

/// 検索バー
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
