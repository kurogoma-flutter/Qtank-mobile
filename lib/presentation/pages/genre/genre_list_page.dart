import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qtank_mobile/data/view_model/workspace_page_view_model.dart';
import 'package:qtank_mobile/presentation/style/color.dart';
import 'package:qtank_mobile/presentation/style/style.dart';

import '../../../data/utility/logger/logger.dart';

class GenreListPage extends ConsumerWidget {
  const GenreListPage({
    Key? key,
    required this.workspaceId,
  }) : super(key: key);

  final String workspaceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genreFuture = ref.watch(workspaceGenreFutureProvider(workspaceId));
    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        backgroundColor: QTankColor.grey,
        title: const Text('ジャンル管理'),
      ),
      body: genreFuture.when(
        data: (genres) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: ListView.builder(
              itemCount: genres.length,
              itemBuilder: (context, index) {
                final genre = genres[index];
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        genre.genreName,
                        style: QTankTextStyle.miniTitle,
                      ),
                      const SizedBox(width: 12),
                      Text(genre.icon),
                    ],
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                    color: QTankColor.white,
                  ),
                  onTap: () {
                    logger.d('tapped');
                  },
                );
              },
            ),
          );
        },
        error: (error, __) => Center(
          child: Column(
            children: [
              const Text('エラーが発生しました'),
              Text(error.toString()),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
