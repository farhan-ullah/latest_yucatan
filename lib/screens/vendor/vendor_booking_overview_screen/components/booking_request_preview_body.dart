import 'package:yucatan/models/transaction_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yucatan/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yucatan/utils/theme_model.dart';
import 'package:intl/intl.dart';

class VendorBookingPreviewBody extends StatelessWidget {
  final TransactionModel transactionModel;

  VendorBookingPreviewBody({
    required this.transactionModel,
  });

  @override
  Widget build(BuildContext context) {
    final displayHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.vendor_table_customer,
            style: _getTextStyle(displayHeight * 0.015, context)),
        SizedBox(height: displayHeight * 0.005),
        Text(transactionModel.buyer!,
            style: _getTextStyleBold(displayHeight * 0.018, context)),
        SizedBox(height: displayHeight * 0.01),
        Text("${DateFormat("dd.MM.yyyy").format(transactionModel.dateTime!)}",
            style: _getTextStyle(displayHeight * 0.015, context)),
        SizedBox(height: displayHeight * 0.01),
        Text(AppLocalizations.of(context)!.commonWords_booking,
            style: _getTextStyle(displayHeight * 0.018, context)),
        SizedBox(height: displayHeight * 0.005),
      ],
    );
  }

  _getTextStyle(fontSize, context) {
    return TextStyle(
      color: Provider.of<ThemeModel>(context, listen: true).primaryMainColor,
      fontFamily: CustomTheme.fontFamily,
      fontSize: fontSize,
      fontWeight: FontWeight.w200,
    );
  }

  _getTextStyleBold(fontSize, context) {
    return TextStyle(
      color: Provider.of<ThemeModel>(context, listen: true).primaryMainColor,
      fontFamily: CustomTheme.fontFamily,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );
  }
}
