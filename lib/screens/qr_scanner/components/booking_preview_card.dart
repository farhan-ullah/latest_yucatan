import 'dart:js';

import 'package:yucatan/models/activity_model.dart'
    hide ProductAdditionalService;
import 'package:yucatan/models/booking_model.dart';
import 'package:yucatan/screens/qr_scanner/components/booking_preview_header.dart';
import 'package:yucatan/theme/custom_theme.dart';
import 'package:provider/provider.dart';
import 'package:yucatan/utils/theme_model.dart';
import 'package:yucatan/utils/price_format_utils.dart';
import 'package:yucatan/utils/widget_dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookingPreviewCard extends StatelessWidget {
  final ActivityModel activityModel;
  final BookingModel booking;
  final BookingTicket ticket;
  final Function goBack;
  final Function redeem;
  final bool isAlreadyRedeemed;

  BookingPreviewCard(
      {required this.activityModel,
      required this.booking,
      required this.ticket,
      required this.goBack,
      required this.redeem,
      required this.isAlreadyRedeemed});

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    double titleSize = displayHeight * 0.02;
    double textSize = displayHeight * 0.018;
    return Dialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: 0.04 * MediaQuery.of(context).size.width,
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Dimensions.getScaledSize(24.0))),
        ),
        child: Container(
          height: displayHeight - (0.4 * displayHeight).round(),
          width: displayWidth - (0.1 * displayWidth.round()),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(Dimensions.getScaledSize(24.0)),
              color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BookingPreviewHeader(ticketNumber: ticket.ticket!),
              SizedBox(height: displayHeight * 0.03),
              Container(
                height: displayHeight * 0.3,
                padding: EdgeInsets.symmetric(
                  horizontal: displayWidth * 0.04,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activityModel.title!,
                        style: getTextStyleBold(titleSize, context),
                      ),
                      SizedBox(height: displayHeight * 0.005),
                      Text(
                        "${activityModel.location!.street} ${activityModel.location!.housenumber}",
                        style: getTextStyle(textSize, context),
                      ),
                      SizedBox(height: displayHeight * 0.005),
                      Text(
                        "${activityModel.location!.zipcode} ${activityModel.location!.city}",
                        style: getTextStyle(textSize, context),
                      ),
                      SizedBox(height: displayHeight * 0.01),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            CupertinoIcons.checkmark_alt,
                            size: displayHeight * 0.025,
                          ),
                          Text(
                            "${booking.bookingDate!.day}.${booking.bookingDate!.month}.${booking.bookingDate!.year}",
                            textScaleFactor: 1,
                            style: TextStyle(
                              color:
                                  Provider.of<ThemeModel>(context, listen: true)
                                      .primaryMainColor,
                              fontWeight: FontWeight.w200,
                            ),
                          )
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      SizedBox(height: displayHeight * 0.02),
                      Text(AppLocalizations.of(context)!.commonWords_booking,
                          style: getTextStyleBold(titleSize, context)),
                      SizedBox(height: displayHeight * 0.01),
                      Text(
                        '${_getProductById(ticket.productId!)!.categoryTitle}, ${_getProductById(ticket.productId!)!.subCategoryTitle}',
                        style: getTextStyleBold(textSize, context),
                      ),
                      _getProductTextForTicket(ticket, textSize, context),
                      ..._getProductPropertiesForTicket(
                          ticket, textSize, context),
                      ..._getAdditionalServicesForTicket(ticket,
                          displayHeight * 0.005, textSize, textSize, context),
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.04 * displayWidth),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.bookingListScreen_inValueOf,
                      style: getTextStyle(0.03 * displayHeight, context),
                    ),
                    SizedBox(width: displayHeight * 0.01),
                    Text("${formatPriceDouble(ticket.price!)}€",
                        style: getTextStyleBold(0.04 * displayHeight, context)),
                  ],
                ),
              ),
              SizedBox(height: 0.04 * displayHeight),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.08 * displayWidth),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BookingPreviewButton(
                        color: Colors.red,
                        buttonText:
                            AppLocalizations.of(context)!.actions_cancel,
                        onPressed: goBack()),
                    BookingPreviewButton(
                        color: isAlreadyRedeemed ? Colors.grey : Colors.green,
                        buttonText:
                            AppLocalizations.of(context)!.actions_confirm,
                        onPressed: (isAlreadyRedeemed ? null : redeem())!)
                  ],
                ),
              ),
              SizedBox(height: displayHeight * 0.03),
            ],
          ),
        ));
  }

  getTextStyle(double fontSize, BuildContext context) {
    return TextStyle(
        fontFamily: "AcuminProWide",
        color: Provider.of<ThemeModel>(context, listen: true).primaryMainColor,
        fontSize: fontSize,
        fontWeight: FontWeight.w200);
  }

  getTextStyleBold(double fontSize, BuildContext context) {
    return TextStyle(
        fontFamily: "AcuminProWide",
        color: Provider.of<ThemeModel>(context, listen: true).primaryMainColor,
        fontSize: fontSize,
        fontWeight: FontWeight.bold);
  }

  BookingProduct? _getProductById(String? productId) {
    return booking.products!.firstWhere(
      (element) => element.id == productId,
    );
  }

  _getAdditionalServiceByTicketAndId(
      BookingTicket ticket, String additionalServiceId) {
    var bookingProduct = _getProductById(ticket.productId);

    return bookingProduct!.additionalServices!.firstWhere(
      (element) => element.id == additionalServiceId,
    );
  }

  Widget _getProductTextForTicket(
      BookingTicket ticket, fontSize, BuildContext context) {
    var bookingProduct = _getProductById(ticket.productId);

    return Text(
      '1x ${bookingProduct!.title}',
      style: getTextStyle(fontSize, context),
    );
  }

  List<Widget> _getProductPropertiesForTicket(
      BookingTicket ticket, double fontSize, BuildContext context) {
    List<Widget> widgets = [];

    var bookingProduct = _getProductById(ticket.productId);

    if (bookingProduct!.quantity! > 1) return [];

    bookingProduct.properties!.forEach((productPropertyElemenet) {
      widgets.add(
        Text(
          '${productPropertyElemenet.value}',
          style: getTextStyle(fontSize, context),
        ),
      );
    });

    return widgets;
  }

  List<Widget> _getAdditionalServicesForTicket(
      BookingTicket ticket,
      double paddingSize,
      double fontSize,
      double fontSize2,
      BuildContext context) {
    List<Widget> widgets = [];

    ticket.additionalServiceInfo!.forEach((additionalServiceInfoElement) {
      widgets.add(
        SizedBox(
          height: paddingSize,
        ),
      );

      var additionalService = _getAdditionalServiceByTicketAndId(
        ticket,
        additionalServiceInfoElement.additionalServiceId!,
      );

      widgets.add(
        Text(
          '${additionalServiceInfoElement.quantity}x ${additionalService.title}',
          style: getTextStyle(fontSize, context),
        ),
      );

      widgets.addAll(
        _getAdditionalServicePropertiesForAdditionalService(
            additionalService, fontSize2, context),
      );
    });

    return widgets;
  }

  List<Widget> _getAdditionalServicePropertiesForAdditionalService(
      ProductAdditionalService additionalService,
      double fontSize,
      BuildContext context) {
    List<Widget> widgets = [];

    if (additionalService.quantity! > 1) return [];

    additionalService.properties!.forEach((additionalServicePropertyElemenet) {
      widgets.add(
        Text(
          '${additionalServicePropertyElemenet.value}',
          style: getTextStyle(fontSize, context),
        ),
      );
    });

    return widgets;
  }
}

class BookingPreviewButton extends StatelessWidget {
  final Color color;
  final String buttonText;
  final void Function() onPressed;

  BookingPreviewButton(
      {required this.color, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.31,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
              color: color,
              fontFamily: "AcuminProWide",
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.height * 0.015),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: color,
          ),
        ),
      ),
    );
  }
}
