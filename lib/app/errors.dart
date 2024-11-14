import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final errorsProvider = StateProvider<List<Error>>(
  (ref) => [],
);

class Error {
  Error({
    required this.message,
    this.statusCode,
  });

  final int? statusCode;
  final String message;
}

class ErrorView extends StatelessWidget {
  const ErrorView({required this.error, super.key});

  final Error error;

  @override
  Widget build(BuildContext context) {
    return Text('ERROR: ${error.message}: status code: ${error.statusCode}');
  }

}