import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/view_model/inquiry_page_view_model.dart';
import '../../style/color.dart';
import '../../style/style.dart';
import '../common_components/dialog.dart';

class InquiryPage extends ConsumerWidget {
  const InquiryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(inquiryPageViewModelProvider);

    return Scaffold(
      backgroundColor: QTankColor.white,
      appBar: AppBar(
        title: const Text('お問合せ'),
        backgroundColor: QTankColor.grey,
        centerTitle: true,
        elevation: 0,
      ),
      body: viewModel.isSending
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('...sending...'),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('お問合せ種別', style: QTankTextStyle.titleBlack),
                    const SizedBox(height: 20),
                    DropdownButton(
                      isExpanded: true,
                      dropdownColor: QTankColor.white,
                      items: const [
                        DropdownMenuItem(
                          value: '選択してください',
                          child: Text('選択してください'),
                        ),
                        DropdownMenuItem(
                          value: 'アプリについての質問',
                          child: Text('アプリについての質問'),
                        ),
                        DropdownMenuItem(
                          value: '違法ユーザーについて',
                          child: Text('違法ユーザーについて'),
                        ),
                        DropdownMenuItem(
                          value: '機能のバグについて',
                          child: Text('機能のバグについて'),
                        ),
                        DropdownMenuItem(
                          value: 'アプリの改善要望について',
                          child: Text('アプリの改善要望について'),
                        ),
                        DropdownMenuItem(
                          value: 'その他',
                          child: Text('その他'),
                        ),
                      ],
                      onChanged: (value) {
                        viewModel.setInquiryType(value);
                      },
                      value: viewModel.inquiryType,
                    ),
                    const SizedBox(height: 40),
                    const Text('お問合せ内容', style: QTankTextStyle.titleBlack),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        counterText: '',
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
                      maxLines: 5,
                      maxLength: 500,
                      style: QTankTextStyle.subtitleBlack,
                      onChanged: (value) {
                        viewModel.setInquiryContent(value);
                      },
                    ),
                    const SizedBox(height: 80),
                    Align(
                      alignment: Alignment.center,
                      child: OutlinedButton(
                        onPressed: () async {
                          // 種別未選択の場合
                          if (viewModel.inquiryType == '選択してください') {
                            showDialog(
                              context: context,
                              builder: (context) => const ConfirmationDialog(
                                dialogMessage: 'お問合せ種別を選択してください',
                              ),
                            );
                            return;
                          }

                          // 問い合わせ内容未入力の場合
                          if (viewModel.inquiryContent.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) => const ConfirmationDialog(
                                dialogMessage: 'お問合せ内容を入力してください',
                              ),
                            );
                            return;
                          }

                          var dialogResult = await showDialog<bool>(
                            context: context,
                            builder: (_) {
                              return const ConfirmationDialog(
                                dialogMessage: ' 入力したお問合せ内容を送信してもよろしいですか？',
                              );
                            },
                          );
                          if (dialogResult == true) {
                            await viewModel.sendInquiry();

                            // ignore: use_build_context_synchronously
                            context.go('/legal/inquiry/complete');
                          }
                        },
                        style: OutlinedButton.styleFrom(
                            elevation: 3,
                            primary: Colors.black,
                            shape: const StadiumBorder(),
                            side: const BorderSide(color: QTankColor.orange),
                            backgroundColor: QTankColor.white),
                        child: const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            '問い合わせ送信',
                            style: QTankTextStyle.miniTitleBlack,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          context.push('/legal/qa_page');
                        },
                        child: const Text(
                          'よくあるQAはこちら',
                          style: QTankTextStyle.linkText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
