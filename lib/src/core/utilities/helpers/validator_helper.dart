import 'package:get/get.dart';

String? validateEmail(String value) {
  if (GetUtils.isNullOrBlank(value)!) {
    return "Please enter an email address";
  } else if (!GetUtils.isEmail(value)) {
    return "Please enter a valid email address";
  } else {
    return null;
  }
}

String? validateDropdown(String value) {
  if (value.isEmpty) {
    return "A value must be selected";
  } else {
    return null;
  }
}

// validate possword inputs
String? validatePassword(String value) {
  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
  RegExp regExp = RegExp(pattern);
  if (GetUtils.isNullOrBlank(value)!) {
    return "Please enter a password";
  } else if (GetUtils.isLengthLessOrEqual(value, 7)) {
    return "Password must contain 8 characters";
  } else if (!regExp.hasMatch(value)) {
    return "Must include uppercase, lowercase and digit";
  } else {
    return null;
  }
}

String? validateFirstName(String value) {
  final regEx = RegExp(r'^[a-zA-Z-]+$');
  if (GetUtils.isNullOrBlank(value)!) {
    return "Enter your First Name";
  } else if (!regEx.hasMatch(value)) {
    return "Provide a valid First Name";
  } else {
    return null;
  }
}

String? validateUsername(String value) {
  // final regEx = RegExp(r'^[a-z][a-z0-9]*$');
  if (GetUtils.isNullOrBlank(value)!) {
    return "Enter your Username";
    // } else if (!regEx.hasMatch(value)) {
    //   return "Provide a valid Username";
  } else {
    return null;
  }
}

String? validateLastName(String value) {
  final regEx = RegExp(r'^[a-zA-Z-]+$');
  if (GetUtils.isNullOrBlank(value)!) {
    return "Enter your Last Name";
  } else if (!regEx.hasMatch(value)) {
    return "Provide a valid Last Name";
  } else {
    return null;
  }
}

String? validateToken(String value) {
  if (GetUtils.isNullOrBlank(value)!) {
    return "Enter your Verification Code";
  } else if (GetUtils.isLengthLessThan(value, 6)) {
    return "Code must contain 6 characters";
  } else if (GetUtils.isLengthGreaterThan(value, 6)) {
    return "Code must contain 6 characters";
  } else if (!GetUtils.isNumericOnly(value)) {
    return "Code must contain only digits";
  } else {
    return null;
  }
}

String? validatePin(String value) {
  if (GetUtils.isNullOrBlank(value)!) {
    return "Fill in your PIN code";
  } else if (!GetUtils.isNumericOnly(value)) {
    return "Provide a valid PIN code";
  } else if (GetUtils.isLengthLessThan(value, 4)) {
    return "Fill in all the fields!";
  }
}

String? validateCountry(dynamic value) {
  if (GetUtils.isNullOrBlank(value)!) {
    return "Select your Country of Residence";
  } else {
    return null;
  }
}

String? validatePhone(String value) {
  if (GetUtils.isNullOrBlank(value)!) {
    return "Enter your Phone Number";
  } else if (!GetUtils.isNum(value)) {
    return "Provide a valid Phone Number";
  } else {
    return null;
  }
}

String? validateDob(String value) {
  if (GetUtils.isNullOrBlank(value)!) {
    return "Enter your Date of Birth";
  } else {
    return null;
  }
}

// bank validation helpers
String? validateAcctNo(String value) {
  if (GetUtils.isNullOrBlank(value)!) {
    return "Provide an account number";
  } else if (!GetUtils.isNum(value)) {
    return "Provide a valid account number";
  } else if (GetUtils.isLengthGreaterThan(value, 10)) {
    return "Account number exceeds 10 digits";
  } else if (GetUtils.isLengthLessThan(value, 10)) {
    return "Account number is not up to 10 digits";
  } else {
    return null;
  }
}

String? validatePostalCode(String value) {
  if (GetUtils.isNullOrBlank(value)!) {
    return "Provide a postal code";
  } else if (GetUtils.isLengthLessThan(value, 6) ||
      GetUtils.isLengthGreaterThan(value, 6)) {
    return "Postal code must contain 6 digits";
  } else {
    return null;
  }
}

String? validateAddress(String value) {
  if (GetUtils.isNullOrBlank(value)!) {
    return "Provide an address";
  } else {
    return null;
  }
}

String? validateCity(String value) {
  if (GetUtils.isNullOrBlank(value)!) {
    return "Provide a city";
  } else {
    return null;
  }
}

String? validateBvn(String value) {
  if (GetUtils.isNullOrBlank(value)!) {
    return "Provide a bank verification number";
  } else if (GetUtils.isLengthLessThan(value, 10) ||
      GetUtils.isLengthGreaterThan(value, 10)) {
    return "BVN must contain 10 digits";
  } else {
    return null;
  }
}
