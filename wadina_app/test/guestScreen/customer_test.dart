import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:wadina_app/guestScreen/login.dart';

void main() async {
  // Used to get rid of the 400 error (because of NetworkImage)
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = null;
  });

  // login
  test("login form ...", () {
    var emailResult = EmailValidator.validate("");
    var passwordResult = PasswordValidator.validate("");

    expect(emailResult, "Please Enter Your Email");
    expect(passwordResult, "please Enter Your Password");
  });
}
