import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

bool isItemInFav(
  String id,
  UsersRecord currentUser,
) {
  return currentUser.favoriteList.contains(id);
}

bool isGameInCollection(
  String gameID,
  ConsolsRecord console,
) {
  if (console != null) {
    if (console.gameList.isNotEmpty) {
      return console.gameList.contains(gameID);
    }
  }
  return false;
}

bool searchInGamesDatabase(
  String text,
  String textBody,
) {
  if (text != null || text != "" || text.isNotEmpty) {
    return textBody.toLowerCase().contains(text.toLowerCase());
  }
  return false;
}

String makeParamsFromDropdown(String option) {
  switch (option) {
    case "Xbox":
      {
        return "platforms=1";
      }
      break;
    case "GamePass":
      {
        return "platforms=18";
      }
      break;
    case "PlayStation":
      {
        return "platforms=187";
      }
      break;
    case "Nintendo Switch":
      {
        return "platforms=7";
      }
      break;
    case "Stadia":
      {
        return "platforms=19";
      }
      break;
    case "Platform Six":
      {
        return "platforms=18";
      }
      break;

    default:
      {
        return "platforms=1,4";
      }
      break;
  }
}

String platformLogo(String platformname) {
  if (platformname == "PlayStation 4") {
    return ('https://firebasestorage.googleapis.com/v0/b/gamerx-a8577.appspot.com/o/playstation_ps4_tall.png?alt=media&token=55d1c1cd-54c8-4c67-a020-1d86bf53ea1e');
  } else if (platformname == "PlayStation 5") {
    return ('https://firebasestorage.googleapis.com/v0/b/gamerx-a8577.appspot.com/o/playstation_ps5_tall.png?alt=media&token=7a718a4f-f7a3-4b9d-a91d-ab1c41e21624');
  } else if (platformname == "PC") {
    return ('https://firebasestorage.googleapis.com/v0/b/gamerx-a8577.appspot.com/o/windows_alt.png?alt=media&token=2873b6ba-19f1-467a-86d3-b82bcb2249e8');
  } else if (platformname == "Nintendo Switch") {
    return ('https://firebasestorage.googleapis.com/v0/b/gamerx-a8577.appspot.com/o/nintendo_switch_tall.png?alt=media&token=cb8207d2-10bd-4cdb-b32f-4a98552a6ff9');
  } else if (platformname == "Xbox Series S/X") {
    return ('https://firebasestorage.googleapis.com/v0/b/gamerx-a8577.appspot.com/o/xbox_series_tall.png?alt=media&token=e1c6d006-fb29-4f3e-8ad8-7fddff1b25eb');
  }
  return platformname;
}
