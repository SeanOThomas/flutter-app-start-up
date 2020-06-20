class Validator {

  static const DIGITS_ONLY_REGEX = r'^[0-9]*$';

  static bool isEmail(String input) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(input);
  }

  static bool isPassword(String input) {
    return input.length >= 8;
  }

  static bool isUsername(String input) {
    if (input.length < 8 || input.length > 20) {
      return false;
    }
    return RegExp(r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$').hasMatch(input);
  }

  static bool isNotEmpty(String input) {
    return input.isNotEmpty;
  }
}
