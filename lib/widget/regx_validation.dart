// ignore_for_file: unnecessary_null_comparison, file_names

import '../utils/text_title.dart';

/// Email RefExp Validation.
String? validateEmail(String value) {
  var regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (value.isEmpty) {
    return fieldIsRequired;
  } else if (value.contains(' ')) {
    return spaceNotAllow;
  } else if (!regex.hasMatch(value)) {
    return 'Enter a valid Email Address';
  } else {
    return null;
  }
}

/// Name String RefExp Validation.
String? validateNameString(String value) {
  // final nameRegExp =
  //     RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
  if (value.isEmpty) {
    return fieldIsRequired;
  } else if (value.startsWith(" ") || value.endsWith(" ")) {
    return spaceNotAllow;
  }
  // else if (!nameRegExp.hasMatch(value)) {
  //   return 'Enter a valid field';
  // }
  else {
    return null;
  }
}
