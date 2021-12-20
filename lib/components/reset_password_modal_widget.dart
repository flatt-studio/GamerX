import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordModalWidget extends StatefulWidget {
  const ResetPasswordModalWidget({Key key}) : super(key: key);

  @override
  _ResetPasswordModalWidgetState createState() =>
      _ResetPasswordModalWidgetState();
}

class _ResetPasswordModalWidgetState extends State<ResetPasswordModalWidget> {
  TextEditingController textController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
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
                    'Reset Password',
                    style: FlutterFlowTheme.title3.override(
                      fontFamily: 'Roboto',
                      color: FlutterFlowTheme.secondaryColor,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close_outlined,
                      color: FlutterFlowTheme.secondaryColor,
                      size: 24,
                    ),
                  ),
                ],
              ),
              Divider(
                height: 20,
                thickness: 1,
                color: FlutterFlowTheme.customColor3,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Please enter your email address, we will send a reset link to your email, then follow the instruction on the email',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Roboto',
                          color: FlutterFlowTheme.secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: textController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Email address',
                          labelStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Roboto',
                            color: FlutterFlowTheme.secondaryColor,
                          ),
                          hintText: 'email@example.com',
                          hintStyle: FlutterFlowTheme.bodyText2.override(
                            fontFamily: 'Roboto',
                            color: FlutterFlowTheme.customColor1,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.customColor3,
                              width: 2,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.customColor3,
                              width: 2,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: FlutterFlowTheme.customColor3,
                            size: 18,
                          ),
                        ),
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Roboto',
                          color: FlutterFlowTheme.secondaryColor,
                        ),
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Input Currect Email Address';
                          }

                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(),
                  child: FFButtonWidget(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    text: 'Send Reset Password Link',
                    options: FFButtonOptions(
                      width: 130,
                      height: 44,
                      color: FlutterFlowTheme.primaryColor,
                      textStyle: FlutterFlowTheme.subtitle1,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 6,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
