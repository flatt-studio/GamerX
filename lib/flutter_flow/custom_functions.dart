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
  if (platformname == "PlayStation 4" "PlayStation 5") {
    return ('https://firebasestorage.googleapis.com/v0/b/gamerx-a8577.appspot.com/o/console_PlayStation.png?alt=media&token=b5945745-a23f-4858-91c2-5ddcb269ea81');
  } else if (platformname == "PC") {
    return ('https://firebasestorage.googleapis.com/v0/b/gamerx-a8577.appspot.com/o/console_windows11.png?alt=media&token=589fa5ab-553f-4916-b5e3-09a8fd6c0195');
  } else if (platformname == "Nintendo Switch") {
    return ('https://firebasestorage.googleapis.com/v0/b/gamerx-a8577.appspot.com/o/console_Nintendo.png?alt=media&token=d9c40f4a-30c0-4ac5-9cc3-54de263f115e');
  } else if (platformname == "Xbox*") {
    return ('https://firebasestorage.googleapis.com/v0/b/gamerx-a8577.appspot.com/o/console_XBOX.png?alt=media&token=538b2cf5-7dce-45df-937f-f782b541eecf');
  }
  return platformname;
}
