import 'dart:typed_data';

import 'package:yucatan/theme/custom_theme.dart';
import 'package:yucatan/utils/check_condition.dart';
import 'package:yucatan/utils/rive_animation.dart';
import 'package:yucatan/utils/widget_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class AuthenticationHeader extends StatefulWidget {
  final String? title;
  const AuthenticationHeader({Key? key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthenticationHeaderState();
}

class _AuthenticationHeaderState extends State<AuthenticationHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        /*decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColorDark,
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColorLight
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
          stops: [0.0, 0.5, 1.0],
          tileMode: TileMode.clamp
        )
      ),*/
        child: Padding(
            padding: EdgeInsets.only(top: Dimensions.getScaledSize(50.0)),
            child: Column(
              children: [
                Container(
                  height: Dimensions.getHeight(percentage: 25.0),
                  width: Dimensions.getWidth(percentage: 25.0),
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
                    },
                  ),
                ),
                SizedBox(
                  height: Dimensions.getScaledSize(10.0),
                ),
                Text(
                  widget.title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: Dimensions.getScaledSize(25.0),
                      color: CustomTheme.theme.primaryColor),
                )
              ],
            )));
  }
}
