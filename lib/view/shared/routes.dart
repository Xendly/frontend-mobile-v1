import 'package:flutter/material.dart';
import 'package:xendly_mobile/model/wallet_model.dart';
import 'package:xendly_mobile/view/pages/add_money.dart';
import 'package:xendly_mobile/view/pages/check_pin.dart';
import 'package:xendly_mobile/view/pages/confirm_transaction.dart';
import 'package:xendly_mobile/view/pages/create_pin.dart';
import 'package:xendly_mobile/view/pages/edit_profile.dart';
import 'package:xendly_mobile/view/pages/enter_pin.dart';
import 'package:xendly_mobile/view/pages/files_documents.dart';
import 'package:xendly_mobile/view/pages/forgot_password.dart';
import 'package:xendly_mobile/view/pages/choose_fund_method.dart';
import 'package:xendly_mobile/view/pages/help.dart';
import 'package:xendly_mobile/view/pages/home.dart';
import 'package:xendly_mobile/view/pages/notifications.dart';
import 'package:xendly_mobile/view/pages/onboarding.dart';
import 'package:xendly_mobile/view/pages/personal_security.dart';
import 'package:xendly_mobile/view/pages/reset_password.dart';
import 'package:xendly_mobile/view/pages/send_money.dart';
import 'package:xendly_mobile/view/pages/sign_in.dart';
import 'package:xendly_mobile/view/pages/sign_up.dart';
import 'package:xendly_mobile/view/pages/splash.dart';
import 'package:xendly_mobile/view/pages/transaction_success.dart';
import 'package:xendly_mobile/view/pages/exchange_cash.dart';
import 'package:xendly_mobile/view/pages/verify_email.dart';
import 'package:xendly_mobile/view/pages/virtual_accounts.dart';
import 'package:xendly_mobile/view/pages/wallet_details.dart';
import 'package:xendly_mobile/view/pages/withdraw.dart';

// === onboarding & authentication === //
const String splash = "splash";
const String onboarding = "onboarding";
const String home = "home";
const String signUp = "signUp";
const String signIn = "signIn";
const String checkPin = "checkPin";
const String withdraw = "withdraw";
const String forgotPassword = "forgotPassword";
const String resetPassword = "resetPassword";
const String virtualAccounts = "virtualAccounts";
const String chooseFundMethod = "chooseFundMethod";
const String editProfile = "editProfile";
const String notifications = "notifications";
const String personalSecurity = "personalSecurity";
const String verifyEmail = "verifyEmail";
const String createPIN = "createPIN";
const String exchangeCash = "exchangeCash";
const String confirmTransaction = "confirmTransaction";
const String enterPIN = "enterPIN";
const String transactionSuccess = "transactionSuccess";
const String walletDetails = "walletDetails";
const String sendMoney = "sendMoney";
const String addMoney = "addMoney";
const String helpAndSupport = "helpAndSupport";
const String filesAndDocs = "filesAndDocs";

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case splash:
      return MaterialPageRoute(
        builder: (context) => Splash(),
      );
    case onboarding:
      return MaterialPageRoute(
        builder: (context) => const Onboarding(),
      );
    case home:
      return MaterialPageRoute(
        builder: (context) => const Home(),
      );
    case filesAndDocs:
      return MaterialPageRoute(
        builder: (context) => const FilesAndDocuments(),
      );
    case signUp:
      return MaterialPageRoute(
        builder: (context) => const SignUp(),
      );
    case signIn:
      return MaterialPageRoute(
        builder: (context) => const SignIn(),
      );
    case withdraw:
      return MaterialPageRoute(
        builder: (context) => const Withdraw(),
      );
    case editProfile:
      return MaterialPageRoute(
        builder: (context) => const EditProfile(),
      );
    case notifications:
      return MaterialPageRoute(
        builder: (context) => const Notifications(),
      );
    case forgotPassword:
      return MaterialPageRoute(
        builder: (context) => const ForgotPassword(),
      );
    case helpAndSupport:
      return MaterialPageRoute(
        builder: (context) => const HelpAndSupport(),
      );
    case resetPassword:
      return MaterialPageRoute(
        builder: (context) => const ResetPassword(),
      );

    // === SECURITY === //
    case personalSecurity:
      return MaterialPageRoute(
        builder: (context) => const PersonalSecurity(),
      );
    case sendMoney:
      return MaterialPageRoute(
        builder: (context) => const SendMoney(),
      );

    case verifyEmail:
      return MaterialPageRoute(
        builder: (context) => const VerifyEmail(),
      );
    case createPIN:
      return MaterialPageRoute(
        builder: (context) => const CreatePIN(),
      );
    case exchangeCash:
      return MaterialPageRoute(
        builder: (context) => const ExchangeCash(),
      );
    case chooseFundMethod:
      return MaterialPageRoute(
        builder: (context) => const ChooseFundMethod(),
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
    case walletDetails:
      return MaterialPageRoute(
        builder: (context) => const WalletDetails(),
      );
    case virtualAccounts:
      return MaterialPageRoute(
        builder: (context) => const VirtualAccounts(),
      );

    // === MONEY MANAGEMENT == //

    case addMoney:
      return MaterialPageRoute(
        builder: (context) => const AddMoney(),
      );
    default:
      throw ('this route is unavailable');
  }
}
