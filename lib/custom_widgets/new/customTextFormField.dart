import 'package:alandalos/core/extensions/num_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/res/text_styles.dart';
import '../../../../core/resources/app_colors.dart';
import '../../core/svg_icon.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class CustomTextFormFiled extends StatefulWidget {
  final Widget? widget;
  final String? image;
  final Color? imageColor;
  final String? icon;
  final String? hintText;
  final double? height;
  final Color? backGroundColor;
  final Color? borderColor;
  final double? borderWidth;


  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;

  const CustomTextFormFiled({
    Key? key,
    this.widget,
    this.image,
    this.imageColor,
    this.hintText,
    this.controller,
    this.textInputAction,
    this.textInputType,
    this.height,
    this.backGroundColor,
    this.borderColor,
    this.borderWidth,
    this.icon,

  }) : super(key: key);

  @override
  State<CustomTextFormFiled> createState() => _CustomTextFormFiledState();
}

class _CustomTextFormFiledState extends State<CustomTextFormFiled> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //top: 22,bottom: 22,
      padding: EdgeInsets.only(
        right: 16,
      ),
      width: double.infinity,
      height: widget.height ?? 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: widget.borderWidth ?? 0.9,
          color: widget.borderColor ?? Colors.transparent,
        ),
        boxShadow: const [
          BoxShadow(color: AppColors.bgColor, spreadRadius: 0),
        ],
        color: widget.backGroundColor ?? AppColors.colorPrimary,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: widget.widget == null ? false : true,
                  autofocus: false,
                  decoration: InputDecoration(
                    icon: widget.icon == null
                        ? SizedBox()
                        : SVGIcon(
                            widget.icon ?? '',
                            //'assets/images/svg$image.svg',
                            width: (24.w),
                            height: (16.h),
                          ),
                    suffixIcon: widget.image == null
                        ? SizedBox()
                        : SVGIcon(
                            widget.image ?? '',
                            //'assets/images/svg$image.svg',
                            width: (20.w),
                            height: (20.h),
                            color: widget.imageColor,
                          ),
                    border: InputBorder.none,
                    hintText: widget.hintText?.tr(),
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  controller: widget.controller,
                  textInputAction: widget.textInputAction,
                  keyboardType: widget.textInputType ?? TextInputType.text,
                  // cursorColor: AppColors.main,
                  style: const TextStyle(
                      letterSpacing: 0.5, fontSize: 18, ),
                  validator: (value) {
                     return null;
                  },
                  onSaved: (newValue) {},
                ),
              ),
            ],
          ),
          Container(
            child: widget.widget,
          ),
        ],
      ),
    );
  }
}
