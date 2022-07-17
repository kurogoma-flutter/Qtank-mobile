import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qtank_mobile/constants/enum.dart';
import 'package:qtank_mobile/presentation/style/color.dart';
import 'package:qtank_mobile/presentation/style/style.dart';

import '../../../data/view_model/setting_page_view_model.dart';

class SettingAppAndLegalPage extends ConsumerWidget {
  const SettingAppAndLegalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(settingPageViewModelProvider);
    return Scaffold(
      backgroundColor: QTankColor.white,
      appBar: AppBar(
        title: const Text('アプリ設定と利用規約'),
        backgroundColor: QTankColor.grey,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text('アプリ設定', style: QTankTextStyle.miniTitleBlack),
              ),
              SwitchListTile(
                value: viewModel.ableToNoticeAboutNewMessage,
                onChanged: (value) {
                  viewModel.updateAbleToSendMessage(value);
                },
                title: const Text(
                  "新規メッセージの通知",
                  style: QTankTextStyle.subtitleBlack,
                ),
              ),
              SwitchListTile(
                value: viewModel.ableToNoticeAboutNewMember,
                onChanged: (value) {
                  viewModel.updateAbleToSendMember(value);
                },
                title: const Text(
                  "新規メンバー追加の通知",
                  style: QTankTextStyle.subtitleBlack,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('テーマ設定', style: QTankTextStyle.subtitleBlack),
                    DropdownButton(
                      dropdownColor: QTankColor.white,
                      items: const [
                        DropdownMenuItem(
                          value: AppThemeMode.light,
                          child: Text('ライトモード'),
                        ),
                        DropdownMenuItem(
                          value: AppThemeMode.dark,
                          child: Text('ダークモード'),
                        ),
                        DropdownMenuItem(
                          value: AppThemeMode.system,
                          child: Text('端末設定に従う'),
                        ),
                      ],
                      onChanged: (value) {
                        viewModel.updateThemeMode(value);
                      },
                      value: viewModel.themeMode,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text('各種規約', style: QTankTextStyle.miniTitleBlack),
              ),
              const _LegalSectionWithNavigateIcon(
                  title: 'アプリについて', route: '/legal/about_app'),
              const _LegalSectionWithNavigateIcon(
                  title: '利用規約', route: '/legal/app_term'),
              const _LegalSectionWithNavigateIcon(
                  title: 'プライバシーポリシー', route: '/legal/privacy_policy'),
              const _LegalSectionWithNavigateIcon(
                  title: '特定商取引法について', route: '/legal/specific_trade_law'),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _LegalSectionWithNavigateIcon extends StatelessWidget {
  const _LegalSectionWithNavigateIcon({
    Key? key,
    required this.title,
    required this.route,
  }) : super(key: key);
  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: QTankTextStyle.subtitleBlack),
            const Icon(Icons.arrow_forward_rounded),
          ],
        ),
        onTap: () {
          context.push(route);
        },
      ),
    );
  }
}