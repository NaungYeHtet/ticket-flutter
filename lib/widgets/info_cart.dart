import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticketing_system/config/size_config.dart';
import 'package:ticketing_system/style/colors.dart';
import 'package:ticketing_system/style/style.dart';

class InfoCard extends StatelessWidget {
  final String? icon;
  final String? label;
  final String? amount;

  const InfoCard({super.key, this.icon, this.label, this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 200.0),
      padding: const EdgeInsets.only(
          top: 20.0, left: 20.0, bottom: 20.0, right: 40.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: AppColors.white,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SvgPicture.asset(
          icon!,
          width: 35.0,
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical! * 2,
        ),
        PrimaryText(
          text: label!,
          color: AppColors.secondary,
          size: 16.0,
        ),
        PrimaryText(
          text: amount!,
          fontWeight: FontWeight.w700,
          size: 18.0,
        )
      ]),
    );
  }
}
