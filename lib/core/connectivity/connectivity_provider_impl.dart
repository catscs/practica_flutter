import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:marvel_flutter/core/connectivity/connectivity_provider.dart';

class ConnectivityProviderImpl implements ConnectivityProvider {
  @override
  Future<bool> get isNetworkAvailable async =>
      await InternetConnectionChecker().hasConnection;
}
