import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../consoles/consoles_widget.dart';
import '../favorites/favorites_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../game_detail/game_detail_widget.dart';
import '../gamelist/gamelist_widget.dart';
import '../login/login_widget.dart';
import '../profile/profile_widget.dart';
import '../search/search_widget.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  PageController pageViewController;
  double ratingBarValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
        List<UsersRecord> homePageUsersRecordList = snapshot.data;
        final homePageUsersRecord = homePageUsersRecordList.isNotEmpty
            ? homePageUsersRecordList.first
            : null;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.secondaryColor,
          drawer: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Drawer(
              elevation: 50,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1,
                decoration: BoxDecoration(
                  color: Color(0xFF0E151C),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () async {
                              if (scaffoldKey.currentState.isDrawerOpen ||
                                  scaffoldKey.currentState.isEndDrawerOpen) {
                                Navigator.pop(context);
                              }
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: FlutterFlowTheme.customColor3,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Stack(
                              alignment:
                                  AlignmentDirectional(0.6499999999999999, 1),
                              children: [
                                Container(
                                  width: 85,
                                  height: 85,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: FlutterFlowTheme.tertiaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: Container(
                                    width: 85,
                                    height: 85,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      'assets/images/avatar.png',
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  elevation: 15,
                                  shape: const CircleBorder(),
                                  child: Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.primaryColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: FlutterFlowTheme.tertiaryColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AuthUserStreamWidget(
                                        child: Text(
                                          currentUserDisplayName,
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Roboto',
                                            color:
                                                FlutterFlowTheme.customColor1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
                                        child: Text(
                                          currentUserEmail,
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Roboto',
                                            color:
                                                FlutterFlowTheme.customColor1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 40,
                      thickness: 1,
                      color: Color(0x4D8E8E8E),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(30, 0, 20, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePageWidget(),
                                  ),
                                  (r) => false,
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.home_filled,
                                    color: FlutterFlowTheme.customColor3,
                                    size: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 0, 0),
                                    child: Text(
                                      'Home',
                                      style:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Roboto',
                                        color: FlutterFlowTheme.customColor3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FavoritesWidget(),
                                  ),
                                  (r) => false,
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.favorite_border,
                                    color: FlutterFlowTheme.customColor3,
                                    size: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 0, 0),
                                    child: Text(
                                      'Favorites',
                                      style:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Roboto',
                                        color: FlutterFlowTheme.customColor3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ConsolesWidget(),
                                  ),
                                  (r) => false,
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.settings_system_daydream,
                                    color: FlutterFlowTheme.customColor3,
                                    size: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 0, 0),
                                    child: Text(
                                      'Collections',
                                      style:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Roboto',
                                        color: FlutterFlowTheme.customColor3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileWidget(),
                                  ),
                                  (r) => false,
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.person_outline,
                                    color: FlutterFlowTheme.customColor3,
                                    size: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 0, 0),
                                    child: Text(
                                      'Profile',
                                      style:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Roboto',
                                        color: FlutterFlowTheme.customColor3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                            child: InkWell(
                              onTap: () async {
                                await signOut();
                                await Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginWidget(),
                                  ),
                                  (r) => false,
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.power_settings_new_sharp,
                                    color: Color(0xFFFF0000),
                                    size: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 0, 0),
                                    child: Text(
                                      'Logout',
                                      style:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFFFF0000),
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
                  ],
                ),
              ),
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FutureBuilder<ApiCallResponse>(
                        future: GetThreeGamesRAWGCall.call(),
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
                          final pageViewGetThreeGamesRAWGResponse =
                              snapshot.data;
                          return Builder(
                            builder: (context) {
                              final results = (getJsonField(
                                        pageViewGetThreeGamesRAWGResponse
                                            .jsonBody,
                                        r'''$.results''',
                                      )?.toList() ??
                                      [])
                                  .take(3)
                                  .toList();
                              return Container(
                                width: double.infinity,
                                height: 350,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 50),
                                      child: PageView.builder(
                                        controller: pageViewController ??=
                                            PageController(
                                                initialPage:
                                                    min(0, results.length - 1)),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: results.length,
                                        itemBuilder: (context, resultsIndex) {
                                          final resultsItem =
                                              results[resultsIndex];
                                          return InkWell(
                                            onTap: () async {
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      GameDetailWidget(
                                                    gameId: getJsonField(
                                                      resultsItem,
                                                      r'''$.id''',
                                                    ).toString(),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Stack(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: getJsonField(
                                                    resultsItem,
                                                    r'''$.background_image''',
                                                  ),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 400,
                                                  fit: BoxFit.cover,
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0.95),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                20, 0, 20, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            getJsonField(
                                                              resultsItem,
                                                              r'''$.name''',
                                                            )
                                                                .toString()
                                                                .maybeHandleOverflow(
                                                                  maxChars: 25,
                                                                  replacement:
                                                                      '…',
                                                                ),
                                                            style:
                                                                FlutterFlowTheme
                                                                    .title1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-0.87, 0.9),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 10),
                                        child: SmoothPageIndicator(
                                          controller: pageViewController ??=
                                              PageController(
                                                  initialPage: min(
                                                      0, results.length - 1)),
                                          count: results.length,
                                          axisDirection: Axis.horizontal,
                                          onDotClicked: (i) {
                                            pageViewController.animateToPage(
                                              i,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.ease,
                                            );
                                          },
                                          effect: SlideEffect(
                                            spacing: 5,
                                            radius: 16,
                                            dotWidth: 8,
                                            dotHeight: 8,
                                            dotColor:
                                                FlutterFlowTheme.tertiaryColor,
                                            activeDotColor:
                                                FlutterFlowTheme.primaryColor,
                                            paintStyle: PaintingStyle.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Popular Games',
                                    style: FlutterFlowTheme.bodyText1,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'More',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Roboto',
                                          color: FlutterFlowTheme.customColor3,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: FlutterFlowTheme.customColor3,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 230,
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: FutureBuilder<ApiCallResponse>(
                                    future: GetPopularGamesRAWGCall.call(),
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
                                      final rowGetPopularGamesRAWGResponse =
                                          snapshot.data;
                                      return Builder(
                                        builder: (context) {
                                          final popularGame = (getJsonField(
                                                    rowGetPopularGamesRAWGResponse
                                                        .jsonBody,
                                                    r'''$.results''',
                                                  )?.toList() ??
                                                  [])
                                              .take(30)
                                              .toList();
                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  popularGame.length,
                                                  (popularGameIndex) {
                                                final popularGameItem =
                                                    popularGame[
                                                        popularGameIndex];
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(5, 5, 5, 5),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              GameDetailWidget(
                                                            gameId:
                                                                getJsonField(
                                                              popularGameItem,
                                                              r'''$.id''',
                                                            ).toString(),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 125,
                                                      height: 205,
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 3,
                                                            color: Color(
                                                                0x4C000000),
                                                            offset:
                                                                Offset(0, 4),
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl:
                                                                      getJsonField(
                                                                    popularGameItem,
                                                                    r'''$.background_image''',
                                                                  ),
                                                                  width: 125,
                                                                  height: 165,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            10,
                                                                            10,
                                                                            0),
                                                                child: Builder(
                                                                  builder:
                                                                      (context) {
                                                                    final platform =
                                                                        getJsonField(
                                                                              popularGameItem,
                                                                              r'''$.platforms''',
                                                                            )?.toList() ??
                                                                            [];
                                                                    return Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: List.generate(
                                                                          platform
                                                                              .length,
                                                                          (platformIndex) {
                                                                        final platformItem =
                                                                            platform[platformIndex];
                                                                        return FutureBuilder<
                                                                            ApiCallResponse>(
                                                                          future:
                                                                              GetPlatformsOfaGameRAWGCall.call(
                                                                            platformNumber:
                                                                                getJsonField(
                                                                              platformItem,
                                                                              r'''$.id''',
                                                                            ).toString(),
                                                                          ),
                                                                          builder:
                                                                              (context, snapshot) {
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
                                                                            final imageGetPlatformsOfaGameRAWGResponse =
                                                                                snapshot.data;
                                                                            return CachedNetworkImage(
                                                                              imageUrl: functions.platformLogo(getJsonField(
                                                                                imageGetPlatformsOfaGameRAWGResponse.jsonBody,
                                                                                r'''$.name''',
                                                                              ).toString()),
                                                                              width: 20,
                                                                              height: 20,
                                                                              fit: BoxFit.cover,
                                                                            );
                                                                          },
                                                                        );
                                                                      }),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    if (!(functions.isItemInFav(
                                                                            getJsonField(
                                                                              popularGameItem,
                                                                              r'''$.id''',
                                                                            ).toString(),
                                                                            homePageUsersRecord)) ??
                                                                        true)
                                                                      FlutterFlowIconButton(
                                                                        borderColor:
                                                                            Colors.transparent,
                                                                        borderRadius:
                                                                            30,
                                                                        borderWidth:
                                                                            1,
                                                                        buttonSize:
                                                                            44,
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .favorite_border,
                                                                          color:
                                                                              FlutterFlowTheme.tertiaryColor,
                                                                          size:
                                                                              24,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          final usersUpdateData =
                                                                              {
                                                                            'favoriteList':
                                                                                FieldValue.arrayUnion([
                                                                              getJsonField(
                                                                                popularGameItem,
                                                                                r'''$.id''',
                                                                              ).toString()
                                                                            ]),
                                                                          };
                                                                          await currentUserReference
                                                                              .update(usersUpdateData);
                                                                        },
                                                                      ),
                                                                    if (functions.isItemInFav(
                                                                            getJsonField(
                                                                              popularGameItem,
                                                                              r'''$.id''',
                                                                            ).toString(),
                                                                            homePageUsersRecord) ??
                                                                        true)
                                                                      FlutterFlowIconButton(
                                                                        borderColor:
                                                                            Colors.transparent,
                                                                        borderRadius:
                                                                            30,
                                                                        borderWidth:
                                                                            1,
                                                                        buttonSize:
                                                                            44,
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .favorite_sharp,
                                                                          color:
                                                                              Color(0xFFFF0000),
                                                                          size:
                                                                              24,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          final usersUpdateData =
                                                                              {
                                                                            'favoriteList':
                                                                                FieldValue.arrayRemove([
                                                                              getJsonField(
                                                                                popularGameItem,
                                                                                r'''$.id''',
                                                                              ).toString()
                                                                            ]),
                                                                          };
                                                                          await currentUserReference
                                                                              .update(usersUpdateData);
                                                                        },
                                                                      ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            height: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0x80EEEEEE),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5,
                                                                          5,
                                                                          5,
                                                                          5),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Expanded(
                                                                                child: Text(
                                                                                  getJsonField(
                                                                                    popularGameItem,
                                                                                    r'''$.name''',
                                                                                  ).toString().maybeHandleOverflow(
                                                                                        maxChars: 18,
                                                                                        replacement: '…',
                                                                                      ),
                                                                                  style: FlutterFlowTheme.bodyText1.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    color: FlutterFlowTheme.secondaryColor,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        RatingBar
                                                                            .builder(
                                                                          onRatingUpdate: (newValue) =>
                                                                              setState(() => ratingBarValue = newValue),
                                                                          itemBuilder: (context, index) =>
                                                                              Icon(
                                                                            Icons.star_rounded,
                                                                            color:
                                                                                Color(0xFFFFA100),
                                                                          ),
                                                                          direction:
                                                                              Axis.horizontal,
                                                                          initialRating: ratingBarValue ??=
                                                                              getJsonField(
                                                                            popularGameItem,
                                                                            r'''$.rating''',
                                                                          ),
                                                                          unratedColor:
                                                                              Color(0x80000000),
                                                                          itemCount:
                                                                              5,
                                                                          itemSize:
                                                                              16,
                                                                          glowColor:
                                                                              Color(0xFFFFA100),
                                                                        ),
                                                                      ],
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
                                                );
                                              }),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 0, 20, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Featured Games',
                                      style: FlutterFlowTheme.bodyText1,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'More',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Roboto',
                                            color:
                                                FlutterFlowTheme.customColor3,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: FlutterFlowTheme.customColor3,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 10, 0, 0),
                                    child: FutureBuilder<ApiCallResponse>(
                                      future: GetReleasedGamesRAWGCall.call(),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: CircularProgressIndicator(
                                                color: FlutterFlowTheme
                                                    .primaryColor,
                                              ),
                                            ),
                                          );
                                        }
                                        final rowGetReleasedGamesRAWGResponse =
                                            snapshot.data;
                                        return Builder(
                                          builder: (context) {
                                            final releasedGame = (getJsonField(
                                                      rowGetReleasedGamesRAWGResponse
                                                          .jsonBody,
                                                      r'''$.results''',
                                                    )?.toList() ??
                                                    [])
                                                .take(30)
                                                .toList();
                                            return SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                    releasedGame.length,
                                                    (releasedGameIndex) {
                                                  final releasedGameItem =
                                                      releasedGame[
                                                          releasedGameIndex];
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 20, 10),
                                                    child: InkWell(
                                                      onTap: () async {
                                                        await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                GameDetailWidget(
                                                              gameId:
                                                                  getJsonField(
                                                                releasedGameItem,
                                                                r'''$.id''',
                                                              ).toString(),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        height: 145,
                                                        decoration:
                                                            BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 3,
                                                              color: Color(
                                                                  0x4D000000),
                                                              offset:
                                                                  Offset(0, 4),
                                                            )
                                                          ],
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                getJsonField(
                                                              releasedGameItem,
                                                              r'''$.background_image''',
                                                            ),
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.9,
                                                            height: 145,
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
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 44,
                        icon: Icon(
                          Icons.menu,
                          color: FlutterFlowTheme.tertiaryColor,
                          size: 24,
                        ),
                        onPressed: () async {
                          scaffoldKey.currentState.openDrawer();
                        },
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 44,
                            icon: Icon(
                              Icons.search_outlined,
                              color: FlutterFlowTheme.tertiaryColor,
                              size: 24,
                            ),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchWidget(),
                                ),
                              );
                            },
                          ),
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 44,
                            icon: Icon(
                              Icons.games_sharp,
                              color: FlutterFlowTheme.tertiaryColor,
                              size: 24,
                            ),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GamelistWidget(),
                                ),
                              );
                              setState(() =>
                                  FFAppState().apiCallParams = 'platforms=1');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
