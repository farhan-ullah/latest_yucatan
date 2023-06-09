import 'package:yucatan/theme/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yucatan/utils/theme_model.dart';

class DialogUtils {
  static Future<bool?> displayForgotDialog(BuildContext context, String title,
      String body, String buttonText1, String buttonText2,
      {bool? showOKButton, bool? showCancelButton}) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: ButtonBarTheme(
            data: const ButtonBarThemeData(alignment: MainAxisAlignment.center),
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_outlined,
                    color: CustomTheme.accentColor2,
                    size: 35,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: CustomTheme.accentColor2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              content: Text(
                body,
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Visibility(
                        visible: showOKButton!,
                        child: MaterialButton(
                          minWidth: 150.0,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Provider.of<ThemeModel>(context,
                                          listen: true)
                                      .primaryMainColor,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            buttonText2,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          textColor:
                              Provider.of<ThemeModel>(context, listen: true)
                                  .primaryMainColor,
                          onPressed: () {
                            Navigator.of(context).pop(true);
                            // true here means you clicked ok
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<bool?> displayDialog(BuildContext context, String title,
      String body, String buttonText1, String buttonText2,
      {bool? showOKButton, bool? showCancelButton}) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            content: Text(
              body,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Visibility(
                visible: showCancelButton!,
                child: TextButton(
                  child: Text(
                    buttonText1,
                    style: const TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ),
              Visibility(
                visible: showOKButton!,
                child: TextButton(
                  child: Text(
                    buttonText2,
                    style: const TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    // true here means you clicked ok
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<bool?> displayDeniedBookingInfoDialog(BuildContext context,
      String title, String body, String buttonText1) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            title: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      }),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: CustomTheme.accentColor1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            content: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Text(
                    body,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop(true);
                      // true here means you clicked ok
                    },
                    child: Container(
                      width: 130,
                      height: 50,
                      margin: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: CustomTheme.accentColor1.withOpacity(0.5),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          buttonText1,
                          style: const TextStyle(
                            fontSize: 18,
                            color: CustomTheme.accentColor1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
