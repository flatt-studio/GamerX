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

String platformLogo(String name) {
  if (name == "PlayStation 4") {
    return ('gs://gamerx-a8577.appspot.com/console_PlayStation.png');
  } else if (name == "PC") {
    return ('gs://gamerx-a8577.appspot.com/console_windows11.png');
  } else if (name == "PlayStation 5") {
    return ('gs://gamerx-a8577.appspot.com/console_windows11.png');
  }
  return null;
}
