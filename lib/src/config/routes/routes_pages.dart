import 'package:get/get.dart';
import 'package:xendly_mobile/src/features/swap/presentation/confirm_swap.dart';
import 'package:xendly_mobile/src/features/transfer/presentation/transfer_details.dart';
import 'package:xendly_mobile/src/features/withdrawal/presentation/review_withdrawal.dart';
import 'package:xendly_mobile/src/features/withdrawal/presentation/withdrawal.dart';
import 'package:xendly_mobile/src/presentation/bindings/auth_bindings.dart';
import 'package:xendly_mobile/src/presentation/bindings/beneficiaries_binding.dart';
import 'package:xendly_mobile/src/presentation/bindings/misc_bindings.dart';
import 'package:xendly_mobile/src/presentation/bindings/transaction_bindings.dart';
import 'package:xendly_mobile/src/presentation/bindings/user_bindings.dart';
import 'package:xendly_mobile/src/presentation/bindings/wallet_bindings.dart';
import 'package:xendly_mobile/src/presentation/views/account_limits.dart';
import 'package:xendly_mobile/src/presentation/views/add_cash.dart';
import 'package:xendly_mobile/src/presentation/views/address_update.dart';
import 'package:xendly_mobile/src/presentation/views/auth/login_otp.dart';
import 'package:xendly_mobile/src/presentation/views/auth/sign_in.dart';
import 'package:xendly_mobile/src/presentation/views/auth/sign_up.dart';
import 'package:xendly_mobile/src/presentation/views/confirm_transaction.dart';
import 'package:xendly_mobile/src/presentation/views/create_payout_account.dart';
import 'package:xendly_mobile/src/presentation/views/create_pin.dart';
import 'package:xendly_mobile/src/presentation/views/currency_transactions.dart';
import 'package:xendly_mobile/src/presentation/views/edit_profile.dart';
import 'package:xendly_mobile/src/presentation/views/enter_pin.dart';
import 'package:xendly_mobile/src/presentation/views/exchange_cash.dart';
import 'package:xendly_mobile/src/presentation/views/files_documents.dart';
import 'package:xendly_mobile/src/presentation/views/forgot_password.dart';
import 'package:xendly_mobile/src/presentation/views/fund_methods.dart';
import 'package:xendly_mobile/src/presentation/views/help.dart';
import 'package:xendly_mobile/src/presentation/views/home.dart';
import 'package:xendly_mobile/src/presentation/views/manage_account_limits.dart';
import 'package:xendly_mobile/src/presentation/views/notifications.dart';
import 'package:xendly_mobile/src/presentation/views/onboarding.dart';
import 'package:xendly_mobile/src/presentation/views/payout_accounts.dart';
import 'package:xendly_mobile/src/presentation/views/personal_security.dart';
import 'package:xendly_mobile/src/presentation/views/reset_password.dart';
import 'package:xendly_mobile/src/presentation/views/settings/bvn_verification.dart';
import 'package:xendly_mobile/src/presentation/views/settings/change_password.dart';
import 'package:xendly_mobile/src/presentation/views/settings/change_pin.dart';
import 'package:xendly_mobile/src/presentation/views/settings/help_center.dart';
import 'package:xendly_mobile/src/presentation/views/settings/manage_beneficiaries.dart';
import 'package:xendly_mobile/src/presentation/views/splash.dart';
import 'package:xendly_mobile/src/presentation/views/transaction_receipt.dart';
import 'package:xendly_mobile/src/presentation/views/transaction_success.dart';
import 'package:xendly_mobile/src/presentation/views/transactions.dart';
import 'package:xendly_mobile/src/presentation/views/verify_email.dart';
import 'package:xendly_mobile/src/presentation/views/virtual_accounts.dart';
import 'package:xendly_mobile/src/presentation/views/wallet_details.dart';
import 'package:xendly_mobile/src/presentation/views/withdraw.dart';

import '../../features/transfer/presentation/confirm_transfer.dart';
import '../routes.dart';

List<GetPage<dynamic>> getPages = [
  // authentication
  GetPage(
    name: Routes.signIn,
    page: () => const SignIn(),
  ),

  // other routes
  GetPage(
    name: splash,
    page: () => Splash(),
  ),
  GetPage(
    name: onboarding,
    page: () => const Onboarding(),
  ),
  GetPage(
    name: home,
    page: () => const Home(),
    bindings: [
      AuthBindings(),
      WalletBindings(),
      TransactionBindings(),
      UserBindings(),
      BeneficiariesBinding(),
      MiscBinding(),
    ],
  ),
  GetPage(
    name: filesAndDocs,
    page: () => const FilesAndDocuments(),
  ),

  // settings
  GetPage(
    name: manageAccountLimits,
    page: () => const ManageAccountLimits(),
  ),
  GetPage(
    name: bvnVerification,
    page: () => const BvnVerification(),
    binding: UserBindings(),
  ),
  GetPage(
    name: manageBeneficiaries,
    page: () => const ManageBeneficiaries(),
    binding: BeneficiariesBinding(),
  ),
  GetPage(
    name: payoutAccounts,
    page: () => const PayoutAccounts(),
  ),
  GetPage(
    name: changePassword,
    page: () => const ChangePassword(),
  ),
  GetPage(
    name: changePin,
    page: () => const ChangePin(),
    binding: UserBindings(),
  ),
  GetPage(
    name: helpCenter,
    page: () => const HelpCenter(),
  ),
  GetPage(
    name: updateAddress,
    page: () => const UpdateAddress(),
    binding: UserBindings(),
  ),

  // >>> Authenticator <<< //
  GetPage(
    name: signUp,
    page: () => const SignUp(),
    binding: AuthBindings(),
  ),
  GetPage(
    name: signIn,
    page: () => const SignIn(),
    binding: AuthBindings(),
  ),
  GetPage(
    name: loginOtp,
    page: () => const LoginOtp(),
    binding: AuthBindings(),
  ),
  GetPage(
    name: withdraw,
    page: () => const Withdraw(),
  ),
  GetPage(
    name: withdrawal,
    page: () => const Withdrawal(),
    bindings: [
      MiscBinding(),
      WalletBindings(),
    ],
  ),
  GetPage(
    name: confirmWithdrawal,
    page: () => const ConfirmWithdrawal(),
    bindings: [
      MiscBinding(),
      WalletBindings(),
    ],
  ),
  GetPage(
    name: transactions,
    page: () => const Transactions(),
    bindings: [
      TransactionBindings(),
    ],
  ),
  GetPage(
    name: currencyTransactions,
    page: () => const CurrencyTransactions(),
    bindings: [
      TransactionBindings(),
    ],
  ),
  GetPage(
    name: editProfile,
    page: () => const EditProfile(),
    binding: UserBindings(),
  ),
  GetPage(
    name: notifications,
    page: () => const Notifications(),
  ),
  GetPage(
    name: forgotPassword,
    page: () => const ForgotPassword(),
    binding: AuthBindings(),
  ),
  GetPage(
    name: helpAndSupport,
    page: () => const HelpAndSupport(),
  ),
  GetPage(
    name: resetPassword,
    page: () => const ResetPassword(),
  ),
  GetPage(
    name: transactionReceipt,
    page: () => const TransactionReceipt(),
  ),

  // === SECURITY === //

  GetPage(
    name: personalSecurity,
    page: () => const PersonalSecurity(),
  ),
  // GetPage(
  //   name: sendMoney,
  //   page: () => const SendMoney(),
  //   bindings: [
  //     UserBindings(),
  //     BeneficiariesBinding(),
  //   ],
  // ),
  GetPage(
    name: verifyEmail,
    page: () => const VerifyEmail(),
    binding: AuthBindings(),
  ),
  GetPage(
    name: createPIN,
    page: () => const CreatePIN(),
    binding: AuthBindings(),
  ),
  GetPage(
    name: exchangeCash,
    page: () => const ExchangeCash(),
    bindings: [
      WalletBindings(),
      MiscBinding(),
    ],
  ),
  GetPage(
    name: fundMethods,
    page: () => const FundMethods(),
  ),
  GetPage(
    name: confirmTransaction,
    page: () => const ConfirmTransaction(),
  ),
  GetPage(
    name: accountLimits,
    page: () => const AccountLimits(),
  ),
  GetPage(
    name: enterPIN,
    page: () => const EnterPIN(),
    binding: AuthBindings(),
  ),
  GetPage(
    name: transactionSuccess,
    page: () => const TransactionSuccess(),
  ),
  GetPage(
    name: walletDetails,
    page: () => const WalletDetails(),
  ),
  GetPage(
    name: virtualAccounts,
    page: () => const VirtualAccounts(),
  ),
  GetPage(
    name: payoutAccounts,
    page: () => const PayoutAccounts(),
  ),
  GetPage(
    name: createPayoutAccount,
    page: () => const CreatePayoutAccount(),
    bindings: [
      MiscBinding(),
      BeneficiariesBinding(),
    ],
  ),
  GetPage(
    name: addCash,
    page: () => const AddCash(),
    bindings: [
      MiscBinding(),
      TransactionBindings(),
      UserBindings(),
    ],
  ),
  GetPage(
    name: confirmSwap,
    page: () => const ConfirmSwap(),
    bindings: [
      MiscBinding(),
      TransactionBindings(),
    ],
  ),
  GetPage(
    name: transferDetails,
    page: () => const TransferDetails(),
    bindings: [
      MiscBinding(),
      TransactionBindings(),
      UserBindings(),
      BeneficiariesBinding(),
    ],
  ),
  GetPage(
    name: confirmTransfer,
    page: () => const ConfirmTransfer(),
    bindings: [
      MiscBinding(),
      TransactionBindings(),
      WalletBindings(),
      AuthBindings(),
    ],
  )
];
