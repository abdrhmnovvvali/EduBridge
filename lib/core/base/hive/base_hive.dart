import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../../extensions/generic_extensions.dart';
import '../../extensions/list_extensions.dart';
import '../../helpers/logger.dart';

class BaseHive<T> {
  BaseHive._(
    this._box,
    this._fromJson,
  );

  final Box<String> _box;
  final T Function(dynamic) _fromJson;

  static const String _key = 'data';
  static final Map<String, BaseHive?> _instances = {};

  static BaseHive<T> getInstance<T>({
    required Box<String> box,
    required T Function(dynamic) fromJson,
  }) {
    if (!_instances.containsKey(box.name)) {
      _instances[box.name] = BaseHive<T>._(box, fromJson);
    }
    return _instances[box.name] as BaseHive<T>;
  }

  Future<bool> saveData(T data) async {
    try {
      await _box.put(_key, json.encode(data.convertToMap));
      await _box.compact();
      log.success('$T data saved to [${_box.name}] box');
      return true;
    } catch (e, s) {
      log.error('Error occured while $T data was saving to [${_box.name}] box');
      log.error('$e => $s');
      return false;
    }
  }

  T? getData() {
    try {
      final result = _box.get(_key);
      if (result == null) return null;
      final data = json.decode(result);
      final savedData = _fromJson(data);
      log.success('Fetched $T data from [${_box.name}] box');
      log.success('$T data: $data');
      return savedData;
    } catch (e, s) {
      log.error(
          'Error occured while $T data was fetching from [${_box.name}] box');
      log.error('$e => $s');
      return null;
    }
  }

  Future<bool> saveListData(List<T> dataList) async {
    try {
      await _box.put(_key, json.encode(dataList.convertToMapList));
      await _box.compact();
      log.success('$T data list saved to [${_box.name}] box');
      return true;
    } catch (e, s) {
      log.error(
          'Error occured while $T data list was saving to [${_box.name}] box');
      log.error('$e => $s');
      return false;
    }
  }

  List<T> getListData() {
    try {
      final result = _box.get(_key);
      final List data = result == null ? [] : json.decode(result);
      final savedListData = data.map((e) => _fromJson(e)).toList();
      log.success('Fetched $T data list from [${_box.name}] box');
      log.success('$T data list length: ${data.length}');
      return savedListData;
    } catch (e, s) {
      log.error(
          'Error occured while $T data list was fetching from [${_box.name}] box');
      log.error('$e => $s');
      return [];
    }
  }

  Future<bool> clearData() async {
    try {
      if (_box.isEmpty) return false;
      await _box.clear();
      await _box.compact();
      log.success('[${_box.name}] box cleared successfully');
      return true;
    } catch (e, s) {
      log.error('Error occured while [${_box.name}] box was clearing');
      log.error('$e => $s');
      return false;
    }
  }
}
