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
    },
    params: {},
    bodyType: BodyType.NONE,
    returnBody: true,
  );
}

Future<ApiCallResponse> getAllCall({
  String bearerToken = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'GetAll',
    apiUrl: 'https://api.igdb.com/v4/games/?fields=*&name=*',
    callType: ApiCallType.GET,
    headers: {
      'Accept': 'application/json',
      'Client-ID': 'sj8we4fkxdaz6w6qwwotxlwkom8z0c',
      'Authorization': 'Bearer sil1dubwh7tet5j97ff26s8rhut2yj',
    },
    params: {
      'BearerToken': bearerToken,
    },
    returnBody: true,
  );
}
