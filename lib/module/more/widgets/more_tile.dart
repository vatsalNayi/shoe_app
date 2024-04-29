import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/values/colors.dart';
import '../../../global_widgets/svg_icon.dart';

class MoreTile extends StatelessWidget {
  String title;
  String leadingIcon;
  Color? iconColor;
  VoidCallback onPress;
  MoreTile({
    super.key,
    required this.title,
    required this.leadingIcon,
    this.iconColor,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24.w),
          color: AppColors.bgGrey,
          child: ListTile(
            onTap: onPress,
            leading: leadingIcon.contains('.svg')
                ? SvgIcon(
                    imagePath: leadingIcon,
                    color: iconColor,
                  )
                : Image.asset(
                    leadingIcon,
                    width: 20,
                    height: 20,
                  ),
            title: Text(
              title,
              style: GoogleFonts.montserrat(
                color: AppColors.brightGrey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}
