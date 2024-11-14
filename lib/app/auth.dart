import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

import 'config.dart';

final authenticationProvider = StateProvider<Auth?>(
  (ref) => null,
);

class Auth {
  Auth({
    Uint8List? clientCertificateAuthority,
    Uint8List? clientCertificate,
    Uint8List? clientKey,
    Cluster? cluster,
    User? user,
  })  : _clientCertificateAuthority = clientCertificateAuthority,
        _clientCertificateData = clientCertificate,
        _clientKeyData = clientKey,
        _cluster = cluster,
        _user = user {
    client = _authClient();
  }

  Cluster? _cluster;
  User? _user;
  Uint8List? _clientCertificateAuthority;
  Uint8List? _clientCertificateData;
  Uint8List? _clientKeyData;
  AuthClient? client;

  Auth.fromConfig(Config config) {
    _cluster ??= config.clusters.first;
    _user ??= config.users.first;
    _clientCertificateAuthority =
        base64Decode(_cluster?.certificateAuthorityData ?? '');
    _clientCertificateData = base64Decode(_user?.clientCertificateData ?? '');
    _clientKeyData = base64Decode(_user?.clientKeyData ?? '');
    client = _authClient();
  }

  String get clientCertificateAuthority =>
      utf8.decode(_clientCertificateAuthority ?? []);
  String get clientCertificate => utf8.decode(_clientCertificateData ?? []);
  String get clientKey => utf8.decode(_clientKeyData ?? []);

  Cluster? get cluster => _cluster;

  AuthClient _authClient() {
    return AuthClient(
      clientCertificateAuthority: _clientCertificateAuthority,
      clientCertificateData: _clientCertificateData,
      clientKeyData: _clientKeyData,
    );
  }

  Future<Response> get(Uri url, {Map<String, String>? headers}) async {
    client ??= _authClient();
    return client!.get(url, headers: headers);
  }

  Future<Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    client ??= _authClient();
    return client!.post(url, headers: headers);
  }

  Future<Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    client ??= _authClient();
    return client!.put(url, headers: headers);
  }

  Future<Response> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    client ??= _authClient();
    return client!.patch(url, headers: headers);
  }

  Future<Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    client ??= _authClient();
    return client!
        .delete(url, headers: headers, body: body, encoding: encoding);
  }
}

class AuthClient extends BaseClient {
  AuthClient({
    this.clientCertificateAuthority,
    this.clientCertificateData,
    this.clientKeyData,
  });

  final String _userAgent = 'kubectl_dashboard v1';
  Uint8List? clientCertificateAuthority;
  Uint8List? clientCertificateData;
  Uint8List? clientKeyData;

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers['user-agent'] = _userAgent;
    var context = SecurityContext()
      ..allowLegacyUnsafeRenegotiation=true
      ..setClientAuthoritiesBytes(clientCertificateAuthority ?? [])
      ..useCertificateChainBytes(clientCertificateData ?? [])
      ..usePrivateKeyBytes(clientKeyData ?? []);
    var client = HttpClient(context: context)
      ..badCertificateCallback=(_, __, ___) => true;
    return IOClient(client).send(request);
  }
}
