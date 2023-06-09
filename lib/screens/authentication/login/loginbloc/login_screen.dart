import 'dart:io';
import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:yucatan/components/colored_divider.dart';
import 'package:yucatan/screens/authentication/forgot/forgot_screen.dart';
import 'package:yucatan/screens/authentication/login/loginbloc/login_bloc.dart';
import 'package:yucatan/screens/authentication/register/register_screen.dart';
import 'package:yucatan/screens/main_screen/main_screen.dart';
import 'package:yucatan/theme/custom_theme.dart';
import 'package:provider/provider.dart';
import 'package:yucatan/utils/check_condition.dart';
import 'package:yucatan/utils/rive_animation.dart';
import 'package:yucatan/utils/theme_model.dart';
import 'package:yucatan/utils/StringUtils.dart';
import 'package:yucatan/utils/widget_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';

  LoginScreen();

  @override
  _LoginScreenState createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoginBtnPressed = false;
  LoginBloc loginBloc = LoginBloc();
  late String Imageurl;

  @override
  void initState() {
    _checkLoginResponse();
    super.initState();
  }

  void _checkLoginResponse() {
    loginBloc.loginResponse.listen((response) {
      if (response.status) {
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
            msg: response.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: CustomTheme.theme.primaryColorDark,
            textColor: Colors.white);
      }
    });
  }

  @override
  void dispose() {
    loginBloc.dispose();
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
                    width: double.infinity,
                    color: Colors.grey.withOpacity(0.2),
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
                  // Container(
                  //   width: double.infinity,
                  //   child: Image.asset(
                  //     'lib/assets/images/login_header_no_text.png',
                  //     fit: BoxFit.contain,
                  //   ),
                  // ),
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
                  //     child: SizedBox(
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
              Expanded(flex: 2, child: Container()),
              Container(
                child: SingleChildScrollView(
                  child: _loginContainer(),
                ),
              ),
              Expanded(child: Container(), flex: 2),
              InkWell(
                onTap: _onLogin,
                child: _loginButton(context),
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
                          color: Provider.of<ThemeModel>(context, listen: true)
                              .primaryMainColor,
                          fontSize: Dimensions.getScaledSize(15),
                        ),
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
              // ColoredDivider(height: Dimensions.getScaledSize(3)),
              Container(
                width: double.infinity,
                // height: Dimensions.getScaledSize(60.0) +
                //     MediaQuery.of(context).padding.bottom,
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

  void _onLogin() {
    var email = emailController.text;
    var password = passwordController.text;
    Navigator.of(context).popAndPushNamed(MainScreen.route);
    // if (isNotNullOrEmpty(email) && isNotNullOrEmpty(password)) {
    //   loginBloc.onSubmit(email, password);
    // }
  }

  Container _loginButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      // height: Dimensions.getScaledSize(45),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(Dimensions.getScaledSize(5)),
        ),
        border: Border.all(color: CustomTheme.primaryColorDark),
      ),
      child: Center(
          child: Text(
        AppLocalizations.of(context)!.loginSceen_login,
        style: TextStyle(
            color:
                Provider.of<ThemeModel>(context, listen: true).primaryMainColor,
            fontSize: Dimensions.getScaledSize(18),
            fontWeight: FontWeight.bold),
      )),
    );
  }

  StreamBuilder<bool> _loginContainer() {
    return StreamBuilder<bool>(
        stream: loginBloc.loginProcess,
        builder: (context, snapshot) {
          isLoginBtnPressed = snapshot.data ?? false;
          if (isLoginBtnPressed) {
            return Column(
              children: [
                SizedBox(
                  height: Dimensions.getScaledSize(60),
                ),
                CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        CustomTheme.theme.primaryColor)),
                Container(
                  margin: EdgeInsets.only(top: Dimensions.getScaledSize(10)),
                  child: Text(
                    AppLocalizations.of(context)!.loginSceen_loginWaiting,
                    style: TextStyle(
                        // fontSize: Dimensions.getScaledSize(15),
                        color: CustomTheme.theme.primaryColor),
                  ),
                ),
                SizedBox(
                  height: Dimensions.getScaledSize(40),
                ),
              ],
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.getScaledSize(50)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!
                            .authenticationSceen_email,
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: this.isLoginBtnPressed
                              ? BorderSide(
                                  color: emailController.text.isEmpty
                                      ? CustomTheme.accentColor1
                                      : CustomTheme.darkGrey.withOpacity(0.5))
                              : BorderSide(
                                  color: CustomTheme.darkGrey.withOpacity(0.5)),
                        ),
                      ),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      // onChanged: loginBloc.onChangeEmail,
                    ),
                    SizedBox(
                      height: Dimensions.pixels_10,
                    ),
                    StreamBuilder<bool>(
                        stream: loginBloc.togglePassword,
                        builder: (context, snapshot) {
                          var ishidden = snapshot.data ?? true;
                          return TextFormField(
                            obscureText: ishidden,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!
                                  .authenticationSceen_password,
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              suffix: InkWell(
                                onTap: () => loginBloc.toggle(!ishidden),
                                child: Icon(
                                    ishidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: isLoginBtnPressed
                                    ? BorderSide(
                                        color: passwordController.text.isEmpty
                                            ? CustomTheme.accentColor1
                                            : CustomTheme.darkGrey
                                                .withOpacity(0.5))
                                    : BorderSide(
                                        color: CustomTheme.darkGrey
                                            .withOpacity(0.5)),
                              ),
                            ),
                            controller: passwordController,
                            validator: (val) => val!.length < 6
                                ? AppLocalizations.of(context)!
                                    .authenticationSceen_passwordInvalid
                                : null,
                          );
                        }),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(ForgotScreen.route);
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              vertical: Dimensions.getScaledSize(20)),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .loginSceen_forgotPassword,
                              style: TextStyle(
                                color: CustomTheme.primaryColorLight,
                                fontSize: Dimensions.getScaledSize(16),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }
}
