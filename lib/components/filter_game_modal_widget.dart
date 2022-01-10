import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterGameModalWidget extends StatefulWidget {
  const FilterGameModalWidget({
    Key key,
    this.gameId,
  }) : super(key: key);

  final String gameId;

  @override
  _FilterGameModalWidgetState createState() => _FilterGameModalWidgetState();
}

class _FilterGameModalWidgetState extends State<FilterGameModalWidget> {
  String dropDownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1,
      decoration: BoxDecoration(
        color: Color(0xFFEEEEEE),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sort Games',
                  style: FlutterFlowTheme.title2.override(
                    fontFamily: 'Playfair Display',
                    color: FlutterFlowTheme.secondaryColor,
                  ),
                ),
                FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30,
                  borderWidth: 1,
                  buttonSize: 44,
                  icon: Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                    size: 24,
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Divider(
              height: 40,
              thickness: 1,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0.8),
                        child: FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          text: 'Apply Filters',
                          icon: Icon(
                            Icons.filter_alt,
                            size: 15,
                          ),
                          options: FFButtonOptions(
                            width: 185,
                            height: 60,
                            color: FlutterFlowTheme.customColor1,
                            textStyle: FlutterFlowTheme.subtitle2.override(
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
                ),
                FlutterFlowDropDown(
                  options: ['Option 1'].toList(),
                  onChanged: (val) => setState(() => dropDownValue = val),
                  width: 180,
                  height: 50,
                  textStyle: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Roboto',
                    color: Colors.black,
                  ),
                  fillColor: Colors.white,
                  elevation: 2,
                  borderColor: Colors.transparent,
                  borderWidth: 0,
                  borderRadius: 0,
                  margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                  hidesUnderline: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
