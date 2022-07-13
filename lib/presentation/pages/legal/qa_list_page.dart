import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qtank_mobile/presentation/style/color.dart';

class QAPage extends StatelessWidget {
  const QAPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QTankColor.white,
      appBar: AppBar(
        title: const Text('Q&Aページ'),
        backgroundColor: QTankColor.grey,
      ),
      body: const Center(
        child: Text(
          '現在準備中です。',
          style: TextStyle(
            fontSize: 20,
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
