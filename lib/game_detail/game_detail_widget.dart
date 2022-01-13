import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../components/add_to_console_modal_widget.dart';
import '../flutter_flow/flutter_flow_expanded_image_view.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
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
                                      10, 40, 20, 0),
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
                                          buttonSize: 40,
                                          fillColor: Color(0xFF090F13),
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
                                          buttonSize: 40,
                                          fillColor: Color(0xFF090F13),
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
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 9, 0, 0),
                                    child: FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 30,
                                      buttonSize: 40,
                                      fillColor: Color(0xFF090F13),
                                      icon: Icon(
                                        Icons.arrow_back_rounded,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                    ),
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
                                                      fontFamily: 'Lato',
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
                                                      fontFamily: 'Lato',
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
                      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            getJsonField(
                              gameDetailGetaGameResponse.jsonBody,
                              r'''$.name''',
                            ).toString().maybeHandleOverflow(
                                  maxChars: 30,
                                  replacement: '…',
                                ),
                            style: FlutterFlowTheme.title3,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                      child: Builder(
                        builder: (context) {
                          final platforms = getJsonField(
                                gameDetailGetaGameResponse.jsonBody,
                                r'''$.platforms[:].platform''',
                              )?.toList() ??
                              [];
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(platforms.length,
                                  (platformsIndex) {
                                final platformsItem = platforms[platformsIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 4, 0),
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Container(
                                      height: 25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: FlutterFlowTheme.tertiaryColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 4, 4, 4),
                                        child: Text(
                                          getJsonField(
                                            platformsItem,
                                            r'''$.name''',
                                          ).toString().maybeHandleOverflow(
                                                maxChars: 60,
                                                replacement: '…',
                                              ),
                                          style: FlutterFlowTheme.bodyText1,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          );
                        },
                      ),
                    ),
                    if ((gameDetailGetaGameResponse.succeeded) ==
                        (gameDetailGetaGameResponse.succeeded))
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                        child: Builder(
                          builder: (context) {
                            final platformStores = getJsonField(
                                  gameDetailGetaGameResponse.jsonBody,
                                  r'''$.stores[:]''',
                                )?.toList() ??
                                [];
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: List.generate(platformStores.length,
                                    (platformStoresIndex) {
                                  final platformStoresItem =
                                      platformStores[platformStoresIndex];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 4, 0),
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Container(
                                        height: 25,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Color(0xFF2094F3),
                                            width: 2,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4, 4, 4, 4),
                                          child: Text(
                                            getJsonField(
                                              platformStoresItem,
                                              r'''$.store.name''',
                                            ).toString().maybeHandleOverflow(
                                                  maxChars: 60,
                                                  replacement: '…',
                                                ),
                                            style: FlutterFlowTheme.bodyText1
                                                .override(
                                              fontFamily: 'Roboto',
                                              color: Color(0xFF2094F3),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            );
                          },
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
                                    'ESRB',
                                    style: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Lato',
                                      color: Color(0xFF8B97A2),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 4),
                                  child: Text(
                                    getJsonField(
                                      gameDetailGetaGameResponse.jsonBody,
                                      r'''$.esrb_rating.name''',
                                    ).toString(),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.bodyText1,
                                  ),
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
                                    'Genres',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Lato',
                                      color: Color(0xFF8B97A2),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 4),
                                  child: Text(
                                    getJsonField(
                                      gameDetailGetaGameResponse.jsonBody,
                                      r'''$.genres[:0].name''',
                                    ).toString(),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.bodyText1,
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
                                    'Metacritics',
                                    style: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Lato',
                                      color: Color(0xFF8B97A2),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 4),
                                  child: Text(
                                    getJsonField(
                                      gameDetailGetaGameResponse.jsonBody,
                                      r'''$.metacritic''',
                                    ).toString(),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.bodyText1,
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
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              child: Container(
                                width: double.infinity,
                                color: Color(0x00000000),
                                child: ExpandableNotifier(
                                  initialExpanded: false,
                                  child: ExpandablePanel(
                                    header: Text(
                                      'Description',
                                      style:
                                          FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFF8B97A2),
                                        fontSize: 14,
                                      ),
                                    ),
                                    collapsed: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(),
                                      child: Text(
                                        getJsonField(
                                          gameDetailGetaGameResponse.jsonBody,
                                          r'''$.description_raw''',
                                        ).toString().maybeHandleOverflow(
                                              maxChars: 80,
                                              replacement: '…',
                                            ),
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Roboto',
                                          color: FlutterFlowTheme.tertiaryColor,
                                        ),
                                      ),
                                    ),
                                    expanded: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            getJsonField(
                                              gameDetailGetaGameResponse
                                                  .jsonBody,
                                              r'''$.description_raw''',
                                            ).toString(),
                                            style: FlutterFlowTheme.bodyText1
                                                .override(
                                              fontFamily: 'Roboto',
                                              color: FlutterFlowTheme
                                                  .tertiaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    theme: ExpandableThemeData(
                                      tapHeaderToExpand: true,
                                      tapBodyToExpand: true,
                                      tapBodyToCollapse: true,
                                      headerAlignment:
                                          ExpandablePanelHeaderAlignment.center,
                                      hasIcon: true,
                                      expandIcon: Icons.arrow_drop_up,
                                      collapseIcon: Icons.arrow_drop_down,
                                      iconSize: 24,
                                      iconColor: FlutterFlowTheme.tertiaryColor,
                                      iconPadding:
                                          EdgeInsets.fromLTRB(0, 0, 8, 8),
                                    ),
                                  ),
                                ),
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
                                                            allowRotation: true,
                                                            useHeroAnimation:
                                                                false,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: CachedNetworkImage(
                                                        imageUrl: getJsonField(
                                                          screenShotItem,
                                                          r'''$.image''',
                                                        ),
                                                        width: 250,
                                                        height: 140,
                                                        fit: BoxFit.cover,
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
