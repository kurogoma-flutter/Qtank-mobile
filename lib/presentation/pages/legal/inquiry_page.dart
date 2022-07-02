import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../style/color.dart';
import '../../style/style.dart';
import '../common_components/dialog.dart';

class InquiryPage extends StatelessWidget {
  const InquiryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QTankColor.white,
      appBar: AppBar(
        title: const Text('お問合せ'),
        backgroundColor: QTankColor.grey,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
                    value: 0,
                    child: Text('選択してください'),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Text('アプリについての質問'),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text('違法ユーザーについて'),
                  ),
                  DropdownMenuItem(
                    value: 3,
                    child: Text('機能のバグについて'),
                  ),
                  DropdownMenuItem(
                    value: 4,
                    child: Text('アプリの改善要望について'),
                  ),
                  DropdownMenuItem(
                    value: 5,
                    child: Text('その他'),
                  ),
                ],
                onChanged: (value) {
                  print(value);
                },
                value: 0,
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
                  print(value);
                },
              ),
              const SizedBox(height: 80),
              Align(
                alignment: Alignment.center,
                child: OutlinedButton(
                  onPressed: () async {
                    var dialogResult = await showDialog<bool>(
                      context: context,
                      builder: (_) {
                        return const ConfirmationDialog(
                          dialogMessage: ' 入力したお問合せ内容を送信してもよろしいですか？',
                        );
                      },
                    );
                    if (dialogResult == true) {
                      print('問い合わせ処理');
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
                    child:
                        Text('問い合わせ送信', style: QTankTextStyle.miniTitleBlack),
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
