import '../services/local_storage.dart';
import '../services/no_storage.dart';
import '../snapshot/snapshot.dart';
import 'hasura_core_base.dart';

abstract class HasuraCore {
  ///[url] -> url to graph client
  ///[header] -> set header elements for request
  ///[token] -> change token jwt
  factory HasuraCore(String url,
      {Future<String> Function(bool isError) token,
      LocalStorage Function() localStorageDelegate,
      Map<String, String> headers}) {
    return HasuraCoreBase(url,
        headers: headers,
        token: token,
        localStorageDelegate: localStorageDelegate ?? () => NoStorage());
  }

  bool get isConnected;

  Map<String, String> get headers;

  ///change function listener for token
  void changeToken(Future<String> Function(bool isError) token);

  ///add new header
  void addHeader(String key, String value);

  ///remove new header
  void removeHeader(String key);

  ///clear all headers
  void removeAllHeader();

  ///get [Snapshot] from Subscription connection
  Snapshot subscription(String query,
      {String key, Map<String, dynamic> variables});

  ///get cached query [Snapshot]
  Snapshot cachedQuery(String query,
      {String key, Map<String, dynamic> variables});

  ///exec query in Graphql Engine
  Future query(String doc, {Map<String, dynamic> variables});

  ///exec mutation in Graphql Engine
  Future mutation(String doc,
      {Map<String, dynamic> variables, bool tryAgain = true});
}
