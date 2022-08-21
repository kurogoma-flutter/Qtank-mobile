import 'package:flutter/material.dart';
import 'package:qtank_mobile/presentation/pages/legal/string/about_this_app.dart';
import 'package:qtank_mobile/presentation/style/style.dart';

import '../../style/color.dart';

class AboutThisAppPage extends StatelessWidget {
  const AboutThisAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QTankColor.black,
      appBar: AppBar(
        title: const Text('このアプリについて'),
        backgroundColor: QTankColor.grey,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 40),
        child: SizedBox.expand(
          child: Column(
            children: const [
              _AppInfoLabel(title: 'アプリバージョン', content: appVersion),
              _AppInfoLabel(title: '製作者', content: maker),
              _AppInfoLabel(title: '問合せ先', content: inquiryEmail),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppInfoLabel extends StatelessWidget {
  const _AppInfoLabel({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(
            title,
            style: QTankTextStyle.miniTitle,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(':', style: QTankTextStyle.miniTitle),
          ),
          Text(
            content,
            style: QTankTextStyle.subtitle,
          ),
        ],
      ),
    );
  }
}
