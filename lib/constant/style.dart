import 'package:flutter/material.dart';
import 'package:flutter_ai/constant/size.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

InputDecoration inputDecoration = InputDecoration(
  focusedBorder:
      const OutlineInputBorder(borderSide: BorderSide(color: AppColors.white)),
  hintStyle: GoogleFonts.siemreap(
    fontSize: FontSize.fontSizeMedium,
    color: AppColors.subText,
  ),
  labelStyle: GoogleFonts.siemreap(
    fontSize: FontSize.fontSizeRegular,
    color: AppColors.primaryText,
  ),
  border:
      const OutlineInputBorder(borderSide: BorderSide(color: AppColors.white)),
);

TextStyle appTextStyle = const TextStyle(color: AppColors.white);
