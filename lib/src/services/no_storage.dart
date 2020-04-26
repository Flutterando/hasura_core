import 'dart:async';

import 'local_storage.dart';

class NoStorage extends LocalStorage {
  @override
  Future clear() async {}

  @override
  Future close() async {}

  @override
  Future<Map<String, String>> getAll() async {
    return null;
  }

  @override
  Future<Map> getValue(String key) async {
    return null;
  }

  @override
  Future init(String name) async {}

  @override
  Future put(String key, Map query) async {}

  @override
  Future<bool> remove(String key) async {
    return true;
  }
}
