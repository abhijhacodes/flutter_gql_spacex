import 'package:flutter/material.dart';
import 'package:flutter_gql_spacex/helpers/types.dart';

class CustomText extends StatelessWidget {
  final TextTypes? textType;
  final String content;
  final bool? truncate;

  const CustomText(
      {super.key,
      this.textType = TextTypes.small,
      required this.content,
      this.truncate = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
          fontWeight:
              textType == TextTypes.small ? FontWeight.normal : FontWeight.bold,
          fontSize: textType == TextTypes.small ? 14 : 16),
      overflow: truncate == true ? TextOverflow.ellipsis : TextOverflow.clip,
    );
  }
}
