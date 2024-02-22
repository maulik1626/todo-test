import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

/// Enum representing different types of internet connections.
enum ConnectionType { mobileData, wifi, vpn, none }

/// A utility class for managing and checking internet connections.
class ConnectionManager {
  final Connectivity _connectivity = Connectivity();

  /// Determines the type of internet connection currently available.
  ///
  /// Returns [ConnectionType.mobileData] for mobile data,
  /// [ConnectionType.wifi] for Wi-Fi, [ConnectionType.vpn] for VPN,
  /// and [ConnectionType.none] if no internet connection is detected.
  Future<ConnectionType> getInternetConnectionType() async {
    final connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile) {
      return ConnectionType.mobileData;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return ConnectionType.wifi;
    } else if (connectivityResult == ConnectivityResult.vpn) {
      return ConnectionType.vpn;
    }

    return ConnectionType.none;
  }

  /// Checks if the device is connected to mobile data.
  ///
  /// Returns `true` if connected to mobile data, otherwise `false`.
  Future<bool> _checkIfMobileData() async {
    return (await getInternetConnectionType()) == ConnectionType.mobileData;
  }

  /// Checks if the device is connected to Wi-Fi.
  ///
  /// Returns `true` if connected to Wi-Fi, otherwise `false`.
  Future<bool> _checkIfWifi() async {
    return (await getInternetConnectionType()) == ConnectionType.wifi;
  }

  /// Checks if the device is connected to a VPN.
  ///
  /// Returns `true` if connected to a VPN, otherwise `false`.
  Future<bool> _checkIfVpn() async {
    return (await getInternetConnectionType()) == ConnectionType.vpn;
  }

  /// Checks if the device is connected to the internet without using VPN.
  ///
  /// Returns `true` if connected to mobile data or Wi-Fi and can reach 'google.com'.
  /// Returns `false` if connected to VPN or no internet connection is detected.
  Future<bool> isConnectedWithoutVPN() async {
    if (await _checkIfMobileData() || await _checkIfWifi()) {
      try {
        final result = await InternetAddress.lookup('google.com');
        return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } on SocketException catch (_) {
        log('Internet NOT Connected');
      }
    } else {
      log('VPN is Connected');
    }
    return false;
  }

  /// Checks if the device is connected to the internet including via using VPN.
  ///
  /// Returns `true` if any type of internet connection is available and can reach 'google.com'.
  /// Returns `false` if no internet connection is detected.
  Future<bool> isConnected() async {
    log("Checking Internet Connection");
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      log('Internet NOT Connected');
    }
    log('Internet NOT Connected');
    return false;
  }
}
