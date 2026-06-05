import 'package:aichat_web/core/const/app_sizes.dart';
import 'package:aichat_web/core/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MyTextfeild extends StatelessWidget {
  const MyTextfeild({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * .2,
      child: TextField(
        controller: controller,
        cursorColor: context.color.primary,
        style: context.text.bodyMedium?.copyWith(
          fontFamily: 'poppins',
          color: context.color.primary,
        ),
        decoration: InputDecoration(
          labelText: 'Search',
          prefixIcon: Icon(Iconsax.search_normal, color: context.color.primary),
          hintText: "What's in your mind",
          hintStyle: context.text.bodyMedium?.copyWith(
            fontFamily: 'poppins',
            color: context.color.primary,
          ),
          labelStyle: context.text.bodyMedium?.copyWith(
            fontFamily: 'poppins',
            color: context.color.primary,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: context.color.tertiary),
            borderRadius: .circular(AppSizes.kspace32),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: context.color.primary),
            borderRadius: .circular(AppSizes.kspace32),
          ),
        ),
      ),
    );
  }
}
