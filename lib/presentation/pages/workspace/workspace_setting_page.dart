import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qtank_mobile/data/model/workspace_model.dart';
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

    print(workspaceId);

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
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.05,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _WorkSpaceIcon(
              // 仮置き
              workSpaceImageUrl: WorkspaceModel.initialData().imageUrl!,
            ),
            _WorkSpaceName(
              // 仮置き
              workSpaceName: WorkspaceModel.initialData().name,
            ),
            _WorkSpaceCompanyUrl(
              // 仮置き
              workSpaceCompanyUrl: WorkspaceModel.initialData().companyUrl!,
            ),
            _WorkSpaceSubmitButton(
              workSpaceId: WorkspaceModel.initialData().workspaceId,
            )
          ],
        ),
      ),
    );
  }
}

class _WorkSpaceIcon extends StatelessWidget {
  const _WorkSpaceIcon({
    Key? key,
    required this.workSpaceImageUrl,
  }) : super(key: key);

  final String workSpaceImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            logger.i('image picker');
          },
          child: SizedBox(
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/tank-solo.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
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
            initialValue: 'ワークスペース名',
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
            initialValue: 'https://qtank.com',
            cursorColor: QTankColor.white,
            style: const TextStyle(
              color: QTankColor.white,
              fontSize: 16,
              overflow: TextOverflow.clip,
            ),
            decoration: const InputDecoration(
              hintText: 'https://qtank.com',
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

class _WorkSpaceSubmitButton extends StatelessWidget {
  const _WorkSpaceSubmitButton({
    Key? key,
    required this.workSpaceId,
  }) : super(key: key);
  final String workSpaceId;
  @override
  Widget build(BuildContext context) {
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
        primary: QTankColor.orange,
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
