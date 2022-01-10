import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class TokenTwitchCall {
  static Future<ApiCallResponse> call() {
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
}

class GetThreeItemCall {
  static Future<ApiCallResponse> call({
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
}

class GetImageCall {
  static Future<ApiCallResponse> call({
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
}

class GetAllCall {
  static Future<ApiCallResponse> call({
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
}

class GetPlatformsRAWGCall {
  static Future<ApiCallResponse> call({
    String apiKey = '1c52992961514c789f02e65493cfbb83',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getPlatformsRAWG',
      apiUrl: 'https://api.rawg.io/api/platforms?key=${apiKey}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}

class GetThreeGamesRAWGCall {
  static Future<ApiCallResponse> call({
    String apiKey = '1c52992961514c789f02e65493cfbb83',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getThreeGamesRAWG',
      apiUrl:
          'https://api.rawg.io/api/games?key=${apiKey}&dates=2021-10-10,2022-10-10&ordering=-added',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}

class GetPopularGamesRAWGCall {
  static Future<ApiCallResponse> call({
    String apiKey = '1c52992961514c789f02e65493cfbb83',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getPopularGamesRAWG',
      apiUrl:
          'https://api.rawg.io/api/games?key=${apiKey}&dates=2022-01-01,2022-12-30&ordering=-rating',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}

class GetReleasedGamesRAWGCall {
  static Future<ApiCallResponse> call({
    String apiKey = '1c52992961514c789f02e65493cfbb83',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getReleasedGamesRAWG',
      apiUrl:
          'https://api.rawg.io/api/games?key=${apiKey}&dates=2022-01-01,2022-12-30&ordering=-released',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}

class GetPlatformsOfaGameRAWGCall {
  static Future<ApiCallResponse> call({
    String apiKey = '1c52992961514c789f02e65493cfbb83',
    String platformNumber = '4,6',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getPlatformsOfaGameRAWG',
      apiUrl:
          'https://api.rawg.io/api/platforms/${platformNumber}?key=${apiKey}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}

class GetaGameCall {
  static Future<ApiCallResponse> call({
    String apiKey = '1c52992961514c789f02e65493cfbb83',
    String id = '1',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getaGame',
      apiUrl: 'https://api.rawg.io/api/games/${id}?key=${apiKey}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}

class GetScreenshotsOfaGameCall {
  static Future<ApiCallResponse> call({
    String apiKey = '1c52992961514c789f02e65493cfbb83',
    String id = '1',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getScreenshotsOfaGame',
      apiUrl: 'https://api.rawg.io/api/games/${id}/screenshots?key=${apiKey}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}

class GetGameSearchResultCall {
  static Future<ApiCallResponse> call({
    String apiKey = '1c52992961514c789f02e65493cfbb83',
    String text = 'game',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getGameSearchResult',
      apiUrl: 'https://api.rawg.io/api/games?key=${apiKey}&search=${text}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}

class GetGamesInAPlatformCall {
  static Future<ApiCallResponse> call({
    String apiKey = '1c52992961514c789f02e65493cfbb83',
    String param = 'platforms=1,4',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getGamesInAPlatform',
      apiUrl: 'https://api.rawg.io/api/games?key=${apiKey}&${param}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}

class GetAchievementsOfaGameRAWGCall {
  static Future<ApiCallResponse> call({
    String apiKey = '1c52992961514c789f02e65493cfbb83',
    String id = '4',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getAchievementsOfaGameRAWG',
      apiUrl: 'https://api.rawg.io/api/games/${id}/achievements?key=${apiKey}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}

class GetMoviesOfaGameRAWGCall {
  static Future<ApiCallResponse> call({
    String apiKey = '1c52992961514c789f02e65493cfbb83',
    String id = '4',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getMoviesOfaGameRAWG',
      apiUrl: 'https://api.rawg.io/api/games/${id}/movies?key=${apiKey}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}
