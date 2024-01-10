import 'package:flutter/material.dart';

import 'fonts_manager.dart';

// ignore: slash_for_doc_comments
/**
 * Get Styles:
 *
 *  ***** ***** Tajawal Font Family We used  ***** *****
 *
 * 1. Black Style w900
 * 2. Extra Bold w700
 * 3. Bold w600
 * 4. Medium w500
 * 5. Regular w400
 * 6. light w300
 * 7. Extra Light w200
 *
 */

TextStyle _getTextStyle(
  double fontSize,
  FontWeight fontWeight,
  Color color,
) {
  return TextStyle(
    fontFamily: FontConstants.tajawalFontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}

// Black style
TextStyle getBlackStyle({
  double? fontSize,
  required Color color,
}) {
  return _getTextStyle(
    fontSize ?? FontSize.s12,
    FontWeightManager.black,
    color,
  );
}

// extra bold style
TextStyle getExtraBoldStyle({
  double? fontSize,
  required Color color,
}) {
  return _getTextStyle(
    fontSize ?? FontSize.s12,
    FontWeightManager.extraBold,
    color,
  );
}

// bold style
TextStyle getBoldStyle({
  double? fontSize,
  required Color color,
}) {
  return _getTextStyle(
    fontSize ?? FontSize.s12,
    FontWeightManager.bold,
    color,
  );
}

// medium style
TextStyle getMediumStyle({
  double? fontSize,
  required Color color,
}) {
  return _getTextStyle(
    fontSize ?? FontSize.s12,
    FontWeightManager.medium,
    color,
  );
}

// regular style
TextStyle getRegularStyle({
  double? fontSize,
  required Color color,
}) {
  return _getTextStyle(
    fontSize ?? FontSize.s12,
    FontWeightManager.regular,
    color,
  );
}

// light style
TextStyle getLightStyle({
  double? fontSize,
  required Color color,
}) {
  return _getTextStyle(
    fontSize ?? FontSize.s12,
    FontWeightManager.light,
    color,
  );
}

// extra light style
TextStyle getExtraLightStyle({
  double? fontSize,
  required Color color,
}) {
  return _getTextStyle(
    fontSize ?? FontSize.s12,
    FontWeightManager.extraLight,
    color,
  );
}
