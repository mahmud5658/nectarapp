class InputValidator {
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  static bool isValidEmail(String email) {
    return _emailRegex.hasMatch(email);
  }
  static final RegExp _passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~])[A-Za-z\d!@#\$&*~]{8,}$',);

  static bool isValidPassword(String password){
    return _passwordRegex.hasMatch(password);
  }

  static final RegExp _nameRegex = RegExp(
    r'^[a-zA-Z\s]{2,}$',
  );
  static bool isValidName(String name) {
    return _nameRegex.hasMatch(name);
  }
}
