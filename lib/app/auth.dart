import 'dart:convert';
import 'dart:developer';
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
    Cluster? cluster,
    User? user,
    String? token,
    DateTime? expires,
    Uint8List? clientCertificateAuthority,
    Uint8List? clientCertificate,
    Uint8List? clientKey,
  })  : _cluster = cluster,
        _user = user,
        _token = token,
        _expirationTimestamp = expires,
        _clientCertificateAuthority = clientCertificateAuthority,
        _clientCertificateData = clientCertificate,
        _clientKeyData = clientKey;

  Cluster? _cluster;
  User? _user;
  String? _token;
  DateTime? _expirationTimestamp;
  Uint8List? _clientCertificateAuthority;
  Uint8List? _clientCertificateData;
  Uint8List? _clientKeyData;
  AuthClient? client;

  Auth.fromConfig(Config config) {
    final context =
        config.contexts.firstWhere((e) => e.name == config.currentContext);
    final cluster =
        config.clusters.firstWhere((e) => e.name == context.cluster);
    final user = config.users.firstWhere((e) => e.name == context.user);

    final ca = base64Decode(cluster.certificateAuthorityData ?? '');
    final cert = base64Decode(user.clientCertificateData ?? '');
    final key = base64Decode(user.clientKeyData ?? '');

    _cluster = cluster;
    _user = user;
    _clientCertificateAuthority = ca;
    _clientCertificateData = cert;
    _clientKeyData = key;
  }

  String get clientCertificateAuthority =>
      utf8.decode(_clientCertificateAuthority ?? []);

  String get clientCertificate => utf8.decode(_clientCertificateData ?? []);

  String get clientKey => utf8.decode(_clientKeyData ?? []);

  Cluster? get cluster => _cluster;

  Future<void> ensureInitialization() async {
    if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      if (_user != null && _user!.exec != null) {
        final Exec exec = _user!.exec!;
        if (exec.command != null && exec.arguments != null) {
          final results = await Process.run(exec.command!, exec.arguments!);

          if (results.exitCode > 0) {
            throw Exception(
              'Auth.ensureInitialization: exec: error: ${results.stderr}',
            );
          }

          final output = results.stdout as String;

          if (output.isNotEmpty) {
            try {
              final data = jsonDecode(output);
              final result = ExecResult.fromMap(data);
              _token = result.status.token;
              _expirationTimestamp = result.status.expirationTimestamp;
            } catch (err, stackTrace) {
              log('[ERROR] Auth.ensureInitialization: $err\n$stackTrace');
            }
          }
        }
      }
    }
    client = await _authClient();
  }

  Future<AuthClient> _authClient() async {
    if (_token != null) {
      return AuthBearer(token: _token!);
    }
    return AuthCert(
      clientCertificateAuthority: _clientCertificateAuthority ?? Uint8List(0),
      clientCertificateData: _clientCertificateData ?? Uint8List(0),
      clientKeyData: _clientKeyData ?? Uint8List(0),
    );
  }

  Future<Response> get(Uri url, {Map<String, String>? headers}) async {
    client ??= await _authClient();
    return client!.get(
      url,
      headers: headers,
    );
  }

  Future<Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    client ??= await _authClient();
    return client!.post(
      url,
      headers: headers,
    );
  }

  Future<Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    client ??= await _authClient();
    return client!.put(
      url,
      headers: headers,
    );
  }

  Future<Response> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    client ??= await _authClient();
    return client!.patch(
      url,
      headers: headers,
    );
  }

  Future<Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    client ??= await _authClient();
    return client!.delete(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }
}

abstract class AuthClient extends BaseClient {
  static const String _userAgent = 'kubectl_dashboard v1';
}

class AuthCert extends BaseClient implements AuthClient {
  AuthCert({
    required this.clientCertificateAuthority,
    required this.clientCertificateData,
    required this.clientKeyData,
  });

  final Uint8List clientCertificateAuthority;
  final Uint8List clientCertificateData;
  final Uint8List clientKeyData;

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers['user-agent'] = AuthClient._userAgent;
    var context = SecurityContext()
      ..allowLegacyUnsafeRenegotiation = true
      ..setClientAuthoritiesBytes(clientCertificateAuthority)
      ..useCertificateChainBytes(clientCertificateData)
      ..usePrivateKeyBytes(clientKeyData);
    var client = HttpClient(context: context)
      ..badCertificateCallback = (_, __, ___) => true;
    return IOClient(client).send(request);
  }
}

class AuthBearer extends BaseClient implements AuthClient {
  AuthBearer({required this.token, this.expirationTimestamp});

  final String token;
  final DateTime? expirationTimestamp;

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    if (expirationTimestamp != null) {
      final now = DateTime.now();
      if (expirationTimestamp!.isBefore(now)) {
        throw Exception('Bearer token is expired');
      }
    }

    request.headers['user-agent'] = AuthClient._userAgent;
    request.headers['Authorization'] = 'Bearer $token';
    var context = SecurityContext()..allowLegacyUnsafeRenegotiation = true;
    var client = HttpClient(context: context)
      ..badCertificateCallback = (_, __, ___) => true;
    return IOClient(client).send(request);
  }
}
