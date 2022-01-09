import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../consoles_list/consoles_list_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddToConsoleModalWidget extends StatefulWidget {
  const AddToConsoleModalWidget({
    Key key,
    this.gameId,
  }) : super(key: key);

  final String gameId;

  @override
  _AddToConsoleModalWidgetState createState() =>
      _AddToConsoleModalWidgetState();
}

class _AddToConsoleModalWidgetState extends State<AddToConsoleModalWidget> {
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
                  'Select Collection',
                  style: FlutterFlowTheme.title2.override(
                    fontFamily: 'Roboto',
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
            StreamBuilder<List<ConsolsRecord>>(
              stream: queryConsolsRecord(),
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
                List<ConsolsRecord> columnConsolsRecordList = snapshot.data;
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(columnConsolsRecordList.length,
                      (columnIndex) {
                    final columnConsolsRecord =
                        columnConsolsRecordList[columnIndex];
                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                      child: InkWell(
                        onTap: () async {
                          final consolsUpdateData = {
                            'gameList': FieldValue.arrayUnion([widget.gameId]),
                          };
                          await columnConsolsRecord.reference
                              .update(consolsUpdateData);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Game Added to collection.',
                                style: TextStyle(),
                              ),
                              duration: Duration(milliseconds: 4000),
                              backgroundColor: Color(0x00000000),
                              action: SnackBarAction(
                                label: 'See Collection',
                                textColor: Color(0x00000000),
                                onPressed: () async {
                                  await Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ConsolesListWidget(
                                        consoleID: columnConsolsRecord.id,
                                      ),
                                    ),
                                    (r) => false,
                                  );
                                },
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CachedNetworkImage(
                                imageUrl: columnConsolsRecord.image,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Text(
                                  columnConsolsRecord.name,
                                  style: FlutterFlowTheme.title2.override(
                                    fontFamily: 'Roboto',
                                    color: FlutterFlowTheme.secondaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
