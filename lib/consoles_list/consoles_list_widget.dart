import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../game_detail/game_detail_widget.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConsolesListWidget extends StatefulWidget {
  const ConsolesListWidget({
    Key key,
    this.consoleID,
  }) : super(key: key);

  final String consoleID;

  @override
  _ConsolesListWidgetState createState() => _ConsolesListWidgetState();
}

class _ConsolesListWidgetState extends State<ConsolesListWidget> {
  TextEditingController searchTextFieldController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    searchTextFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UsersRecord>>(
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
        List<UsersRecord> consolesListUsersRecordList = snapshot.data;
        final consolesListUsersRecord = consolesListUsersRecordList.isNotEmpty
            ? consolesListUsersRecordList.first
            : null;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.secondaryColor,
          body: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          buttonSize: 46,
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          'Consoles Game List',
                          style: FlutterFlowTheme.title2,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (_) => EasyDebounce.debounce(
                              'searchTextFieldController',
                              Duration(milliseconds: 2000),
                              () => setState(() {}),
                            ),
                            controller: searchTextFieldController,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Search games',
                              hintStyle: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Roboto',
                                color: FlutterFlowTheme.secondaryColor,
                                fontSize: 15,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 0,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 0,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: FlutterFlowTheme.tertiaryColor,
                              contentPadding:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                              prefixIcon: Icon(
                                Icons.search,
                                color: FlutterFlowTheme.customColor3,
                                size: 16,
                              ),
                              suffixIcon: searchTextFieldController
                                      .text.isNotEmpty
                                  ? InkWell(
                                      onTap: () => setState(
                                        () => searchTextFieldController.clear(),
                                      ),
                                      child: Icon(
                                        Icons.clear,
                                        color: Color(0xFF757575),
                                        size: 22,
                                      ),
                                    )
                                  : null,
                            ),
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Roboto',
                              color: FlutterFlowTheme.secondaryColor,
                              fontSize: 15,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder<List<ConsolsRecord>>(
                    stream: queryConsolsRecord(
                      queryBuilder: (consolsRecord) => consolsRecord.where('id',
                          isEqualTo: widget.consoleID),
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
                      List<ConsolsRecord> containerConsolsRecordList =
                          snapshot.data;
                      final containerConsolsRecord =
                          containerConsolsRecordList.isNotEmpty
                              ? containerConsolsRecordList.first
                              : null;
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          child: Builder(
                            builder: (context) {
                              final game = containerConsolsRecord.gameList
                                      .toList()
                                      ?.toList() ??
                                  [];
                              return SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children:
                                      List.generate(game.length, (gameIndex) {
                                    final gameItem = game[gameIndex];
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 5, 0, 5),
                                      child: FutureBuilder<ApiCallResponse>(
                                        future: GetaGameCall.call(
                                          id: gameItem,
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
                                          final containerGetaGameResponse =
                                              snapshot.data;
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                            ),
                                            child: Visibility(
                                              visible: functions
                                                      .searchInGamesDatabase(
                                                          searchTextFieldController
                                                              .text,
                                                          getJsonField(
                                                            containerGetaGameResponse
                                                                .jsonBody,
                                                            r'''$.name''',
                                                          ).toString()) ??
                                                  true,
                                              child: InkWell(
                                                onTap: () async {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          GameDetailWidget(
                                                        gameId: gameItem,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme
                                                        .tertiaryColor,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 4,
                                                        color:
                                                            Color(0x43000000),
                                                        offset: Offset(0, 2),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  0),
                                                        ),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              getJsonField(
                                                            containerGetaGameResponse
                                                                .jsonBody,
                                                            r'''$.background_image''',
                                                          ),
                                                          width: 100,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10,
                                                                      10,
                                                                      10,
                                                                      10),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  color: Colors
                                                                      .white,
                                                                  child:
                                                                      ExpandableNotifier(
                                                                    initialExpanded:
                                                                        false,
                                                                    child:
                                                                        ExpandablePanel(
                                                                      header:
                                                                          Text(
                                                                        getJsonField(
                                                                          containerGetaGameResponse
                                                                              .jsonBody,
                                                                          r'''$.name''',
                                                                        ).toString(),
                                                                        style: FlutterFlowTheme
                                                                            .title2
                                                                            .override(
                                                                          fontFamily:
                                                                              'Playfair Display',
                                                                          color:
                                                                              FlutterFlowTheme.secondaryColor,
                                                                        ),
                                                                      ),
                                                                      collapsed:
                                                                          Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        height:
                                                                            40,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0xFFEEEEEE),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              8,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Text(
                                                                            getJsonField(
                                                                              containerGetaGameResponse.jsonBody,
                                                                              r'''$.description_raw''',
                                                                            ).toString().maybeHandleOverflow(
                                                                                  maxChars: 80,
                                                                                  replacement: '…',
                                                                                ),
                                                                            style:
                                                                                FlutterFlowTheme.bodyText1.override(
                                                                              fontFamily: 'Roboto',
                                                                              color: Color(0x8A000000),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      expanded:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Text(
                                                                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                                                            style:
                                                                                FlutterFlowTheme.bodyText1.override(
                                                                              fontFamily: 'Roboto',
                                                                              color: Color(0x8A000000),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                4,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                Image.network(
                                                                              'https://picsum.photos/seed/642/600',
                                                                              width: MediaQuery.of(context).size.width,
                                                                              height: 100,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      theme:
                                                                          ExpandableThemeData(
                                                                        tapHeaderToExpand:
                                                                            true,
                                                                        tapBodyToExpand:
                                                                            false,
                                                                        tapBodyToCollapse:
                                                                            false,
                                                                        headerAlignment:
                                                                            ExpandablePanelHeaderAlignment.center,
                                                                        hasIcon:
                                                                            true,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
