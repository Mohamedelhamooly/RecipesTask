import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const kPrimaryColor = Color(0xffA12032);
const kSubSubTitleColor = Color(0xff6C6C6C);
const kTitleColor = Color(0xff1A1A1A);
const kSecondaryColor = Color(0xffDF97A1);
const kSubTitleColor = Color(0xff595959);
const kDarkWhite = Color(0xffF3F3F3);
const backgroundColor = Color(0xffF6F3F4);
const kWhite = Color(0xFFFFFFFF);
const kBorderColorTextField = Color(0xffE8E8E8);
const ratingBarColor = Color(0xFFFFB33E);
const kIconColor = Color(0xFF959595);

final kTextStyle = GoogleFonts.almarai(
  color: kTitleColor,
);


String addressOnMap = '';
String latitude = '';
String longitude = '';

InputDecoration kInputDecoration = const InputDecoration(
  hintStyle: TextStyle(color: kSubSubTitleColor),
  contentPadding: EdgeInsets.only(left: 7, right: 7.0),
  prefixIconColor: kSubSubTitleColor,
  labelStyle: TextStyle(color: kTitleColor),
  filled: true,
  fillColor: Colors.white70,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(6.0),
    ),
    borderSide: BorderSide(color: kBorderColorTextField, width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(6.0),
    ),
    borderSide: BorderSide(color: kBorderColorTextField, width: 1),
  ),
);

InputDecoration mInputDecoration = const InputDecoration(
  hintStyle: TextStyle(color: Color(0xff949494)),
  prefixIconColor: kSubSubTitleColor,
  labelStyle: TextStyle(color: kTitleColor),
  filled: true,
  fillColor: kWhite,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(35.0),
    ),
    borderSide: BorderSide(color: kBorderColorTextField, width: 1),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(35.0),
    ),
    borderSide: BorderSide(color: kBorderColorTextField, width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(35.0),
    ),
    borderSide: BorderSide(color: kBorderColorTextField, width: 1),
  ),
);

bool newSelect = false;
bool isArabic = true;
// height and width

bool isAddress = false;
bool isGuest = false;

