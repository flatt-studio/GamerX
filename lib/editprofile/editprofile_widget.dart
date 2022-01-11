import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditprofileWidget extends StatefulWidget {
  const EditprofileWidget({
    Key key,
    this.profileEdit,
  }) : super(key: key);

  final DocumentReference profileEdit;

  @override
  _EditprofileWidgetState createState() => _EditprofileWidgetState();
}

class _EditprofileWidgetState extends State<EditprofileWidget> {
  String uploadedFileUrl = '';
  TextEditingController displayNameController;
  TextEditingController emailAddressController;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    displayNameController = TextEditingController(text: currentUserDisplayName);
    emailAddressController = TextEditingController(text: currentUserEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.secondaryColor,
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.secondaryColor,
            ),
            child: Align(
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(40, 0, 40, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional(
                                      0.6499999999999999, 1),
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        final selectedMedia =
                                            await selectMediaWithSourceBottomSheet(
                                          context: context,
                                          allowPhoto: true,
                                        );
                                        if (selectedMedia != null &&
                                            validateFileFormat(
                                                selectedMedia.storagePath,
                                                context)) {
                                          showUploadMessage(
                                              context, 'Uploading file...',
                                              showLoading: true);
                                          final downloadUrl = await uploadData(
                                              selectedMedia.storagePath,
                                              selectedMedia.bytes);
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          if (downloadUrl != null) {
                                            setState(() =>
                                                uploadedFileUrl = downloadUrl);
                                            showUploadMessage(
                                                context, 'Success!');
                                          } else {
                                            showUploadMessage(context,
                                                'Failed to upload media');
                                            return;
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: 85,
                                        height: 85,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color:
                                                FlutterFlowTheme.tertiaryColor,
                                            width: 2,
                                          ),
                                        ),
                                        child: AuthUserStreamWidget(
                                          child: Container(
                                            width: 85,
                                            height: 85,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.network(
                                              currentUserPhoto,
                                            ),
                                          ),
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
                                            color:
                                                FlutterFlowTheme.tertiaryColor,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: AuthUserStreamWidget(
                                  child: TextFormField(
                                    controller: displayNameController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Display Name',
                                      labelStyle: FlutterFlowTheme.bodyText1,
                                      hintText: 'Jon Doe',
                                      hintStyle:
                                          FlutterFlowTheme.bodyText2.override(
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
                                    style: FlutterFlowTheme.bodyText1,
                                    textAlign: TextAlign.start,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'Input Currect Email Address';
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: emailAddressController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Email address',
                                      labelStyle: FlutterFlowTheme.bodyText1,
                                      hintText: 'email@example.com',
                                      hintStyle:
                                          FlutterFlowTheme.bodyText2.override(
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
                                    style: FlutterFlowTheme.bodyText1,
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  if (!formKey.currentState.validate()) {
                                    return;
                                  }
                                  final usersUpdateData = createUsersRecordData(
                                    email: emailAddressController.text,
                                    displayName: displayNameController.text,
                                    photoUrl: uploadedFileUrl,
                                  );
                                  await widget.profileEdit
                                      .update(usersUpdateData);
                                  Navigator.pop(context);
                                },
                                text: 'Update Profile',
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
