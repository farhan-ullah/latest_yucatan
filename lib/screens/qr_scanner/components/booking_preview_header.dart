import 'dart:typed_data';

import 'package:yucatan/theme/custom_theme.dart';
import 'package:yucatan/utils/check_condition.dart';
import 'package:yucatan/utils/rive_animation.dart';
import 'package:yucatan/utils/widget_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:yucatan/utils/theme_model.dart';
//taken from the \lib\screens\booking_list_screen\components\booking_ticket_list.dart lines 100 - 139

class BookingPreviewHeader extends StatelessWidget {
  final String ticketNumber;
  BookingPreviewHeader({required this.ticketNumber});
  @override
  Widget build(BuildContext context) {
    double displayHeight = MediaQuery.of(context).size.height;
    double displayWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: displayWidth * 0.04,
      ),
      height: displayHeight * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.getScaledSize(24.0)),
          topRight: Radius.circular(Dimensions.getScaledSize(24.0)),
        ),
        color: Provider.of<ThemeModel>(context, listen: true).primaryMainColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Container(
            height: Dimensions.getHeight(percentage: 25.0),
            width: Dimensions.getWidth(percentage: 25.0),
            child: FutureBuilder(
              future: checkCondition(), // a Future<String> or null
              builder:
                  (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
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
          Expanded(child: Container()),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.bookingListScreen_ticketNumber,
                style: TextStyle(
                  fontSize: 0.03 * displayWidth,
                  color: Colors.white,
                ),
              ),
              Text(
                ticketNumber,
                style: TextStyle(
                  fontSize: 0.03 * displayWidth,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
