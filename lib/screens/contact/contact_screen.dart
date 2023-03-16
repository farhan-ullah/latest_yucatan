import 'dart:html';

import 'package:yucatan/models/contact_model.dart';
import 'package:yucatan/screens/checkout_screen/components/checkout_checkbox_formfield.dart';
import 'package:yucatan/screens/impressum_datenschutz/impressum_datenschutz.dart';
import 'package:yucatan/screens/notifications/notification_view.dart';
import 'package:yucatan/screens/profile/components/profile_fields.dart';
import 'package:yucatan/services/contact_service.dart';
import 'package:yucatan/services/response/contact_response.dart';
import 'package:yucatan/services/response/user_login_response.dart';
import 'package:yucatan/services/user_provider.dart';
import 'package:yucatan/size_config.dart';
import 'package:yucatan/theme/custom_theme.dart';
import 'package:yucatan/utils/common_widgets.dart';
import 'package:yucatan/utils/network_utils.dart';
import 'package:yucatan/utils/regex_utils.dart';
import 'package:yucatan/utils/widget_dimensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:yucatan/utils/theme_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactScreen extends StatefulWidget {
  static const String route = '/contact';
  ContactScreen();

  @override
  _ContactScreenState createState() {
    return _ContactScreenState();
  }
}

class _ContactScreenState extends State<ContactScreen> {
  // UserLoginModel? userLoginModel;
  // var contactModel = ContactModel();
  String? firstname;
  String? lastname;
  String? phone;
  String? email;
  String? message;
  bool? isDataProtectionChecked;
  bool showSpinner = false;
  bool showBtn = true;
  bool isUserLoggedIn = false;
  bool isSubmitPressed = false;
  ScrollController _scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isSubmitPressed = false;
    isDataProtectionChecked = false;
    //
    firstname = "";
    //
    lastname = "";
    //
    phone = "";
    //
    email = "";
    //
    message = "";
    messageController.text = 'Message';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Kontakt"),
        backgroundColor:
            Provider.of<ThemeModel>(context, listen: true).primaryMainColor,
        actions: [
          NotificationView(
            negativePadding: false,
          ),
          SizedBox(
            width: Dimensions.getScaledSize(24.0),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          margin: EdgeInsets.fromLTRB(
            Dimensions.getScaledSize(20.0),
            Dimensions.getScaledSize(20.0),
            Dimensions.getScaledSize(20.0),
            Dimensions.getScaledSize(20.0),
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${AppLocalizations.of(context)!.contactUserName_title}!',
                style: TextStyle(
                  fontSize: Dimensions.getScaledSize(18.0),
                  fontWeight: FontWeight.bold,
                  color: Provider.of<ThemeModel>(context, listen: true)
                      .primaryMainColor,
                ),
              ),
              SizedBox(
                height: Dimensions.getScaledSize(15.0),
              ),
              Text(
                AppLocalizations.of(context)!.contactInformation_message,
                style: TextStyle(
                  fontSize: Dimensions.getScaledSize(14.0),
                  color: Provider.of<ThemeModel>(context, listen: true)
                      .primaryMainColor,
                ),
              ),
              Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: Dimensions.getScaledSize(30.0),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.contact_firstname,
                            // AppLocalizations.of(context)!
                            //     .forgotPasswordScreen_emailHint,
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                            )),
                        // controller: organizationController,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: Dimensions.getScaledSize(20.0),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.contact_lastname,
                            // AppLocalizations.of(context)!
                            //     .forgotPasswordScreen_emailHint,
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                            )),
                        // controller: organizationController,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: Dimensions.getScaledSize(20.0),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.contact_phone,
                            // AppLocalizations.of(context)!
                            //     .forgotPasswordScreen_emailHint,
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                            )),
                        // controller: organizationController,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: Dimensions.getScaledSize(20.0),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.contact_email,
                            // AppLocalizations.of(context)!
                            //     .forgotPasswordScreen_emailHint,
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                            )),
                        // controller: organizationController,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: Dimensions.getScaledSize(20.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.getScaledSize(20.0),
                  ),
                  Container(
                    height: Dimensions.getScaledSize(270),
                    padding: EdgeInsets.fromLTRB(
                        Dimensions.getScaledSize(5),
                        Dimensions.getScaledSize(10),
                        Dimensions.getScaledSize(5),
                        Dimensions.getScaledSize(10)),
                    //decoration: messageBoxDecoration(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: Dimensions.getScaledSize(250),
                      ),
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          reverse: true,
                          child: SizedBox(
                            height: Dimensions.getScaledSize(250),
                            child: TextField(
                              controller: messageController,
                              onChanged: (value) {
                                message = value;
                              },
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(500),
                              ],
                              maxLines: 100,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          Dimensions.getScaledSize(8))),
                                  borderSide: isSubmitPressed
                                      ? BorderSide(
                                          color: messageController.text.isEmpty
                                              ? CustomTheme.accentColor1
                                              : CustomTheme.disabledColor
                                                  .withOpacity(0.075),
                                          width: 1)
                                      : BorderSide(
                                          color: CustomTheme.disabledColor
                                              .withOpacity(0.075),
                                          width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          Dimensions.getScaledSize(8))),
                                  borderSide: BorderSide(
                                      color: CustomTheme.disabledColor
                                          .withOpacity(0.075),
                                      width: 1),
                                ),
                                hintText: AppLocalizations.of(context)!
                                    .contact_message,
                                hintStyle: TextStyle(
                                  color: CustomTheme.disabledColor
                                      .withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.getScaledSize(20.0),
                  ),
                  CheckoutCheckboxFormField(
                    isComingFromContactScreen: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    initialValue: isDataProtectionChecked!,
                    isSubmitPressed: isSubmitPressed,
                    callback: handlecheckboxDataChanged,
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: AppLocalizations.of(context)!
                                .contact_dataprotection_text),
                        TextSpan(
                          text: AppLocalizations.of(context)!
                              .contact_dataprotection,
                          style: TextStyle(
                            color:
                                Provider.of<ThemeModel>(context, listen: true)
                                    .primaryMainColor,
                            fontFamily: CustomTheme.fontFamily,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImpressumDatenschutz(
                                    isComingFromCheckOut: true,
                                    webViewValues: WebViewValues.PRIVACY,
                                  ),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.getScaledSize(20.0),
                  ),
                ],
              ),
              Visibility(
                visible: showSpinner,
                child: Container(
                  color: Colors.white,
                  height: Dimensions.getHeight(percentage: 64.0),
                  child: CommonWidget.showSpinner(),
                ),
              ),
              ButtonTheme(
                minWidth: Dimensions.getWidth(percentage: 100),
                child: MaterialButton(
                  elevation: 0.0,
                  color: CustomTheme.backgroundColor,
                  textColor: Provider.of<ThemeModel>(context, listen: true)
                      .primaryMainColor,
                  disabledColor: CustomTheme.grey,
                  disabledTextColor:
                      Provider.of<ThemeModel>(context, listen: true)
                          .primaryMainColor,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Dimensions.getScaledSize(8.0)),
                      side: BorderSide(
                          color: Theme.of(context).primaryColorDark,
                          width: 1.0)),
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.getScaledSize(10.0),
                      horizontal: Dimensions.getScaledSize(20.0)),
                  onPressed: () async {
                    Fluttertoast.showToast(
                      msg: "Message Sent Successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: CustomTheme.theme.primaryColorDark,
                      textColor: Colors.white,
                    );
                    // }
                    Navigator.pop(context);
                    // setState(() {
                    //   isSubmitPressed = true;
                    // });
                    // bool isNetworkAvailable =
                    //     await NetworkUtils.isNetworkAvailable();
                    // if (isNetworkAvailable) {
                    //   _performContact(context);
                    // } else {
                  },
                  child: Text(
                    AppLocalizations.of(context)!.contact_submit,
                    style: TextStyle(
                      fontSize: Dimensions.getScaledSize(18.0),
                      color: Provider.of<ThemeModel>(context, listen: true)
                          .primaryMainColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // FutureBuilder<UserLoginModel>(
      //   future: UserProvider.getUser(), // async work
      //   builder:
      //       (BuildContext context, AsyncSnapshot<UserLoginModel> snapshot) {
      //     switch (snapshot.connectionState) {
      //       case ConnectionState.waiting:
      //         return Center(child: CircularProgressIndicator());
      //       default:
      //         if (snapshot.hasError) {
      //           return Text('Error: ${snapshot.error}');
      //         } else {
      //            userLoginModel = snapshot.data;
      //           if (userLoginModel == null) {
      //              isUserLoggedIn = false;
      //             return showContactView(false);
      //           } else {
      //              isUserLoggedIn = true;
      //             return showContactView(true);
      //           }
      //         }
      //     }
      //   },
      // ),
    );
  }

  Padding _textField(BuildContext context, String textHint) {
    return Padding(
        padding: EdgeInsets.only(
            left: Dimensions.getScaledSize(0),
            right: Dimensions.getScaledSize(0),
            bottom: Dimensions.getScaledSize(5.0),
            top: Dimensions.getScaledSize(5.0)),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                //                   <--- left side
                color: CustomTheme.disabledColor.withOpacity(0.075),
                width: 1.0,
              ),
            ),
          ),
          child: TextFormField(
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(30)
            ],
            style: TextStyle(fontSize: Dimensions.getScaledSize(15)),
            // controller: _controller,
            keyboardType: TextInputType.text,
            maxLines: 1,
            maxLength: 30,
            maxLengthEnforcement: MaxLengthEnforcement.none,
            buildCounter: (BuildContext? context,
                {int? currentLength, int? maxLength, bool? isFocused}) {
              return null;
            },
            // hide character counter
            decoration: InputDecoration(
              isDense: true,
              // required to remove all initial (unwanted) padding
              contentPadding: EdgeInsets.only(
                  top: Dimensions.getScaledSize(10.0),
                  bottom: Dimensions.getScaledSize(5.0),
                  left: Dimensions.getScaledSize(10.0),
                  right: Dimensions.getScaledSize(10.0)),
              hintText: textHint,
              hintStyle:
                  TextStyle(color: CustomTheme.disabledColor.withOpacity(0.5)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: CustomTheme.disabledColor.withOpacity(0.075)),
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: CustomTheme.accentColor1)),
            ),
            onSaved: (String? value) {},
            onChanged: (String value) {},
            enabled: true,
          ),
        ));
  }

  Widget showContactView(bool isUserLoggedIn) {
    return SafeArea(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          margin: EdgeInsets.fromLTRB(
            Dimensions.getScaledSize(20.0),
            Dimensions.getScaledSize(20.0),
            Dimensions.getScaledSize(20.0),
            Dimensions.getScaledSize(20.0),
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isUserLoggedIn
                    ? "${AppLocalizations.of(context)!.contactUserName_hallo} Farhan!"
                    : '${AppLocalizations.of(context)!.contactUserName_title}!',
                style: TextStyle(
                  fontSize: Dimensions.getScaledSize(18.0),
                  fontWeight: FontWeight.bold,
                  color: Provider.of<ThemeModel>(context, listen: true)
                      .primaryMainColor,
                ),
              ),
              SizedBox(
                height: Dimensions.getScaledSize(15.0),
              ),
              Text(
                AppLocalizations.of(context)!.contactInformation_message,
                style: TextStyle(
                  fontSize: Dimensions.getScaledSize(14.0),
                  color: Provider.of<ThemeModel>(context, listen: true)
                      .primaryMainColor,
                ),
              ),
              Visibility(
                visible: showBtn,
                child: Column(
                  children: [
                    Visibility(
                      visible: isUserLoggedIn ? false : true,
                      child: Column(
                        children: [
                          SizedBox(
                            height: Dimensions.getScaledSize(30.0),
                          ),
                          ProfileField(
                            lengthLimit: 30,
                            onChanged: (value) {
                              firstname = value;
                            },
                            initialValue: firstname!,
                            placeHolder:
                                AppLocalizations.of(context)!.contact_firstname,
                            isComingFromContactScreen: true,
                            isSubmitPressed: false,
                          ),
                          SizedBox(
                            height: Dimensions.getScaledSize(20.0),
                          ),
                          ProfileField(
                            lengthLimit: 30,
                            initialValue: lastname!,
                            onChanged: (value) {
                              lastname = value;
                            },
                            placeHolder:
                                AppLocalizations.of(context)!.contact_lastname,
                            isComingFromContactScreen: true,
                            isSubmitPressed: false,
                          ),
                          SizedBox(
                            height: Dimensions.getScaledSize(20.0),
                          ),
                          ProfileField(
                            lengthLimit: 15,
                            onChanged: (value) {
                              phone = value;
                            },
                            initialValue: phone!,
                            placeHolder:
                                AppLocalizations.of(context)!.contact_phone,
                            isComingFromContactScreen: true,
                            textInputType: TextInputType.number,
                            isSubmitPressed: false,
                          ),
                          SizedBox(
                            height: Dimensions.getScaledSize(20.0),
                          ),
                          ProfileField(
                            onChanged: (value) {
                              email = value;
                            },
                            initialValue: email!,
                            placeHolder:
                                AppLocalizations.of(context)!.contact_email,
                            isComingFromContactScreen: true,
                            textInputType: TextInputType.emailAddress,
                            isSubmitPressed: isSubmitPressed,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.getScaledSize(20.0),
                    ),
                    Container(
                      height: Dimensions.getScaledSize(270),
                      padding: EdgeInsets.fromLTRB(
                          Dimensions.getScaledSize(5),
                          Dimensions.getScaledSize(10),
                          Dimensions.getScaledSize(5),
                          Dimensions.getScaledSize(10)),
                      //decoration: messageBoxDecoration(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: Dimensions.getScaledSize(250),
                        ),
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            reverse: true,
                            child: SizedBox(
                              height: Dimensions.getScaledSize(250),
                              child: TextField(
                                controller: messageController,
                                onChanged: (value) {
                                  message = value;
                                },
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(500),
                                ],
                                maxLines: 100,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            Dimensions.getScaledSize(8))),
                                    borderSide: isSubmitPressed
                                        ? BorderSide(
                                            color:
                                                messageController.text.isEmpty
                                                    ? CustomTheme.accentColor1
                                                    : CustomTheme.disabledColor
                                                        .withOpacity(0.075),
                                            width: 1)
                                        : BorderSide(
                                            color: CustomTheme.disabledColor
                                                .withOpacity(0.075),
                                            width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            Dimensions.getScaledSize(8))),
                                    borderSide: BorderSide(
                                        color: CustomTheme.disabledColor
                                            .withOpacity(0.075),
                                        width: 1),
                                  ),
                                  hintText: AppLocalizations.of(context)!
                                      .contact_message,
                                  hintStyle: TextStyle(
                                    color: CustomTheme.disabledColor
                                        .withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.getScaledSize(20.0),
                    ),
                    CheckoutCheckboxFormField(
                      isComingFromContactScreen: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: isDataProtectionChecked!,
                      isSubmitPressed: isSubmitPressed,
                      callback: handlecheckboxDataChanged,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: AppLocalizations.of(context)!
                                  .contact_dataprotection_text),
                          TextSpan(
                            text: AppLocalizations.of(context)!
                                .contact_dataprotection,
                            style: TextStyle(
                              color:
                                  Provider.of<ThemeModel>(context, listen: true)
                                      .primaryMainColor,
                              fontFamily: CustomTheme.fontFamily,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImpressumDatenschutz(
                                      isComingFromCheckOut: true,
                                      webViewValues: WebViewValues.PRIVACY,
                                    ),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.getScaledSize(20.0),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: showSpinner,
                child: Container(
                  color: Colors.white,
                  height: Dimensions.getHeight(percentage: 64.0),
                  child: CommonWidget.showSpinner(),
                ),
              ),
              Visibility(
                visible: showBtn,
                child: showSubmitButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration messageBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: isSubmitPressed
          ? messageController.text.trim().isEmpty
              ? Border.all(
                  color: CustomTheme.accentColor1, // set border color
                  width: 1.0,
                )
              : Border.all(
                  color: CustomTheme.disabledColor
                      .withOpacity(0.075), // set border color
                  width: 1.0,
                )
          : Border.all(
              color: CustomTheme.disabledColor
                  .withOpacity(0.075), // set border color
              width: 1.0,
            ), // set border width
      borderRadius: BorderRadius.all(
        Radius.circular(Dimensions.getScaledSize(8)),
      ),
    );
  }

  Widget showSubmitButton() {
    return ButtonTheme(
      minWidth: SizeConfig.screenWidth!,
      child: MaterialButton(
        elevation: 0.0,
        color: CustomTheme.backgroundColor,
        textColor:
            Provider.of<ThemeModel>(context, listen: true).primaryMainColor,
        disabledColor: CustomTheme.grey,
        disabledTextColor:
            Provider.of<ThemeModel>(context, listen: true).primaryMainColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.getScaledSize(8.0)),
            side: BorderSide(
                color: Theme.of(context).primaryColorDark, width: 1.0)),
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.getScaledSize(10.0),
            horizontal: Dimensions.getScaledSize(20.0)),
        onPressed: () async {
          setState(() {
            isSubmitPressed = true;
          });
          bool isNetworkAvailable = await NetworkUtils.isNetworkAvailable();
          if (isNetworkAvailable) {
            _performContact(context);
          } else {
            Fluttertoast.showToast(
              msg: "No network connection!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: CustomTheme.theme.primaryColorDark,
              textColor: Colors.white,
            );
          }
        },
        child: Text(
          AppLocalizations.of(context)!.contact_submit,
          style: TextStyle(
            fontSize: Dimensions.getScaledSize(18.0),
            color:
                Provider.of<ThemeModel>(context, listen: true).primaryMainColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  handlecheckboxDataChanged(bool value) {
    isDataProtectionChecked = value;
  }

  Future<void> _performContact(BuildContext context) async {
    bool isDataValidated = validateData();
    if (isDataValidated && isDataProtectionChecked!) {
      messageController.text = message!;
      setState(() {
        showSpinner = true;
        showBtn = false;
      });
      // ContactResponse? contactResponse =
      //     await ContactService.sendContactQuery(contactModel, isUserLoggedIn);
      // if (contactResponse != null) {
      //   if (contactResponse.status == 200 &&
      //       contactResponse.statusCodeApiRequest == 200) {
      //     CommonWidget.showToast(
      //       AppLocalizations.of(context)!.contact_api_success_msg,
      //     );
      //     resetData();
      //   }
      // }
      CommonWidget.showToast(
        AppLocalizations.of(context)!.contact_api_success_msg,
      );
      resetData();
      setState(() {
        showSpinner = false;
        showBtn = true;
      });
    } else {
      /*CommonWidget.showToast(
          AppLocalizations.of(context)!.contact_screen_validation_text);*/
      //print("isDataValidated=$isDataValidated");
    }
  }

  /// if a user is logged in and one if a user is not logged in.
  bool validateData() {
    bool isDataValidated = false;
    if (
        // userLoginModel != null &&
        message!.trim().isNotEmpty) {
      isDataValidated = true;
    } else if (email!.trim().isNotEmpty &&
        /*  phone.trim().isNotEmpty &&*/
        message!.trim().isNotEmpty) {
      bool emailValid = RegexUtils.email.hasMatch(email!.trim());
      if (/*  firstname.trim().isNotEmpty &&*/
          /*  lastname.trim().isNotEmpty &&*/

          emailValid) {
        isDataValidated = true;
      } else {
        isDataValidated = false;
      }
    }
    return isDataValidated;
  }

  resetData() {
    isDataProtectionChecked = false;
    isSubmitPressed = false;
    /*  firstname = "";
      lastname = "";
      phone = "";*/
    email = "";
    message = "";
    messageController.text = "";
  }
}
