import 'package:flutter/material.dart';
import 'package:qtank_mobile/presentation/style/color.dart';
import 'package:qtank_mobile/presentation/style/style.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({Key? key, required this.dialogMessage})
      : super(key: key);
  final String dialogMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('確認', textAlign: TextAlign.center),
      content: Text(dialogMessage, textAlign: TextAlign.center),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: QTankColor.greyWhite,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text('いいえ', style: QTankTextStyle.miniTitle),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: QTankColor.lightBlue,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text('はい', style: QTankTextStyle.miniTitle),
                  ),
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
