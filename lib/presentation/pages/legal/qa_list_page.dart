import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qtank_mobile/data/model/qa_list_model.dart';
import 'package:qtank_mobile/data/view_model/inquiry_page_view_model.dart';
import 'package:qtank_mobile/presentation/style/color.dart';
import 'package:qtank_mobile/presentation/style/style.dart';

class QAPage extends ConsumerWidget {
  const QAPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<QaListModel>> future = ref.watch(qaListFutureProvider);
    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        title: const Text('Q&Aページ'),
        backgroundColor: QTankColor.grey,
      ),
      body: RefreshIndicator(
        backgroundColor: QTankColor.grey,
        color: QTankColor.orange,
        onRefresh: () async => await ref.refresh(qaListFutureProvider),
        child: future.when(
          data: (data) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: QTankColor.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ExpansionTile(
                        title: Text(
                          data[index].question,
                          style: QTankTextStyle.miniTitle,
                        ),
                        initiallyExpanded: false,
                        iconColor: QTankColor.grey,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 20,
                              top: 12,
                            ),
                            child: Text(
                              data[index].answer,
                              style: QTankTextStyle.subtitle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
          error: (error, stackTrace) => const Center(child: Text('現在準備中です。')),
          loading: () => const Center(
            child: CircularProgressIndicator(
              color: QTankColor.orange,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/'),
        backgroundColor: QTankColor.orange,
        child: const Icon(Icons.home_rounded, size: 30),
      ),
    );
  }
}
