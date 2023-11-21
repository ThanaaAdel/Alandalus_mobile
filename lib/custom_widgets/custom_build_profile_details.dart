import 'package:flutter/material.dart';

import '../utils/res.dart';

Widget buildProfileDetails({String? title, String? description}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          maxLines: 1,
        ),
        const SizedBox(
          height: 12,
        ),
        Text("$description",
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: AppColors.secondary_text_color)),
        const SizedBox(
          height: 16,
        ),
        const Divider(
          height: 1,
          color: AppColors.light_grey,
        )
      ],
    ),
  );
}
