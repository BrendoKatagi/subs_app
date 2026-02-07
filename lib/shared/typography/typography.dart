import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _defaultColor = Colors.black;

class XTypography {
  static Text baseText(
    String text, {
    required Color color,
    required double fontHeight,
    required double fontSize,
    required FontWeight fontWeight,
    required FontStyle fontStyle,
    Key? key,
    TextAlign? textAlign,
    String? semanticsLabel,
    TextOverflow? overflow,
    int? maxLines,
  }) =>
      Text(
        text,
        key: key,
        textAlign: textAlign,
        style: GoogleFonts.montserrat(textStyle: TextStyle(color: color, height: fontHeight), fontSize: fontSize, fontWeight: fontWeight, fontStyle: fontStyle),
        semanticsLabel: semanticsLabel ?? text,
        overflow: overflow,
        maxLines: maxLines,
      );

  static Text headingRegular(
    String text, {
    Key? key,
    TextAlign? textAlign,
    Color color = _defaultColor,
    double fontHeight = 1.5,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
    FontStyle fontStyle = FontStyle.normal,
    String? semanticsLabel,
    TextOverflow? overflow,
    int? maxLines,
  }) =>
      baseText(
        text,
        textAlign: textAlign,
        color: color,
        fontHeight: fontHeight,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        maxLines: maxLines,
        overflow: overflow,
      );

  static Text headingRegularBold(
    String text, {
    Key? key,
    TextAlign? textAlign,
    Color color = _defaultColor,
    double fontHeight = 1.5,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.w700,
    FontStyle fontStyle = FontStyle.normal,
    String? semanticsLabel,
    TextOverflow? overflow,
    int? maxLines,
  }) =>
      baseText(
        text,
        textAlign: textAlign,
        color: color,
        fontHeight: fontHeight,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        maxLines: maxLines,
        overflow: overflow,
      );

  static Text headingSmall(
    String text, {
    Key? key,
    TextAlign? textAlign,
    Color color = _defaultColor,
    double fontHeight = 1.5,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w400,
    FontStyle fontStyle = FontStyle.normal,
    String? semanticsLabel,
    TextOverflow? overflow,
    int? maxLines,
  }) =>
      baseText(
        text,
        textAlign: textAlign,
        color: color,
        fontHeight: fontHeight,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        maxLines: maxLines,
        overflow: overflow,
      );

  static Text headingSmallRegular(
    String text, {
    Key? key,
    TextAlign? textAlign,
    Color color = _defaultColor,
    double fontHeight = 1.7,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    FontStyle fontStyle = FontStyle.normal,
    String? semanticsLabel,
    TextOverflow? overflow,
    int? maxLines,
  }) =>
      baseText(
        text,
        textAlign: textAlign,
        color: color,
        fontHeight: fontHeight,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        maxLines: maxLines,
        overflow: overflow,
      );

  static Text headingSmallRegularBold(
    String text, {
    Key? key,
    TextAlign? textAlign,
    Color color = _defaultColor,
    double fontHeight = 1.2,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w700,
    FontStyle fontStyle = FontStyle.normal,
    String? semanticsLabel,
    TextOverflow? overflow,
    int? maxLines,
  }) =>
      baseText(
        text,
        textAlign: textAlign,
        color: color,
        fontHeight: fontHeight,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        maxLines: maxLines,
        overflow: overflow,
      );

  static Text paragraphRegularBold(
    String text, {
    Key? key,
    TextAlign? textAlign,
    Color color = _defaultColor,
    double fontHeight = 1.3,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w600,
    FontStyle fontStyle = FontStyle.normal,
    String? semanticsLabel,
    TextOverflow? overflow,
    int? maxLines,
  }) =>
      baseText(
        text,
        textAlign: textAlign,
        color: color,
        fontHeight: fontHeight,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        maxLines: maxLines,
        overflow: overflow,
      );

  static Text paragraphRegularMedium(
    String text, {
    Key? key,
    TextAlign? textAlign,
    Color color = _defaultColor,
    double fontHeight = 1.3,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    FontStyle fontStyle = FontStyle.normal,
    String? semanticsLabel,
    TextOverflow? overflow,
    int? maxLines,
  }) =>
      baseText(
        text,
        textAlign: textAlign,
        color: color,
        fontHeight: fontHeight,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        maxLines: maxLines,
        overflow: overflow,
      );

  static Text paragraphRegular(
    String text, {
    Key? key,
    TextAlign? textAlign,
    Color color = _defaultColor,
    double fontHeight = 1.3,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w400,
    FontStyle fontStyle = FontStyle.normal,
    String? semanticsLabel,
    TextOverflow? overflow,
    int? maxLines,
  }) =>
      baseText(
        text,
        textAlign: textAlign,
        color: color,
        fontHeight: fontHeight,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        maxLines: maxLines,
        overflow: overflow,
      );
}
