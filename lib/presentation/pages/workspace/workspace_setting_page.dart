import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qtank_mobile/data/view_model/workspace_page_view_model.dart';
import 'package:qtank_mobile/presentation/style/color.dart';
import 'package:qtank_mobile/presentation/style/style.dart';

import '../../../data/utility/logger/logger.dart';
import '../common_components/dialog.dart';

class WorkSpaceSettingPage extends StatelessWidget {
  const WorkSpaceSettingPage({
    Key? key,
    required this.workspaceId,
  }) : super(key: key);

  final String workspaceId;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('ワークスペース設定'),
        elevation: 0,
        backgroundColor: QTankColor.grey,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.05,
        ),
        child: SizedBox.expand(
          child: _WorkSpaceContentBody(workspaceId: workspaceId),
        ),
      ),
    );
  }
}

class _WorkSpaceContentBody extends ConsumerWidget {
  const _WorkSpaceContentBody({
    Key? key,
    required this.workspaceId,
  }) : super(key: key);

  final String workspaceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workspaceFuture = ref.watch(workspaceFutureProvider(workspaceId));

    return workspaceFuture.when(
      data: (workspace) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _WorkSpaceIcon(
              // 仮置き
              workSpaceImageUrl: workspace.imageUrl ?? '',
            ),
            _WorkSpaceName(
              // 仮置き
              workSpaceName: workspace.name,
            ),
            _WorkSpaceCompanyUrl(
              // 仮置き
              workSpaceCompanyUrl: workspace.companyUrl ?? '',
            ),
            _WorkSpaceSubmitButton(
              workSpaceId: workspace.workspaceId,
            )
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Column(
        children: [
          const Text('エラーが発生しました。再度トップに戻ってやり直すか、管理者にお問合せください。'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('トップに戻る'),
          )
        ],
      ),
    );
  }
}

class _WorkSpaceIcon extends ConsumerWidget {
  const _WorkSpaceIcon({
    Key? key,
    required this.workSpaceImageUrl,
  }) : super(key: key);

  final String workSpaceImageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(workspacePageViewModelProvider);
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await provider.pickUpImage();
          },
          child: SizedBox(
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: provider.selectedImageFile != null
                  ? Image.network(
                      provider.selectedImageFile!.path,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/tank-solo.png',
                            fit: BoxFit.cover);
                      },
                    )
                  : Image.network(
                      workSpaceImageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/tank-solo.png',
                            fit: BoxFit.cover);
                      },
                    ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            '画像をタップして変更',
            style: TextStyle(
              color: QTankColor.white,
              fontSize: 10,
            ),
          ),
        )
      ],
    );
  }
}

class _WorkSpaceName extends StatelessWidget {
  const _WorkSpaceName({
    Key? key,
    required this.workSpaceName,
  }) : super(key: key);

  final String workSpaceName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'ワークスペース名',
          style: TextStyle(
            color: QTankColor.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: TextFormField(
            onChanged: (value) => logger.i(value),
            initialValue: workSpaceName,
            cursorColor: QTankColor.white,
            style: const TextStyle(
              color: QTankColor.white,
              fontSize: 16,
              overflow: TextOverflow.clip,
            ),
            decoration: const InputDecoration(
              hintText: 'ワークスペース名を入力してください',
              hintStyle: TextStyle(
                color: QTankColor.white,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _WorkSpaceCompanyUrl extends StatelessWidget {
  const _WorkSpaceCompanyUrl({
    Key? key,
    required this.workSpaceCompanyUrl,
  }) : super(key: key);
  final String workSpaceCompanyUrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'ワークスペースURL',
          style: TextStyle(
            color: QTankColor.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: TextFormField(
            onChanged: (value) => logger.i(value),
            initialValue: workSpaceCompanyUrl,
            cursorColor: QTankColor.white,
            style: const TextStyle(
              color: QTankColor.white,
              fontSize: 16,
              overflow: TextOverflow.clip,
            ),
            decoration: const InputDecoration(
              hintText: 'https://qtank.com',
              hintStyle: TextStyle(
                color: QTankColor.greyWhite,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _WorkSpaceSubmitButton extends ConsumerWidget {
  const _WorkSpaceSubmitButton({
    Key? key,
    required this.workSpaceId,
  }) : super(key: key);
  final String workSpaceId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(workspacePageViewModelProvider);
    return ElevatedButton(
      onPressed: () async {
        var dialogResult = await showDialog<bool>(
          context: context,
          builder: (_) {
            return const ConfirmationDialog(
              dialogMessage: '入力した内容で変更してよろしいですか？',
            );
          },
        );

        if (dialogResult != null && dialogResult) {
          logger.d('更新処理');

          // ignore: use_build_context_synchronously
          context.go('/');
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: QTankColor.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(
          '変更する',
          style: QTankTextStyle.buttonText,
        ),
      ),
    );
  }
}
