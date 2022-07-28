// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bankqrcodeproj/utility/my_constant.dart';
import 'package:flutter/material.dart';

class ShowText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  const ShowText({
    Key? key,
    required this.text,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle ?? MyConstant().h3Style(),
    );
  }
}
