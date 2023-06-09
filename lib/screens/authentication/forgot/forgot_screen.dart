import 'dart:typed_data';

import 'package:yucatan/components/colored_divider.dart';
import 'package:yucatan/screens/authentication/forgot/forgot_bloc.dart';
import 'package:yucatan/screens/authentication/register/register_screen.dart';
import 'package:yucatan/services/forogt_password_service.dart';
import 'package:yucatan/theme/custom_theme.dart';
import 'package:yucatan/utils/DialogUtils.dart';
import 'package:yucatan/utils/check_condition.dart';
import 'package:yucatan/utils/rive_animation.dart';
import 'package:yucatan/utils/widget_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';
import 'package:yucatan/utils/theme_model.dart';

class ForgotScreen extends StatefulWidget {
  static const route = '/forgot';

  ForgotScreen();

  @override
  _ForgotScreenState createState() {
    return _ForgotScreenState();
  }
}

class _ForgotScreenState extends State<ForgotScreen> {
  final emailController = TextEditingController();
  ForgotBloc bloc = ForgotBloc();

  @override
  void initState() {
    _getForgotResponse();
    _getValidation();
    _getLoading();
    super.initState();
  }

  void _getLoading() {
    bloc.getLoading.listen((isLoading) {
      if (isLoading) {
        showLoader(context);
      } else {
        Navigator.pop(context);
      }
    });
  }

  void _getValidation() {
    bloc.getValidation.listen((validation) {
      switch (validation) {
        case ValidationState.INVALID:
          showErrorMsg(
              AppLocalizations.of(context)!.authenticationSceen_emailInvalid);
          break;
        case ValidationState.EMPTY:
          showErrorMsg(
              AppLocalizations.of(context)!.authenticationSceen_emailInvalid);
          break;
      }
    });
  }

  void _getForgotResponse() {
    bloc.getForgotResponse.listen((result) async {
      if (result != null) {
        if (result.statusCode != 200) {
          showErrorMsg(result.message!);
        } else {
          var dialogResult = await DialogUtils.displayForgotDialog(
              context,
              AppLocalizations.of(context)!.authenticationSceen_forgotPassword,
              "${result.message}",
              AppLocalizations.of(context)!.actions_back,
              AppLocalizations.of(context)!.actions_back,
              showCancelButton: false,
              showOKButton: true);
          if (dialogResult != null) {
            if (dialogResult == true) Navigator.pop(context);
          }
        }
      } else {
        showErrorMsg(
            AppLocalizations.of(context)!.authenticationSceen_networkError);
      }
    });
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    color: Colors.grey.withOpacity(0.2),
                    width: double.infinity,
                    child: FutureBuilder(
                      future: checkCondition(), // a Future<String> or null
                      builder: (BuildContext context,
                          AsyncSnapshot<Uint8List> snapshot) {
                        return snapshot.hasData
                            ? Image.memory(snapshot.data!)
                            : RiveAnimation(
                                riveFileName: 'app-start.riv',
                                riveAnimationName: 'Animation 1',
                                placeholderImage:
                                    'lib/assets/images/appventure_icon_white.png',
                                startAnimationAfterMilliseconds: 2,
                              );

                        // switch (snapshot.connectionState) {
                        //   case ConnectionState.none:
                        //     return Text("See the printed Data${snapshot.data!}");
                        //       // Image(
                        //     // image: FileImage(File(snapshot.data!)),
                        //   // );
                        //   case ConnectionState.waiting: return const Text('Awaiting result...');
                        //   default:
                        //     if (snapshot.hasError) {
                        //       return Text('Error: ${snapshot.error}');
                        //     } else {
                        //       return Text('Result: ${snapshot.data}');
                        //     }
                        // }
                      },
                    ),
                  ),
                  Positioned(
                      top: Dimensions.getHeight(percentage: 2),
                      left: Dimensions.getScaledSize(8),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: SvgPicture.asset(
                          'lib/assets/images/login_back_icon.svg',
                          color: Colors.white,
                          fit: BoxFit.fill,
                          height: 20,
                          width: 20,
                        ),
                      )),
                  // Positioned(
                  //     bottom: 30,
                  //     child: Container(
                  //       width: MediaQuery.of(context).size.width,
                  //       child: Center(
                  //         child: Text(
                  //           AppLocalizations.of(context)!
                  //               .authenticationSceen_wellcome,
                  //           style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: Dimensions.getScaledSize(20),
                  //               fontWeight: FontWeight.w500),
                  //         ),
                  //       ),
                  //     ))
                ],
              ),
              Expanded(flex: 3, child: Container()),
              // Container(
              //   child:
              // SingleChildScrollView(
              //   child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.getScaledSize(50)),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .forgotPasswordScreen_description,
                          style: TextStyle(
                              color:
                                  Provider.of<ThemeModel>(context, listen: true)
                                      .primaryMainColor,
                              fontSize: Dimensions.getScaledSize(14)),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Container(
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!
                                    .forgotPasswordScreen_emailHint,
                                hintStyle: TextStyle(
                                  color: Colors.grey[500],
                                )),
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              //       ),
              //           ),
              Expanded(child: Container(), flex: 2),
              InkWell(
                onTap: () {
                  // performForgotApiCall();
                  bloc.requestPassword(emailController.text);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: Dimensions.getScaledSize(45),
                  decoration: BoxDecoration(
                    color: CustomTheme.backgroundColor,
                    border: Border.all(color: CustomTheme.primaryColorDark),
                    borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.getScaledSize(5))),
                  ),
                  child: Center(
                      child: Text(
                    AppLocalizations.of(context)!.forgotPasswordScreen_send,
                    style: TextStyle(
                        color: Provider.of<ThemeModel>(context, listen: true)
                            .primaryMainColor,
                        fontSize: Dimensions.getScaledSize(18)),
                  )),
                ),
              ),
              Expanded(flex: 1, child: Container()),
              InkWell(
                onTap: () async {
                  Navigator.of(context).pushReplacementNamed(
                    RegisterScreen.route,
                  );
                },
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!
                          .authenticationSceen_noProfile,
                      style: TextStyle(
                          color: Provider.of<ThemeModel>(context, listen: true)
                              .primaryMainColor,
                          fontSize: Dimensions.getScaledSize(15)),
                    ),
                    Text.rich(
                      TextSpan(
                        text: AppLocalizations.of(context)!
                            .authenticationSceen_registerNow,
                        style: TextStyle(
                            color:
                                Provider.of<ThemeModel>(context, listen: true)
                                    .primaryMainColor,
                            fontSize: Dimensions.getScaledSize(15)),
                        children: [
                          TextSpan(
                              text: AppLocalizations.of(context)!
                                  .authenticationSceen_registerNowRegister,
                              style: TextStyle(
                                  color: CustomTheme.primaryColorLight,
                                  fontSize: Dimensions.getScaledSize(15))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(flex: 1, child: Container()),
              ColoredDivider(
                height: Dimensions.getScaledSize(3),
              ),
              Container(
                width: double.infinity,
                height: Dimensions.getScaledSize(60.0) +
                    MediaQuery.of(context).padding.bottom,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                color: Provider.of<ThemeModel>(context, listen: true)
                    .primaryMainColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        AppLocalizations.of(context)!
                            .authenticationSceen_bottomBar1,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.getScaledSize(15))),
                    Text.rich(
                      TextSpan(
                        text: AppLocalizations.of(context)!
                            .authenticationSceen_bottomBar2,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.getScaledSize(15)),
                        children: [
                          TextSpan(
                              text: AppLocalizations.of(context)!
                                  .authenticationSceen_bottomBar3,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.getScaledSize(15),
                                  fontWeight: FontWeight.w800)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void performForgotApiCall() async {
    if (emailController.text.trim().isEmpty) {
      showErrorMsg(
          AppLocalizations.of(context)!.authenticationSceen_emailInvalid);
      return;
    }
    if (validateEmail(emailController.text.trim())) {
      showLoader(context);
      var result = await ForgotPassword.forgotPassword(emailController.text);
      Navigator.pop(context);
      hideKeyboard(context);
      if (result != null) {
        if (result.statusCode != 200) {
          showErrorMsg(result.message!);
        } else {
          var dialogResult = await DialogUtils.displayForgotDialog(
              context,
              AppLocalizations.of(context)!.authenticationSceen_forgotPassword,
              "${result.message}",
              AppLocalizations.of(context)!.actions_back,
              AppLocalizations.of(context)!.actions_back,
              showCancelButton: false,
              showOKButton: true);
          if (dialogResult != null) {
            if (dialogResult == true) Navigator.pop(context);
          }
        }
      } else {
        showErrorMsg(
            AppLocalizations.of(context)!.authenticationSceen_networkError);
      }
    } else {
      showErrorMsg(
          AppLocalizations.of(context)!.authenticationSceen_emailInvalid);
    }
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());

    return regex.hasMatch(value);
  }

  void showErrorMsg(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Color(0xff656565).withOpacity(0.9),
        textColor: Colors.white,
        fontSize: Dimensions.getScaledSize(16));
  }

  void showLoader(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
                backgroundColor: Colors.black12,
                valueColor: AlwaysStoppedAnimation<Color>(
                    CustomTheme.theme.primaryColorDark)),
          );
        });
  }

  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
