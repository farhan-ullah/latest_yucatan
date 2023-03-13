import 'package:provider/provider.dart';
import 'package:yucatan/components/custom_app_bar.dart';
import 'package:yucatan/models/activity_model.dart';
import 'package:yucatan/models/order_model.dart';
import 'package:yucatan/screens/payment_credit_card_screen/components/payment_credit_card_screen_parameter.dart';
import 'package:yucatan/screens/payment_credit_card_screen/components/payment_credit_card_screen_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:yucatan/utils/theme_model.dart';

class PaymentCreditCardScreen extends StatefulWidget {
  static const String route = '/payment/creditcard';

  @override
  _PaymentCreditCardScreenState createState() =>
      _PaymentCreditCardScreenState();
}

class _PaymentCreditCardScreenState extends State<PaymentCreditCardScreen> {
  @override
  Widget build(BuildContext context) {
    final PaymentCreditCardScreenParameter arguments = ModalRoute.of(context)!
        .settings
        .arguments as PaymentCreditCardScreenParameter;
    final ActivityModel activity = arguments.activity;
    final OrderModel order = arguments.order;

    return Scaffold(
      body: PaymentCreditCardScreenView(
        order: order,
        activity: activity,
      ),
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.paymentPayPalScreen_title,
        backgroundColor:
            Provider.of<ThemeModel>(context, listen: true).primaryMainColor,
        appBar: AppBar(),
        centerTitle: true,
      ),
    );
  }
}
