import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkinfoImpl implements NetworkInfo {
  final InternetConnectionChecker internetChecker;
  NetworkinfoImpl( this.internetChecker);
  @override
  // TODO: implement isConnected
  Future<bool> get isConnected => internetChecker.hasConnection;
}
