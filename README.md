# Hasura Core Package

Connect your Flutter/Dart apps to Hasura simply.

## What can he do

  The hasura_core is designed to facilitate Hasura's integration with Flutter applications, leveraging the full power of Graphql.

- Use Query, Mutation and Subscriptions the easy way.
- Offline cache for Subscription and Mutation made from a Snapshot.
- Easy integration with leading dart providers (Provider, bloc_pattern).
- Pass your JWT Token easily if you are informed when it is invalid.

## Install

Add dependency in your pubspec.yaml file:
```
dependencies:
  hasura_core:
```
or use Slidy:
```
slidy install hasura_core
```

## Usage

A simple usage example:

```dart

//import
import 'package:hasura_core/hasura.dart';

String url = 'http://localhost:8080/v1/graphql';
HasuraCore hasuraCore = HasuraCore(url);

```
You can encapsulate this instance into a BLoC class or directly into a Provider.

Create a document with Query:

```dart
//document
String docQuery = """
  query {
    authors {
        id
        email
        name
      }
  }
""";

```
Now just add the document to the "query" method of the HasuraCore instance.

```dart
//get query
var r = await hasuraCore.query(docQuery);

//get query with cache
var r = await hasuraCore.cachedQuery(docQuery);

//OR USE MUTATION
var r = await hasuraCore.mutation(docQuery);
```

## Subscriptions

Subscriptions will notify you each time you have a change to the searched items. Use the "hasuraCore.subscription" method to receive a stream.

```dart
Snapshot snapshot = hasuraCore.subscription(docSubscription);
  snapshot.listen((data) {
    print(data);
  }).onError((err) {
    print(err);
  });

```

### Subscription Converter

Use the Map operator to convert json data to a Dart object;

```dart
Snapshot<PostModel> snapshot = hasuraCore
                                  .subscription(docSubscription)
                                  .convert((data) => PostModel.fromJson(data),
                                        cachePersist: (PostModel post) => post.toJson(),
                                      );

snapshot.listen((PostModel data) {
   print(data);
 }).onError((err) {
   print(err);
 });
```

## Using variables

Variables maintain the integrity of Querys, see an example:

```dart

String docSubscription = """
  subscription algumaCoisa($limit:Int!){
    users(limit: $limit, order_by: {user_id: desc}) {
      id
      email
      name
    }
  }
""";

Snapshot snapshot = hasuraCore.subscription(docSubscription, variables: {"limit": 10});

//change values of variables for PAGINATIONS
snapshot.changeVariable({"limit": 20});

```

## Authorization (JWT Token)

[View Hasura's official Authorization documentation](https://docs.hasura.io/1.0/graphql/manual/auth/index.html).

```dart

String url = 'http://localhost:8080/v1/graphql';
HasuraCore hasuraCore = HasuraCore(url, token: (isError) async {
  //sharedPreferences or other storage logic
  return "Bearer YOUR-JWT-TOKEN";
});

```


## Custom Database by Delegate

You can add others database to work with cache using **localStorageDelegate** param in **HasuraCore** construct.

This library have two delegates:
- **LocalStorageSharedPreferences** (default) 
- **LocalStorageHive** (Using Hive Database for Desktops)

Implements **LocalStorage** interface and use any Database:

```dart
HasuraCore hasuraCore = HasuraCore(url,
            localStorageDelegate: () => LocalStorageHive(),);
```

## Dispose

HasuraCore provides a dispose() method for use in Provider or BlocProvider.
Subscription will start only when someone is listening, and when all listeners are closed HasuraCore automatically disconnects.

Therefore, we only connect to Hasura when we are actually using it;

## Roadmap

This is currently our roadmap, please feel free to request additions/changes.

| Feature                                | Progress |
| :------------------------------------- | :------: |
| Queries                                |    ✅    |
| Mutations                              |    ✅    |
| Subscriptions                          |    ✅    |
| Change Variable in Subscriptions       |    ✅    |
| Auto-Reconnect                         |    ✅    |
| Dynamic JWT Token                      |    ✅    |
| bloc_pattern Integration               |    ✅    |
| Provider Integration                   |    ✅    |
| Variables                              |    ✅    |


## Features and bugs

Please send feature requests and bugs at the [issue tracker](https://github.com/Flutterando/hasura_core/issues).

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).
