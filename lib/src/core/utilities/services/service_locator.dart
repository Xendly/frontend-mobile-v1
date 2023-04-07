// import 'package:http/http.dart' as http;
// import 'package:khandaq_pay/src/core/constants/imports_paths.dart';

// void init() {
//   // Bloc
//   regFactory(() => AuthBloc(locator(), locator()));
//   regFactory(() => TransactionsBloc(locator()));
//   regFactory(() => AccountBloc(locator(), locator()));

//   // Use Cases
//   regSingleton(() => RegisterUser(locator()));
//   regSingleton(() => LoginUser(locator()));
//   regSingleton(() => GetTransactions(locator()));
//   regSingleton(() => FundYourAccount(locator()));
//   regSingleton(() => WithdarFromAccount(locator()));

//   // Repositories
//   regSingleton<UserRepository>(() => UserRespositoryImpl(locator()));
//   regSingleton<TransactionRepository>(() => TransactionRepoImpl(locator()));
//   regSingleton<AccountsRepository>(() => AccountsRepositoryImpl(locator()));

//   // Data Sources
//   regSingleton<RemoteDataSource>(() => RemoteDataSourceImpl(client: locator()));
//   regSingleton(() => http.Client());
// }
