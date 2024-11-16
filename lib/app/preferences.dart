import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kubectl_dashboard/window.dart';
import 'package:shared_preferences/shared_preferences.dart';

final preferencesProvider = StateProvider<Preferences?>((ref) => null);

Future<Preferences> loadPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return Preferences(sharedPreferences: sharedPreferences);
}

enum PreferenceKey {
  fullscreen,
  windowSize,
  windowPosition,
  currentConfigIndex,
  currentContextIndex,
}

class Preferences {
  Preferences({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences {
    refresh();
  }

  final SharedPreferences _sharedPreferences;
  bool _fullscreen = false;
  Size? _windowSize;
  WindowPosition? _windowPosition;
  int _currentConfigIndex = -1;
  int _currentContextIndex = -1;

  refresh() {
    _fullscreen =
        _sharedPreferences.getBool(PreferenceKey.fullscreen.name) ?? false;
    final size = _sharedPreferences.getString(PreferenceKey.windowSize.name);
    if (size != null && size.isNotEmpty) {
      final sizeMap = jsonDecode(size);
      _windowSize = Size(sizeMap['width'], sizeMap['height']);
    }
    final position =
        _sharedPreferences.getString(PreferenceKey.windowPosition.name);
    if (position != null && position.isNotEmpty) {
      final positionMap = jsonDecode(position);
      _windowPosition = WindowPosition(
        right: positionMap['right'],
        left: positionMap['left'],
        top: positionMap['top'],
        bottom: positionMap['bottom'],
        center: positionMap['center'],
      );
    }
    _currentConfigIndex =
        _sharedPreferences.getInt(PreferenceKey.currentConfigIndex.name) ?? -1;
    _currentContextIndex =
        _sharedPreferences.getInt(PreferenceKey.currentContextIndex.name) ?? -1;
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

  WindowPosition? get windowPosition => _windowPosition;
  set windowPosition(WindowPosition? value) {
    if (value == null) return;

    _windowPosition = value;
    _sharedPreferences.setString(
      PreferenceKey.windowPosition.name,
      jsonEncode({
        'left': value.left,
        'right': value.right,
        'top': value.top,
        'bottom': value.bottom,
        'center': value.center,
      }),
    );
  }

  int get currentConfigIndex => _currentConfigIndex;
  set currentConfigIndex(int value) {
    _currentConfigIndex = value;
    _sharedPreferences.setInt(PreferenceKey.currentConfigIndex.name, value);
  }

  int get currentContextIndex => _currentContextIndex;
  set currentContextIndex(int value) {
    _currentContextIndex = value;
    _sharedPreferences.setInt(PreferenceKey.currentContextIndex.name, value);
  }
}
