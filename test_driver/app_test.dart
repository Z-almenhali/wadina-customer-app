// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('wadina App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

    // intro screen
    final loginTap = find.byValueKey("loginTap");

    //login screen
    final emailField = find.byValueKey('email');
    final passwordField = find.byValueKey('password');
    final loginButton = find.byValueKey('loginBtn');

    late FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      driver.close();
    });

    test("home page ", () async {
      await driver.tap(loginTap);

      await driver.tap(emailField);
      await driver.enterText("amh@gmail.com");

      await driver.tap(passwordField);
      await driver.enterText("AMAMAM");

      await driver.tap(loginButton);

      await driver.waitFor(find.text("KAU"));
    });
  });
}