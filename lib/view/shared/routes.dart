import 'package:flutter/material.dart';
import 'package:xendly_mobile/view/pages/confirm_transaction.dart';
import 'package:xendly_mobile/view/pages/create_pin.dart';
import 'package:xendly_mobile/view/pages/enter_pin.dart';
import 'package:xendly_mobile/view/pages/forgot_password.dart';
import 'package:xendly_mobile/view/pages/home.dart';
import 'package:xendly_mobile/view/pages/onboarding.dart';
import 'package:xendly_mobile/view/pages/sign_in.dart';
import 'package:xendly_mobile/view/pages/sign_up.dart';
import 'package:xendly_mobile/view/pages/transaction_success.dart';
import 'package:xendly_mobile/view/pages/transfer_funds.dart';
import 'package:xendly_mobile/view/pages/verify_email.dart';

// === onboarding & authentication === //
const String onboarding = "onboarding";
const String home = "home";
const String signUp = "signUp";
const String signIn = "signIn";
const String forgotPassword = "forgotPassword";

const String verifyEmail = "verifyEmail";
const String createPIN = "createPIN";
const String transferFunds = "transferFunds";
const String confirmTransaction = "confirmTransaction";
const String enterPIN = "enterPIN";
const String transactionSuccess = "transactionSuccess";

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case onboarding:
      return MaterialPageRoute(
        builder: (context) => const Onboarding(),
      );
    case home:
      return MaterialPageRoute(
        builder: (context) => const Home(),
      );
    case signUp:
      return MaterialPageRoute(
        builder: (context) => const SignUp(),
      );
    case signIn:
      return MaterialPageRoute(
        builder: (context) => const SignIn(),
      );
    case forgotPassword:
      return MaterialPageRoute(
        builder: (context) => const ForgotPassword(),
      );
    case verifyEmail:
      return MaterialPageRoute(
        builder: (context) => const VerifyEmail(),
      );
    case createPIN:
      return MaterialPageRoute(
        builder: (context) => const CreatePIN(),
      );
    case transferFunds:
      return MaterialPageRoute(
        builder: (context) => const TransferFunds(),
      );
    case confirmTransaction:
      return MaterialPageRoute(
        builder: (context) => const ConfirmTransaction(),
      );
    case enterPIN:
      return MaterialPageRoute(
        builder: (context) => const EnterPIN(),
      );
    case transactionSuccess:
      return MaterialPageRoute(
        builder: (context) => const TransactionSuccess(),
      );
    default:
      throw ('this route is unavailable');
  }
}
