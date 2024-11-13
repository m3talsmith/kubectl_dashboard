import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config.dart';

final authenticationProvider = StateProvider<Auth?>((ref) => null,);

class Auth {
  Auth({required this.clientKeyData, required this.clientCertificateData});

  final String clientCertificateData;
  final String clientKeyData;

  Auth.fromConfig(Config config):
        clientCertificateData=config.users.first.clientCertificateData??'',
        clientKeyData=config.users.first.clientKeyData??'';

  get canAuthenticate => (clientKeyData.isNotEmpty && clientCertificateData.isNotEmpty);

  authenticate() {
    if (!canAuthenticate) {
      log('[AUTHENTICATE] error: empty credentials');
      return;
    }

  }
}