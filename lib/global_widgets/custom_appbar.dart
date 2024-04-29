import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_app/core/values/colors.dart';
import 'package:shoes_app/global_widgets/svg_icon.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String? leadingIcon;
  void Function()? onTapLeading;
  String title;
  String? trailingIcon;
  VoidCallback? onTapTrailing;
  Color? trailingColor;
  bool automaticallyImplyLeading;
  CustomAppBar({
    super.key,
    this.leadingIcon,
    this.onTapLeading,
    required this.title,
    this.trailingIcon,
    this.onTapTrailing,
    this.trailingColor,
    this.automaticallyImplyLeading = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading:
          automaticallyImplyLeading && leadingIcon == null ? true : false,
      leading: leadingIcon == null
          ? null
          : GestureDetector(
              onTap: onTapLeading,
              child: SvgIcon(
                imagePath: leadingIcon!,
                fit: BoxFit.scaleDown,
              )),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          color: AppColors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          // height: 0.04,
        ),
      ),
      actions: [
        trailingIcon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SvgIcon(
                  imagePath: trailingIcon!,
                  color: trailingColor,
                  height: 15.0,
                  width: 15.0,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
