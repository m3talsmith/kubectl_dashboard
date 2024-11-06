import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final preferencesProvider = StateProvider<Preferences?>((ref) => null);

Future<Preferences> loadPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return Preferences(sharedPreferences: sharedPreferences);
}

enum PreferenceKey {
  fullscreen,
  windowSize,
  currentConfigIndex,
}

class Preferences {
  Preferences({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences {
    refresh();
  }

  final SharedPreferences _sharedPreferences;
  bool _fullscreen = false;
  Size? _windowSize;
  int _currentConfigIndex = -1;

  refresh() {
    _fullscreen =
        _sharedPreferences.getBool(PreferenceKey.fullscreen.name) ?? false;
    final size = _sharedPreferences.getString(PreferenceKey.windowSize.name);
    if (size != null && size.isNotEmpty) {
      final sizeMap = jsonDecode(size);
      _windowSize = Size(sizeMap['width'], sizeMap['height']);
    }
    _currentConfigIndex =
        _sharedPreferences.getInt(PreferenceKey.currentConfigIndex.name) ?? -1;
  }

  bool get fullscreen => _fullscreen;
  set fullscreen(bool value) {
    _fullscreen = value;
    _sharedPreferences.setBool(PreferenceKey.fullscreen.name, value);
  }

  Size? get windowSize => _windowSize;
  set windowSize(Size? value) {
    if (value == null) return;

    _windowSize = value;
    _sharedPreferences.setString(
      PreferenceKey.windowSize.name,
      jsonEncode({
        'width': value.width,
        'height': value.height,
      }),
    );
  }

  int get currentConfigIndex => _currentConfigIndex;
  set currentConfigIndex(int value) {
    _currentConfigIndex = value;
    _sharedPreferences.setInt(PreferenceKey.currentConfigIndex.name, value);
  }
}
