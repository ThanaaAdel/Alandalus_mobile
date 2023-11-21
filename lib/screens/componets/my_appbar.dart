import 'package:flutter/material.dart';

import '../../../../utils/res.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String? title;
  final Color titleColor;
  final bool haveLeading;
  final bool haveAction;
  final Function? onLeadingTap;
  final Function? onActionTap;
  final Widget? icon;
  final Widget? leadingIcon;
  final Widget? child;
  final Widget? flexibleSpace;
  final Color backgroundColor;

  const MyAppBar({
    Key? key,
    this.title,
    this.titleColor = Colors.black,
    this.haveLeading = false,
    this.haveAction = false,
    this.onLeadingTap,
    this.onActionTap,
    this.icon,
    this.child,
    this.backgroundColor = AppColors.bgColor, this.leadingIcon, this.flexibleSpace,
  }) : super(key: key);

  String capitalize(String string) {
    if (string.isEmpty) {
      return string;
    }
    return string[0].toUpperCase() + string.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        title ?? '',
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold, color: titleColor),
      ),
      flexibleSpace: flexibleSpace ,
      backgroundColor: backgroundColor,
      centerTitle: true,
      leading: haveLeading
          ? GestureDetector(
              onTap: () {
                onLeadingTap == null ? Navigator.pop(context) : onLeadingTap!();
              },
              child: (leadingIcon ==null)?Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.6),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            width: 1.2,
                            color: AppColors.light_grey)
                        ),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.secondary_text_color,
                    ),
                  ),
                ],
              ):leadingIcon,
            )
          : Container(),
      actions: <Widget>[
        haveAction
            ? GestureDetector(
                onTap: () => onActionTap!(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      icon!,
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
        Container(child: child,)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
