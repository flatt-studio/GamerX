import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyFavWidget extends StatefulWidget {
  const EmptyFavWidget({Key key}) : super(key: key);

  @override
  _EmptyFavWidgetState createState() => _EmptyFavWidgetState();
}

class _EmptyFavWidgetState extends State<EmptyFavWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.secondaryColor,
      ),
      alignment: AlignmentDirectional(0, 0),
      child: Align(
        alignment: AlignmentDirectional(0, 0),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No favorites found!',
                    style: FlutterFlowTheme.title2,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Once you favorite a game, you’ll see them here!',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Roboto',
                        color: FlutterFlowTheme.customColor3,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                child: Icon(
                  Icons.favorite_border_sharp,
                  color: FlutterFlowTheme.customColor2,
                  size: 56,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
