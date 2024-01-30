import 'package:flutter/material.dart';

import '../../../../shared/styles/colors.dart';
import '../../../../shared/utils/images.dart';

class WelcomeWidget extends StatelessWidget {
  final String welcomeText;
  final Color textColor;
  final Color logoColor;
  final Color backGroundColor;
  const WelcomeWidget({
    super.key,
    required this.welcomeText,
    this.textColor = Colors.white,
    this.logoColor = ColorsAsset.mainColor,
    this.backGroundColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      color: backGroundColor,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (!(Theme.of(context).brightness == Brightness.dark))
                Image.asset(
                  ImagesAsset.pharmacyLogo,
                  scale: 10,
                ),
              if (Theme.of(context).brightness == Brightness.dark)
                Image.asset(
                  'assets/images/logoUpHome@3x.png',
                  width: 200,
                  height: 60,
                  fit: BoxFit.fitWidth,
                ),
              Text(
                "Intelligent Pharmacy",
                style: textTheme.titleLarge!.copyWith(color: logoColor),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  welcomeText,
                  style: textTheme.titleLarge!.copyWith(color: textColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
