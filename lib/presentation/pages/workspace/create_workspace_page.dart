import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qtank_mobile/data/view_model/workspace_page_view_model.dart';
import 'package:qtank_mobile/presentation/style/style.dart';

import '../../style/color.dart';
import '../common_components/dialog.dart';

class CreateWorkSpacePage extends ConsumerWidget {
  const CreateWorkSpacePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(workspacePageViewModelProvider);
    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        title: const Text('ワークスペースを作成'),
        backgroundColor: QTankColor.grey,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: MediaQuery.of(context).size.height * 0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      counterText: '',
                      label: const Text('(例):株式会社QTank'),
                      labelStyle: QTankTextStyle.subtitle,
                      helperMaxLines: 5,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: QTankColor.lightBlue,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: QTankColor.lightBlue,
                        ),
                      ),
                    ),
                    maxLines: 1,
                    maxLength: 50,
                    style: QTankTextStyle.miniTitle,
                    onChanged: (value) {
                      viewModel.updateWorkspaceName(value);
                    },
                  ),
                  const SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: '「アプリ利用規約」',
                            style: const TextStyle(color: QTankColor.lightBlue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => context.push('/legal/app_term')),
                        const TextSpan(
                            text: '及び', style: QTankTextStyle.subtitle),
                        TextSpan(
                            text: '「プライバシーポリシー」',
                            style: const TextStyle(color: QTankColor.lightBlue),
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => context.push('/legal/privacy_policy')),
                        const TextSpan(
                            text:
                                'に同意をした上で作成をしてください。作成をすることで、各種ポリシーに同意したものとみなします。規約についての質問は',
                            style: QTankTextStyle.subtitle),
                        TextSpan(
                            text: '「お問合せ」',
                            style: const TextStyle(color: QTankColor.lightBlue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => context.push('/legal/inquiry')),
                        const TextSpan(
                            text: 'からお願いします。', style: QTankTextStyle.subtitle),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: QTankColor.orange,
                      onPrimary: QTankColor.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'ワークスペースを作成',
                        style: QTankTextStyle.buttonText,
                      ),
                    ),
                    onPressed: () async {
                      // 空白の場合はエラーを表示する
                      if (viewModel.newWorkspaceName.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => const ConfirmationDialog(
                            dialogMessage: 'ワークスペース名を入力してください',
                          ),
                        );
                        return;
                      }

                      // 確認 => 登録
                      var dialogResult = await showDialog<bool>(
                        context: context,
                        builder: (_) {
                          return ConfirmationDialog(
                            dialogMessage:
                                'ワークスペース「${viewModel.newWorkspaceName}」を作成しますか？',
                          );
                        },
                      );
                      if (dialogResult == true) {
                        // ignore: use_build_context_synchronously
                        await viewModel.createNewWorkSpace(context);
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  TextButton(
                    onPressed: () => context.go('/'),
                    child:
                        const Text('ホームへ戻る', style: QTankTextStyle.alertText),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
