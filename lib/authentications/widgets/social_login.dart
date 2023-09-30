import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';

class SocialLogin extends StatelessWidget {
  final String text;
  final SvgPicture icon;

  const SocialLogin({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
          padding: const EdgeInsets.all(Sizes.size10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.size6),
              border: Border.all(
                color: Colors.grey.shade300,
                width: Sizes.size1,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(alignment: Alignment.centerLeft, child: icon),
              Gaps.h10,
              Text(
                text,
                style: const TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }
}
