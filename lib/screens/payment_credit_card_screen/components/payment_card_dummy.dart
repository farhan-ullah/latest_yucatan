import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:simple_tooltip/simple_tooltip.dart';
import 'package:yucatan/components/black_divider.dart';
import 'package:yucatan/screens/main_screen/main_screen.dart';
import 'package:yucatan/screens/payment_credit_card_screen/components/payment_credit_card_screen_view.dart';
import 'package:yucatan/theme/custom_theme.dart';
import 'package:yucatan/utils/theme_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yucatan/utils/widget_dimensions.dart';

import '../bloc/payment_credit_card_bloc.dart';

class PayemntDataDummy extends StatefulWidget {
  const PayemntDataDummy({super.key});

  @override
  State<PayemntDataDummy> createState() => _PayemntDataDummyState();
}

class _PayemntDataDummyState extends State<PayemntDataDummy> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PaymentCreditCardBloc bloc = PaymentCreditCardBloc();
  String maskedCardNumber = "";
  String maskedExpDate = "";
  bool _showToolTip = false;

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController expDateController = TextEditingController();
  TextEditingController cvcController = TextEditingController();
  TextEditingController cardHolderController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height -
              Dimensions.getScaledSize(60.0) -
              MediaQuery.of(context).padding.bottom,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Dimensions.getScaledSize(20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.getScaledSize(24.0),
                        right: Dimensions.getScaledSize(24.0)),
                    child: Text(
                      'Payment Successful',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Dimensions.getScaledSize(18.0),
                        color: Provider.of<ThemeModel>(context, listen: true)
                            .primaryMainColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.getScaledSize(20.0),
                  ),
                  BlackDivider(
                    height: Dimensions.getScaledSize(1.0),
                  ),
                  SizedBox(
                    height: Dimensions.getScaledSize(20.0),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.getScaledSize(24.0),
                        right: Dimensions.getScaledSize(24.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Dimensions.getScaledSize(10.0),
                        ),
                        Center(
                          child: Image.asset(
                            'lib/assets/images/payment.png',
                            height: MediaQuery.of(context).size.height * 0.3,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).padding.bottom +
                              Dimensions.getScaledSize(65),
                        ),
                        GestureDetector(
                          onTap: () {
                            // widget.onTap();
                            Navigator.of(context).pushNamed(MainScreen.route);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              top: Dimensions.getScaledSize(30.0),
                              bottom: Dimensions.getScaledSize(30.0),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  CustomTheme.borderRadius,
                                ),
                              ),
                              color:
                                  Provider.of<ThemeModel>(context, listen: true)
                                      .primaryMainColor,
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: Dimensions.getScaledSize(20.0),
                                  bottom: Dimensions.getScaledSize(20.0),
                                ),
                                child: Text(
                                  'Go to Main Screen',
                                  style: TextStyle(
                                      fontSize: Dimensions.getScaledSize(20),
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
