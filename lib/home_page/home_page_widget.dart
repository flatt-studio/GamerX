import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../consoles/consoles_widget.dart';
import '../favorites/favorites_widget.dart';
import '../flutter_flow/flutter_flow_animations.dart';
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
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  PageController pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      curve: Curves.easeIn,
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      fadeIn: true,
      initialState: AnimationState(
        offset: Offset(0, 0),
        scale: 1.2,
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        scale: 1,
        opacity: 1,
      ),
    ),
  };

  @override
  void initState() {
    super.initState();
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
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
                          InkWell(
                            onTap: () async {
                              await Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePageWidget(),
                                ),
                                (r) => false,
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 44,
                              decoration: BoxDecoration(),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.home_filled,
                                    color: FlutterFlowTheme.customColor1,
                                    size: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 0, 0),
                                    child: Text(
                                      'Home',
                                      style:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Lato',
                                        color: FlutterFlowTheme.customColor3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 44,
                            decoration: BoxDecoration(),
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
                                    color: FlutterFlowTheme.customColor1,
                                    size: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 0, 0),
                                    child: Text(
                                      'Favorites',
                                      style:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Lato',
                                        color: FlutterFlowTheme.customColor3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 44,
                            decoration: BoxDecoration(),
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
                                    color: FlutterFlowTheme.customColor1,
                                    size: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 0, 0),
                                    child: Text(
                                      'Collections',
                                      style:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Lato',
                                        color: FlutterFlowTheme.customColor3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 44,
                            decoration: BoxDecoration(),
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
                                    color: FlutterFlowTheme.customColor1,
                                    size: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 0, 0),
                                    child: Text(
                                      'Profile',
                                      style:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Lato',
                                        color: FlutterFlowTheme.customColor3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 44,
                            decoration: BoxDecoration(),
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
                                        fontFamily: 'Lato',
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
                                        (pageViewGetThreeGamesRAWGResponse
                                                ?.jsonBody ??
                                            ''),
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
                        height: 270,
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
                                                  (rowGetPopularGamesRAWGResponse
                                                          ?.jsonBody ??
                                                      ''),
                                                  r'''$.results''',
                                                )?.toList() ??
                                                [])
                                            .take(10)
                                            .toList();
                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: List.generate(
                                                popularGame.length,
                                                (popularGameIndex) {
                                              final popularGameItem =
                                                  popularGame[popularGameIndex];
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
                                                          gameId: getJsonField(
                                                            popularGameItem,
                                                            r'''$.id''',
                                                          ).toString(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    elevation: 3,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Container(
                                                      width: 125,
                                                      height: 210,
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
                                                                .circular(8),
                                                        border: Border.all(
                                                          color:
                                                              FlutterFlowTheme
                                                                  .customColor1,
                                                          width: 2,
                                                        ),
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
                                                                          8),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          8),
                                                                ),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl:
                                                                      getJsonField(
                                                                    popularGameItem,
                                                                    r'''$.background_image''',
                                                                  ),
                                                                  width: double
                                                                      .infinity,
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
                                                                            4,
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
                                                                            34,
                                                                        fillColor:
                                                                            FlutterFlowTheme.secondaryColor,
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .favorite_border,
                                                                          color:
                                                                              FlutterFlowTheme.tertiaryColor,
                                                                          size:
                                                                              18,
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
                                                                            34,
                                                                        fillColor:
                                                                            FlutterFlowTheme.secondaryColor,
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .favorite_sharp,
                                                                          color:
                                                                              Color(0xFFFF0000),
                                                                          size:
                                                                              18,
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
                                                                  0x7F1D448A),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        8),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            8),
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
                                                                                    color: FlutterFlowTheme.tertiaryColor,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Text(
                                                                              getJsonField(
                                                                                popularGameItem,
                                                                                r'''$..genres..name''',
                                                                              ).toString().maybeHandleOverflow(
                                                                                    maxChars: 18,
                                                                                    replacement: '…',
                                                                                  ),
                                                                              style: FlutterFlowTheme.bodyText1,
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
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ).animated([
                                                  animationsMap[
                                                      'containerOnPageLoadAnimation']
                                                ]),
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
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 320,
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: DefaultTabController(
                                length: 2,
                                initialIndex: 0,
                                child: Column(
                                  children: [
                                    TabBar(
                                      labelColor:
                                          FlutterFlowTheme.tertiaryColor,
                                      labelStyle: FlutterFlowTheme.bodyText1,
                                      indicatorColor:
                                          FlutterFlowTheme.secondaryColor,
                                      tabs: [
                                        Tab(
                                          text: 'New Releases',
                                        ),
                                        Tab(
                                          text: 'Up Coming',
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(15, 0, 0, 0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 230,
                                                  decoration: BoxDecoration(),
                                                  child: FutureBuilder<
                                                      ApiCallResponse>(
                                                    future:
                                                        GetReleasedGamesRAWGCall
                                                            .call(),
                                                    builder:
                                                        (context, snapshot) {
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
                                                      final columnGetReleasedGamesRAWGResponse =
                                                          snapshot.data;
                                                      return Builder(
                                                        builder: (context) {
                                                          final releasedGame =
                                                              (getJsonField(
                                                                        (columnGetReleasedGamesRAWGResponse?.jsonBody ??
                                                                            ''),
                                                                        r'''$.results''',
                                                                      )?.toList() ??
                                                                      [])
                                                                  .take(10)
                                                                  .toList();
                                                          return SingleChildScrollView(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: List.generate(
                                                                  releasedGame
                                                                      .length,
                                                                  (releasedGameIndex) {
                                                                final releasedGameItem =
                                                                    releasedGame[
                                                                        releasedGameIndex];
                                                                return Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          5,
                                                                          0,
                                                                          5),
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      await Navigator
                                                                          .push(
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
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      elevation:
                                                                          3,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        height:
                                                                            75,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0x7F1D448A),
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              blurRadius: 5,
                                                                              color: Color(0x3F000000),
                                                                              offset: Offset(0, 2),
                                                                            )
                                                                          ],
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                FlutterFlowTheme.customColor1,
                                                                            width:
                                                                                2,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            ClipRRect(
                                                                              borderRadius: BorderRadius.only(
                                                                                bottomLeft: Radius.circular(10),
                                                                                bottomRight: Radius.circular(0),
                                                                                topLeft: Radius.circular(10),
                                                                                topRight: Radius.circular(0),
                                                                              ),
                                                                              child: CachedNetworkImage(
                                                                                imageUrl: getJsonField(
                                                                                  releasedGameItem,
                                                                                  r'''$.background_image''',
                                                                                ),
                                                                                width: 100,
                                                                                height: 75,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 10),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Expanded(
                                                                                          child: Text(
                                                                                            getJsonField(
                                                                                              releasedGameItem,
                                                                                              r'''$.name''',
                                                                                            ).toString().maybeHandleOverflow(
                                                                                                  maxChars: 20,
                                                                                                  replacement: '…',
                                                                                                ),
                                                                                            style: FlutterFlowTheme.title3.override(
                                                                                              fontFamily: 'Playfair Display',
                                                                                              color: FlutterFlowTheme.tertiaryColor,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Text(
                                                                                          getJsonField(
                                                                                            releasedGameItem,
                                                                                            r'''$.released''',
                                                                                          ).toString().maybeHandleOverflow(
                                                                                                maxChars: 18,
                                                                                                replacement: '…',
                                                                                              ),
                                                                                          style: FlutterFlowTheme.bodyText1,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 4, 0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  if (!(functions.isItemInFav(
                                                                                          getJsonField(
                                                                                            releasedGameItem,
                                                                                            r'''$.id''',
                                                                                          ).toString(),
                                                                                          homePageUsersRecord)) ??
                                                                                      true)
                                                                                    FlutterFlowIconButton(
                                                                                      borderColor: Colors.transparent,
                                                                                      borderRadius: 30,
                                                                                      borderWidth: 1,
                                                                                      buttonSize: 34,
                                                                                      fillColor: FlutterFlowTheme.secondaryColor,
                                                                                      icon: Icon(
                                                                                        Icons.favorite_border,
                                                                                        color: FlutterFlowTheme.tertiaryColor,
                                                                                        size: 18,
                                                                                      ),
                                                                                      onPressed: () async {
                                                                                        final usersUpdateData = {
                                                                                          'favoriteList': FieldValue.arrayUnion([
                                                                                            getJsonField(
                                                                                              releasedGameItem,
                                                                                              r'''$.id''',
                                                                                            ).toString()
                                                                                          ]),
                                                                                        };
                                                                                        await currentUserReference.update(usersUpdateData);
                                                                                      },
                                                                                    ),
                                                                                  if (functions.isItemInFav(
                                                                                          getJsonField(
                                                                                            releasedGameItem,
                                                                                            r'''$.id''',
                                                                                          ).toString(),
                                                                                          homePageUsersRecord) ??
                                                                                      true)
                                                                                    FlutterFlowIconButton(
                                                                                      borderColor: Colors.transparent,
                                                                                      borderRadius: 30,
                                                                                      borderWidth: 1,
                                                                                      buttonSize: 34,
                                                                                      fillColor: FlutterFlowTheme.secondaryColor,
                                                                                      icon: Icon(
                                                                                        Icons.favorite_sharp,
                                                                                        color: Color(0xFFFF0000),
                                                                                        size: 18,
                                                                                      ),
                                                                                      onPressed: () async {
                                                                                        final usersUpdateData = {
                                                                                          'favoriteList': FieldValue.arrayRemove([
                                                                                            getJsonField(
                                                                                              releasedGameItem,
                                                                                              r'''$.id''',
                                                                                            ).toString()
                                                                                          ]),
                                                                                        };
                                                                                        await currentUserReference.update(usersUpdateData);
                                                                                      },
                                                                                    ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
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
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(15, 0, 0, 0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 230,
                                                  decoration: BoxDecoration(),
                                                  child: FutureBuilder<
                                                      ApiCallResponse>(
                                                    future:
                                                        GetUpcomingGamesRAWGCall
                                                            .call(),
                                                    builder:
                                                        (context, snapshot) {
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
                                                      final columnGetUpcomingGamesRAWGResponse =
                                                          snapshot.data;
                                                      return Builder(
                                                        builder: (context) {
                                                          final upcomingGame =
                                                              (getJsonField(
                                                                        (columnGetUpcomingGamesRAWGResponse?.jsonBody ??
                                                                            ''),
                                                                        r'''$.results''',
                                                                      )?.toList() ??
                                                                      [])
                                                                  .take(10)
                                                                  .toList();
                                                          return SingleChildScrollView(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: List.generate(
                                                                  upcomingGame
                                                                      .length,
                                                                  (upcomingGameIndex) {
                                                                final upcomingGameItem =
                                                                    upcomingGame[
                                                                        upcomingGameIndex];
                                                                return Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          5,
                                                                          0,
                                                                          5),
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      await Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              GameDetailWidget(
                                                                            gameId:
                                                                                getJsonField(
                                                                              upcomingGameItem,
                                                                              r'''$.id''',
                                                                            ).toString(),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      elevation:
                                                                          3,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        height:
                                                                            75,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0x7F1D448A),
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              blurRadius: 5,
                                                                              color: Color(0x3F000000),
                                                                              offset: Offset(0, 2),
                                                                            )
                                                                          ],
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                FlutterFlowTheme.customColor1,
                                                                            width:
                                                                                2,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            ClipRRect(
                                                                              borderRadius: BorderRadius.only(
                                                                                bottomLeft: Radius.circular(10),
                                                                                bottomRight: Radius.circular(0),
                                                                                topLeft: Radius.circular(10),
                                                                                topRight: Radius.circular(0),
                                                                              ),
                                                                              child: CachedNetworkImage(
                                                                                imageUrl: getJsonField(
                                                                                  upcomingGameItem,
                                                                                  r'''$.background_image''',
                                                                                ),
                                                                                width: 100,
                                                                                height: 75,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 10),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Expanded(
                                                                                          child: Text(
                                                                                            getJsonField(
                                                                                              upcomingGameItem,
                                                                                              r'''$.name''',
                                                                                            ).toString().maybeHandleOverflow(
                                                                                                  maxChars: 20,
                                                                                                  replacement: '…',
                                                                                                ),
                                                                                            style: FlutterFlowTheme.title3.override(
                                                                                              fontFamily: 'Playfair Display',
                                                                                              color: FlutterFlowTheme.tertiaryColor,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Text(
                                                                                          getJsonField(
                                                                                            upcomingGameItem,
                                                                                            r'''$.released''',
                                                                                          ).toString().maybeHandleOverflow(
                                                                                                maxChars: 18,
                                                                                                replacement: '…',
                                                                                              ),
                                                                                          style: FlutterFlowTheme.bodyText1,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 4, 0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  if (!(functions.isItemInFav(
                                                                                          getJsonField(
                                                                                            upcomingGameItem,
                                                                                            r'''$.id''',
                                                                                          ).toString(),
                                                                                          homePageUsersRecord)) ??
                                                                                      true)
                                                                                    FlutterFlowIconButton(
                                                                                      borderColor: Colors.transparent,
                                                                                      borderRadius: 30,
                                                                                      borderWidth: 1,
                                                                                      buttonSize: 34,
                                                                                      fillColor: FlutterFlowTheme.secondaryColor,
                                                                                      icon: Icon(
                                                                                        Icons.favorite_border,
                                                                                        color: FlutterFlowTheme.tertiaryColor,
                                                                                        size: 18,
                                                                                      ),
                                                                                      onPressed: () async {
                                                                                        final usersUpdateData = {
                                                                                          'favoriteList': FieldValue.arrayUnion([
                                                                                            getJsonField(
                                                                                              upcomingGameItem,
                                                                                              r'''$.id''',
                                                                                            ).toString()
                                                                                          ]),
                                                                                        };
                                                                                        await currentUserReference.update(usersUpdateData);
                                                                                      },
                                                                                    ),
                                                                                  if (functions.isItemInFav(
                                                                                          getJsonField(
                                                                                            upcomingGameItem,
                                                                                            r'''$.id''',
                                                                                          ).toString(),
                                                                                          homePageUsersRecord) ??
                                                                                      true)
                                                                                    FlutterFlowIconButton(
                                                                                      borderColor: Colors.transparent,
                                                                                      borderRadius: 30,
                                                                                      borderWidth: 1,
                                                                                      buttonSize: 34,
                                                                                      fillColor: FlutterFlowTheme.secondaryColor,
                                                                                      icon: Icon(
                                                                                        Icons.favorite_sharp,
                                                                                        color: Color(0xFFFF0000),
                                                                                        size: 18,
                                                                                      ),
                                                                                      onPressed: () async {
                                                                                        final usersUpdateData = {
                                                                                          'favoriteList': FieldValue.arrayRemove([
                                                                                            getJsonField(
                                                                                              upcomingGameItem,
                                                                                              r'''$.id''',
                                                                                            ).toString()
                                                                                          ]),
                                                                                        };
                                                                                        await currentUserReference.update(usersUpdateData);
                                                                                      },
                                                                                    ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
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
                                            ],
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
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                          child: FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 40,
                            fillColor: FlutterFlowTheme.secondaryColor,
                            icon: Icon(
                              Icons.notes,
                              color: FlutterFlowTheme.tertiaryColor,
                              size: 24,
                            ),
                            onPressed: () async {
                              scaffoldKey.currentState.openDrawer();
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 9),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                                child: FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30,
                                  borderWidth: 1,
                                  buttonSize: 40,
                                  fillColor: FlutterFlowTheme.secondaryColor,
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
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                                child: FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30,
                                  borderWidth: 1,
                                  buttonSize: 40,
                                  fillColor: FlutterFlowTheme.secondaryColor,
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
                                    setState(() => FFAppState().apiCallParams =
                                        'platforms=1');
                                  },
                                ),
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
        );
      },
    );
  }
}
