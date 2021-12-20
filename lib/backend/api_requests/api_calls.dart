import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

Future<ApiCallResponse> tokenTwitchCall() {
  return ApiManager.instance.makeApiCall(
    callName: 'TokenTwitch',
    apiUrl: 'https://id.twitch.tv/oauth2/token',
    callType: ApiCallType.POST,
    headers: {
      'client_secret': '31l10c3oit9ynb0dpmqb21jwkos80c',
      'client_id': 'sj8we4fkxdaz6w6qwwotxlwkom8z0c',
      'grant_type': 'client_credentials',
      'Authorization': '31l10c3oit9ynb0dpmqb21jwkos80c',
      'Accept': 'application/json',
    },
    params: {},
    bodyType: BodyType.NONE,
    returnBody: true,
  );
}

Future<ApiCallResponse> getThreeItemCall({
  String bearerToken = 'bearer 55zo9n1c1f5i8pbm11sayt9v7oq8iw',
}) {
  final body = '''
fields *;
where rating > 75;
limit 10;''';
  return ApiManager.instance.makeApiCall(
    callName: 'GetThreeItem',
    apiUrl: 'https://api.igdb.com/v4/games/',
    callType: ApiCallType.POST,
    headers: {
      'Authorization': '${bearerToken}',
      'Client-ID': 'sj8we4fkxdaz6w6qwwotxlwkom8z0c',
      'Accept': 'application/json',
    },
    params: {},
    body: body,
    bodyType: BodyType.TEXT,
    returnBody: true,
  );
}

Future<ApiCallResponse> getImageCall({
  String id = '85031',
  String bearerToken = 'bearer 55zo9n1c1f5i8pbm11sayt9v7oq8iw',
}) {
  final body = '''
fields screenshots.*;
where id=87596;
limit 1;''';
  return ApiManager.instance.makeApiCall(
    callName: 'GetImage',
    apiUrl: 'https://api.igdb.com/v4/games/',
    callType: ApiCallType.POST,
    headers: {
      'Authorization': '${bearerToken}',
      'Client-ID': 'sj8we4fkxdaz6w6qwwotxlwkom8z0c',
      'Accept': 'application/json',
    },
    params: {
      'id': id,
    },
    body: body,
    bodyType: BodyType.TEXT,
    returnBody: true,
  );
}

Future<ApiCallResponse> getAllCall({
  String bearerToken = '',
}) {
  final body = '''
fields *;
name *;''';
  return ApiManager.instance.makeApiCall(
    callName: 'GetAll',
    apiUrl: 'https://api.igdb.com/v4/games/',
    callType: ApiCallType.POST,
    headers: {
      'Accept': 'application/json',
      'Client-ID': 'sj8we4fkxdaz6w6qwwotxlwkom8z0c',
      'Authorization': '${bearerToken}',
    },
    params: {},
    body: body,
    bodyType: BodyType.TEXT,
    returnBody: true,
  );
}
