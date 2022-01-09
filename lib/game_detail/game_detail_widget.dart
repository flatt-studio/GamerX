import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../components/add_to_console_modal_widget.dart';
import '../flutter_flow/flutter_flow_expanded_image_view.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class GameDetailWidget extends StatefulWidget {
  const GameDetailWidget({
    Key key,
    this.gameId,
  }) : super(key: key);

  final String gameId;

  @override
  _GameDetailWidgetState createState() => _GameDetailWidgetState();
}

class _GameDetailWidgetState extends State<GameDetailWidget> {
  double ratingBarValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiCallResponse>(
      future: GetaGameCall.call(
        id: widget.gameId,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                color: FlutterFlowTheme.primaryColor,
              ),
            ),
          );
        }
        final gameDetailGetaGameResponse = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0xFF090F13),
          body: StreamBuilder<List<UsersRecord>>(
            stream: queryUsersRecord(
              queryBuilder: (usersRecord) =>
                  usersRecord.where('uid', isEqualTo: currentUserUid),
              singleRecord: true,
            ),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      color: FlutterFlowTheme.primaryColor,
                    ),
                  ),
                );
              }
              List<UsersRecord> columnUsersRecordList = snapshot.data;
              final columnUsersRecord = columnUsersRecordList.isNotEmpty
                  ? columnUsersRecordList.first
                  : null;
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            height: 450,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: CachedNetworkImage(
                                    imageUrl: getJsonField(
                                      gameDetailGetaGameResponse.jsonBody,
                                      r'''$.background_image''',
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    height: 450,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 35, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if (!(functions.isItemInFav(widget.gameId,
                                              columnUsersRecord)) ??
                                          true)
                                        FlutterFlowIconButton(
                                          borderColor: Colors.transparent,
                                          borderRadius: 30,
                                          borderWidth: 1,
                                          buttonSize: 44,
                                          icon: Icon(
                                            Icons.favorite_border,
                                            color:
                                                FlutterFlowTheme.tertiaryColor,
                                            size: 24,
                                          ),
                                          onPressed: () async {
                                            final usersUpdateData = {
                                              'favoriteList':
                                                  FieldValue.arrayUnion(
                                                      [widget.gameId]),
                                            };
                                            await currentUserReference
                                                .update(usersUpdateData);
                                          },
                                        ),
                                      if (functions.isItemInFav(widget.gameId,
                                              columnUsersRecord) ??
                                          true)
                                        FlutterFlowIconButton(
                                          borderColor: Colors.transparent,
                                          borderRadius: 30,
                                          borderWidth: 1,
                                          buttonSize: 44,
                                          icon: Icon(
                                            Icons.favorite_sharp,
                                            color: Color(0xFFFF0000),
                                            size: 24,
                                          ),
                                          onPressed: () async {
                                            final usersUpdateData = {
                                              'favoriteList':
                                                  FieldValue.arrayRemove(
                                                      [widget.gameId]),
                                            };
                                            await currentUserReference
                                                .update(usersUpdateData);
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-0.9, -0.84),
                                  child: FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 30,
                                    buttonSize: 48,
                                    icon: Icon(
                                      Icons.arrow_back_rounded,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, 0.85),
                                  child: StreamBuilder<List<ConsolsRecord>>(
                                    stream: queryConsolsRecord(
                                      queryBuilder: (consolsRecord) =>
                                          consolsRecord.where('gameList',
                                              arrayContains:
                                                  valueOrDefault<String>(
                                                widget.gameId,
                                                'false',
                                              )),
                                      singleRecord: true,
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: CircularProgressIndicator(
                                              color:
                                                  FlutterFlowTheme.primaryColor,
                                            ),
                                          ),
                                        );
                                      }
                                      List<ConsolsRecord>
                                          containerConsolsRecordList =
                                          snapshot.data;
                                      final containerConsolsRecord =
                                          containerConsolsRecordList.isNotEmpty
                                              ? containerConsolsRecordList.first
                                              : null;
                                      return Container(
                                        height: 70,
                                        decoration: BoxDecoration(),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            if (!(functions.isGameInCollection(
                                                    widget.gameId,
                                                    containerConsolsRecord)) ??
                                                true)
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0, 0.8),
                                                child: FFButtonWidget(
                                                  onPressed: () async {
                                                    await showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      context: context,
                                                      builder: (context) {
                                                        return Padding(
                                                          padding:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .viewInsets,
                                                          child: Container(
                                                            height: 480,
                                                            child:
                                                                AddToConsoleModalWidget(
                                                              gameId:
                                                                  widget.gameId,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  text: 'Add To Collection',
                                                  icon: Icon(
                                                    Icons.bookmarks_sharp,
                                                    size: 15,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: 185,
                                                    height: 40,
                                                    color: FlutterFlowTheme
                                                        .customColor1,
                                                    textStyle: FlutterFlowTheme
                                                        .subtitle2
                                                        .override(
                                                      fontFamily: 'Roboto',
                                                      color: Colors.white,
                                                    ),
                                                    elevation: 15,
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1,
                                                    ),
                                                    borderRadius: 12,
                                                  ),
                                                ),
                                              ),
                                            if (functions.isGameInCollection(
                                                    widget.gameId,
                                                    containerConsolsRecord) ??
                                                true)
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0, 0.8),
                                                child: FFButtonWidget(
                                                  onPressed: () async {
                                                    final consolsUpdateData = {
                                                      'gameList': FieldValue
                                                          .arrayRemove(
                                                              [widget.gameId]),
                                                    };
                                                    await containerConsolsRecord
                                                        .reference
                                                        .update(
                                                            consolsUpdateData);
                                                  },
                                                  text: 'Remove',
                                                  icon: Icon(
                                                    Icons
                                                        .bookmark_border_rounded,
                                                    size: 15,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: 185,
                                                    height: 40,
                                                    color: FlutterFlowTheme
                                                        .secondaryColor,
                                                    textStyle: FlutterFlowTheme
                                                        .subtitle2
                                                        .override(
                                                      fontFamily: 'Roboto',
                                                      color: Colors.white,
                                                    ),
                                                    elevation: 15,
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1,
                                                    ),
                                                    borderRadius: 12,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            getJsonField(
                              gameDetailGetaGameResponse.jsonBody,
                              r'''$.name''',
                            ).toString().maybeHandleOverflow(maxChars: 34),
                            style: FlutterFlowTheme.title2.override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getJsonField(
                                    gameDetailGetaGameResponse.jsonBody,
                                    r'''$.released''',
                                  ).toString(),
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF8B97A2),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Builder(
                                  builder: (context) {
                                    final platforms = getJsonField(
                                          gameDetailGetaGameResponse.jsonBody,
                                          r'''$.platforms''',
                                        )?.toList() ??
                                        [];
                                    return Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: List.generate(platforms.length,
                                          (platformsIndex) {
                                        final platformsItem =
                                            platforms[platformsIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 0, 5, 0),
                                          child: FutureBuilder<ApiCallResponse>(
                                            future: GetPlatformsOfaGameRAWGCall
                                                .call(
                                              platformNumber: getJsonField(
                                                platformsItem,
                                                r'''$.id''',
                                              ).toString(),
                                            ),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child: SizedBox(
                                                    width: 40,
                                                    height: 40,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: FlutterFlowTheme
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                );
                                              }
                                              final imageGetPlatformsOfaGameRAWGResponse =
                                                  snapshot.data;
                                              return CachedNetworkImage(
                                                imageUrl: getJsonField(
                                                  imageGetPlatformsOfaGameRAWGResponse
                                                      .jsonBody,
                                                  r'''$.image_background''',
                                                ),
                                                width: 25,
                                                height: 25,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                        );
                                      }),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 1,
                            decoration: BoxDecoration(
                              color: Color(0xFF353D43),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                                child: Text(
                                  'Ratings',
                                  style: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF8B97A2),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 4),
                                  child: Text(
                                    getJsonField(
                                      gameDetailGetaGameResponse.jsonBody,
                                      r'''$.rating''',
                                    ).toString(),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.title1.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 4),
                                  child: Text(
                                    'Rating',
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF8B97A2),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                RatingBar.builder(
                                  onRatingUpdate: (newValue) =>
                                      setState(() => ratingBarValue = newValue),
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star_rounded,
                                    color: Color(0xFFFFCE00),
                                  ),
                                  direction: Axis.horizontal,
                                  initialRating: ratingBarValue ??=
                                      getJsonField(
                                    gameDetailGetaGameResponse.jsonBody,
                                    r'''$.rating''',
                                  ),
                                  unratedColor: Color(0xFF9E9E9E),
                                  itemCount: 5,
                                  itemSize: 18,
                                  glowColor: Color(0xFFFFCE00),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(8, 12, 8, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 4),
                                  child: Text(
                                    getJsonField(
                                      gameDetailGetaGameResponse.jsonBody,
                                      r'''$.rating_top''',
                                    ).toString(),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.title1.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 4),
                                  child: Text(
                                    'Rating Top',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF8B97A2),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 4),
                                  child: Text(
                                    getJsonField(
                                      gameDetailGetaGameResponse.jsonBody,
                                      r'''$.playtime''',
                                    ).toString(),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.title1.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 4),
                                  child: Text(
                                    'Playtime',
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF8B97A2),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 4),
                                    child: Text(
                                      'Description',
                                      style:
                                          FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF8B97A2),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    getJsonField(
                                      gameDetailGetaGameResponse.jsonBody,
                                      r'''$.description''',
                                    ).toString(),
                                    style: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 12, 16, 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 4),
                                  child: Text(
                                    'Screen Shots',
                                    style: FlutterFlowTheme.subtitle1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: FutureBuilder<ApiCallResponse>(
                                    future: GetScreenshotsOfaGameCall.call(
                                      id: widget.gameId,
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: CircularProgressIndicator(
                                              color:
                                                  FlutterFlowTheme.primaryColor,
                                            ),
                                          ),
                                        );
                                      }
                                      final rowGetScreenshotsOfaGameResponse =
                                          snapshot.data;
                                      return Builder(
                                        builder: (context) {
                                          final screenShot = getJsonField(
                                                rowGetScreenshotsOfaGameResponse
                                                    .jsonBody,
                                                r'''$.results''',
                                              )?.toList() ??
                                              [];
                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  screenShot.length,
                                                  (screenShotIndex) {
                                                final screenShotItem =
                                                    screenShot[screenShotIndex];
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 10, 0),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      await Navigator.push(
                                                        context,
                                                        PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              FlutterFlowExpandedImageView(
                                                            image:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  getJsonField(
                                                                screenShotItem,
                                                                r'''$.image''',
                                                              ),
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                            allowRotation:
                                                                false,
                                                            tag: 'imageTag3',
                                                            useHeroAnimation:
                                                                true,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Hero(
                                                      tag: 'imageTag3',
                                                      transitionOnUserGestures:
                                                          true,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              getJsonField(
                                                            screenShotItem,
                                                            r'''$.image''',
                                                          ),
                                                          width: 150,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 12, 16, 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 4),
                                  child: Text(
                                    'Trailers',
                                    style: FlutterFlowTheme.subtitle1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: FutureBuilder<ApiCallResponse>(
                                    future: GetMoviesOfaGameRAWGCall.call(),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: CircularProgressIndicator(
                                              color:
                                                  FlutterFlowTheme.primaryColor,
                                            ),
                                          ),
                                        );
                                      }
                                      final rowGetMoviesOfaGameRAWGResponse =
                                          snapshot.data;
                                      return Builder(
                                        builder: (context) {
                                          final gameTrailers = getJsonField(
                                                rowGetMoviesOfaGameRAWGResponse
                                                    .jsonBody,
                                                r'''$.results''',
                                              )?.toList() ??
                                              [];
                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  gameTrailers.length,
                                                  (gameTrailersIndex) {
                                                final gameTrailersItem =
                                                    gameTrailers[
                                                        gameTrailersIndex];
                                                return FutureBuilder<
                                                    ApiCallResponse>(
                                                  future:
                                                      GetMoviesOfaGameRAWGCall
                                                          .call(),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 40,
                                                          height: 40,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color:
                                                                FlutterFlowTheme
                                                                    .primaryColor,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    final videoPlayerGetMoviesOfaGameRAWGResponse =
                                                        snapshot.data;
                                                    return FlutterFlowVideoPlayer(
                                                      path: getJsonField(
                                                        videoPlayerGetMoviesOfaGameRAWGResponse
                                                            .jsonBody,
                                                        r'''$.results''',
                                                      ),
                                                      videoType:
                                                          VideoType.network,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.9,
                                                      autoPlay: false,
                                                      looping: true,
                                                      showControls: true,
                                                      allowFullScreen: true,
                                                      allowPlaybackSpeedMenu:
                                                          false,
                                                    );
                                                  },
                                                );
                                              }),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
