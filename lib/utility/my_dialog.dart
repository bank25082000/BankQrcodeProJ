// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bankqrcodeproj/utility/my_constant.dart';
import 'package:bankqrcodeproj/widgets/show_image.dart';
import 'package:bankqrcodeproj/widgets/show_text.dart';
import 'package:bankqrcodeproj/widgets/show_text_button.dart';
import 'package:flutter/material.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });
  Future<void> normalDialog({
    required String title,
    required String subTitle,
    Widget? contextWidget,
  }) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: const SizedBox(
            width: 80,
            child: ShowImage(),
          ),
          title: ShowText(
            text: title,
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowText(text: subTitle),
        ),
        actions: [
          ShowTextButton(
            label: 'OK',
            pressFunc: () {
              Navigator.pop(context);
            },
          )
        ],
        content: contextWidget ?? const SizedBox(),
      ),
    );
  }
}
